import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/alarm_model.dart';
import '../../../helpers/storage_helper.dart';
import '../../../helpers/notification_helper.dart';
import '../../../constants/app_strings.dart';

class HomeController extends GetxController {
  final RxList<AlarmModel> alarms = <AlarmModel>[].obs;
  final RxString location = ''.obs;
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    location.value =
        StorageHelper().savedLocation ?? AppStrings.addYourLocation;
    alarms.value = StorageHelper().getAlarms();
  }

  Future<void> addAlarm() async {
    final result = await _showDateTimePicker();
    if (result != null) {
      // Check if the selected time is in the future
      final now = DateTime.now();
      DateTime alarmDateTime = result;

      if (result.isBefore(now)) {
        // Show warning that alarm was moved to tomorrow
        Get.dialog(
          AlertDialog(
            backgroundColor: const Color(0xFF1E2347),
            title: const Text(
              'Time Adjusted',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'The selected time has passed. The alarm has been set for tomorrow at the same time.',
              style: TextStyle(color: Color(0xFFB8BED9)),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  // Add one day to the alarm
                  alarmDateTime = result.add(const Duration(days: 1));
                  _saveAlarm(alarmDateTime);
                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      } else {
        _saveAlarm(alarmDateTime);
      }
    }
  }

  Future<void> _saveAlarm(DateTime alarmDateTime) async {
    final alarm = AlarmModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      dateTime: alarmDateTime,
      isEnabled: true,
    );

    await StorageHelper().addAlarm(alarm);
    alarms.add(alarm);

    // Schedule notification
    try {
      await _notificationHelper.scheduleAlarm(
        id: int.parse(alarm.id.substring(alarm.id.length - 9)),
        title: AppStrings.alarmNotificationTitle,
        body: AppStrings.alarmNotificationBody,
        scheduledTime: alarm.dateTime,
      );

      Get.snackbar(
        'Success',
        AppStrings.alarmSet,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // If scheduling fails, remove the alarm
      await StorageHelper().deleteAlarm(alarm.id);
      alarms.removeWhere((a) => a.id == alarm.id);

      Get.snackbar(
        'Error',
        'Failed to schedule alarm: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<DateTime?> _showDateTimePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6C3EFF),
              surface: Color(0xFF1E2347),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null) return null;

    if (!Get.context!.mounted) return null;

    TimeOfDay? selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6C3EFF),
              surface: Color(0xFF1E2347),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime == null) return null;

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  Future<void> toggleAlarm(AlarmModel alarm) async {
    final updatedAlarm = alarm.copyWith(isEnabled: !alarm.isEnabled);
    await StorageHelper().updateAlarm(updatedAlarm);

    final index = alarms.indexWhere((a) => a.id == alarm.id);
    if (index != -1) {
      alarms[index] = updatedAlarm;
    }

    // Update notification
    if (updatedAlarm.isEnabled) {
      try {
        // Check if the alarm time has passed
        final now = DateTime.now();
        final isInPast = alarm.dateTime.isBefore(now);

        await _notificationHelper.scheduleAlarm(
          id: int.parse(alarm.id.substring(alarm.id.length - 9)),
          title: AppStrings.alarmNotificationTitle,
          body: AppStrings.alarmNotificationBody,
          scheduledTime: updatedAlarm.dateTime,
        );

        // If the alarm was in the past, inform the user it was rescheduled
        if (isInPast) {
          Get.snackbar(
            'Alarm Enabled',
            'This alarm has been rescheduled for the next occurrence at ${alarm.formattedTime}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        // If scheduling fails, show error and disable
        final disabledAlarm = updatedAlarm.copyWith(isEnabled: false);
        await StorageHelper().updateAlarm(disabledAlarm);
        if (index != -1) {
          alarms[index] = disabledAlarm;
        }

        Get.snackbar(
          'Error',
          'Failed to enable alarm: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      await _notificationHelper.cancelAlarm(
        int.parse(alarm.id.substring(alarm.id.length - 9)),
      );
    }
  }

  Future<void> deleteAlarm(AlarmModel alarm) async {
    await StorageHelper().deleteAlarm(alarm.id);
    alarms.removeWhere((a) => a.id == alarm.id);

    await _notificationHelper.cancelAlarm(
      int.parse(alarm.id.substring(alarm.id.length - 9)),
    );

    Get.snackbar(
      'Success',
      AppStrings.alarmDeleted,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  Future<void> showDeleteDialog(AlarmModel alarm) async {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E2347),
        title: const Text(
          'Delete Alarm',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this alarm?',
          style: TextStyle(color: Color(0xFFB8BED9)),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              deleteAlarm(alarm);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
