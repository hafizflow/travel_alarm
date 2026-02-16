import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../helpers/storage_helper.dart';

class LocationController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString locationText = ''.obs;
  final Rx<Position?> currentPosition = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocation();
  }

  void _loadSavedLocation() {
    final savedLocation = StorageHelper().savedLocation;
    if (savedLocation != null) {
      locationText.value = savedLocation;
    }
  }

  Future<void> requestLocationPermission() async {
    isLoading.value = true;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'Location Disabled',
          'Please enable location services',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog();
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        _showOpenSettingsDialog();
        return;
      }

      await getCurrentLocation();
    } finally {
      isLoading.value = false;
    }
  }

  void _showPermissionDeniedDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Location Permission Needed'),
        content: const Text(
          'Location access is required to set travel alarms based on your location.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              requestLocationPermission();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showOpenSettingsDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Enable Location in Settings'),
        content: const Text(
          'Location permission has been permanently denied. '
          'Please enable it from app settings.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Get.back();
              await Geolocator.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;

    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'Permission Denied',
          'Location permission is required',
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading.value = false;
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;

      // Get address from coordinates
      await getAddressFromCoordinates(position.latitude, position.longitude);

      // Navigate to home
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get location: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        String address = '';
        if (place.locality != null && place.locality!.isNotEmpty) {
          address = place.locality!;
        }
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty) {
          address += address.isEmpty
              ? place.administrativeArea!
              : ', ${place.administrativeArea}';
        }
        if (place.country != null && place.country!.isNotEmpty) {
          address += address.isEmpty ? place.country! : ', ${place.country}';
        }

        locationText.value = address.isEmpty ? 'Unknown Location' : address;
        await StorageHelper().saveLocation(locationText.value);
      }
    } catch (e) {
      locationText.value =
          'Lat: ${latitude.toStringAsFixed(4)}, Lon: ${longitude.toStringAsFixed(4)}';
      await StorageHelper().saveLocation(locationText.value);
    }
  }

  void skipLocation() {
    locationText.value = 'Location not set';
    StorageHelper().saveLocation(locationText.value);
    Get.offAllNamed('/home');
  }
}
