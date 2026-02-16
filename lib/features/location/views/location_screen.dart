import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:travel_alarm/constants/app_images.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../common_widgets/custom_button.dart';
import '../controllers/location_controller.dart';

class LocationScreen extends GetView<LocationController> {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                // Title
                Text(
                  AppStrings.locationTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 16.h),

                // Description
                Text(
                  AppStrings.locationDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textGray,
                    fontSize: 18.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 63.h),

                Image.asset(
                  AppImages.location,
                  width: 305.w,
                  height: 215.h,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 93.h),

                // Use Current Location Button
                Obx(
                  () => CustomButton(
                    text: AppStrings.useCurrentLocation,
                    onPressed: controller.requestLocationPermission,
                    isLoading: controller.isLoading.value,
                    icon: SvgPicture.asset(AppImages.locationlogo),
                    isOutlined: true,
                  ),
                ),
                SizedBox(height: 16.h),

                // Home Button (Skip)
                CustomButton(
                  text: AppStrings.home,
                  onPressed: controller.skipLocation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
