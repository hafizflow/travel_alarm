import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:travel_alarm/constants/app_images.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../controllers/home_controller.dart';
import '../widgets/alarm_list_item.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.selectedLocation,
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Location card
                    Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.locationhome),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                controller.location.value,
                                style: TextStyle(
                                  color: AppColors.textGray,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Alarms section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  AppStrings.alarms,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Alarms list
              Expanded(
                child: Obx(() {
                  if (controller.alarms.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alarm_off_rounded,
                            size: 80.sp,
                            color: AppColors.textDarkGray,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            AppStrings.noAlarmsYet,
                            style: TextStyle(
                              color: AppColors.textGray,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: controller.alarms.length,
                    itemBuilder: (context, index) {
                      final alarm = controller.alarms[index];
                      return AlarmListItem(
                        alarm: alarm,
                        onToggle: () => controller.toggleAlarm(alarm),
                        onDelete: () => controller.showDeleteDialog(alarm),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 40.h),
        child: SizedBox(
          width: 66.w,
          height: 66.w,
          child: FloatingActionButton(
            onPressed: controller.addAlarm,
            backgroundColor: AppColors.accentPurple,
            shape: const CircleBorder(),
            child: Icon(
              Icons.add_rounded,
              size: 34.sp,
              color: AppColors.textWhite,
            ),
          ),
        ),
      ),
    );
  }
}
