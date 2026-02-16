import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/storage_helper.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  final int totalPages = 3;

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    await StorageHelper().setOnboardingCompleted();
    Get.offAllNamed('/location');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
