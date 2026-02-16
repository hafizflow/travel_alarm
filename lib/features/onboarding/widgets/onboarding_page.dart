import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String? imagePath;
  final Widget? imageWidget;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    this.imagePath,
    this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32.r),
            bottomRight: Radius.circular(32.r),
          ),
          child: imagePath != null
              ? Image.asset(
                  imagePath!,
                  width: 1.sw,
                  height: 429.h,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 1.sw,
                  height: 429.h,
                  alignment: Alignment.center,
                  child: imageWidget,
                ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textWhite,
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.textWhite,
            ),
          ),
        ),
      ],
    );
  }
}
