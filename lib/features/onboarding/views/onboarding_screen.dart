import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_alarm/common_widgets/custom_button.dart';
import 'package:travel_alarm/constants/app_colors.dart';
import 'package:travel_alarm/constants/app_images.dart';
import 'package:travel_alarm/constants/app_strings.dart';
import 'package:travel_alarm/features/onboarding/controllers/onboarding_controller.dart';
import 'package:travel_alarm/features/onboarding/widgets/onboarding_page.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Stack(
          children: [
            // PageView - needs proper constraints
            Positioned.fill(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  OnboardingPage(
                    title: AppStrings.onboarding1Title,
                    description: AppStrings.onboarding1Description,
                    imagePath: AppImages.onboarding1,
                  ),
                  OnboardingPage(
                    title: AppStrings.onboarding2Title,
                    description: AppStrings.onboarding2Description,
                    imagePath: AppImages.onboarding2,
                  ),
                  OnboardingPage(
                    title: AppStrings.onboarding3Title,
                    description: AppStrings.onboarding3Description,
                    imagePath: AppImages.onboarding3,
                  ),
                ],
              ),
            ),

            // Skip button
            Positioned(
              top: 70.h,
              right: 22.w,
              child: TextButton(
                onPressed: controller.skipOnboarding,
                child: Text(
                  AppStrings.skip,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // Page indicator
            Positioned(
              top: 650.h,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: controller.pageController,
                  count: controller.totalPages,
                  effect: WormEffect(
                    dotWidth: 8.w,
                    dotHeight: 8.h,
                    activeDotColor: AppColors.accentPurple,
                    dotColor: AppColors.textGray.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),

            // Next button
            Positioned(
              bottom: 60.h,
              left: 22.w,
              right: 22.w,
              child: CustomButton(
                text: AppStrings.next,
                onPressed: controller.nextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
