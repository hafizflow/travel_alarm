import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';
import '../../../models/alarm_model.dart';

class AlarmListItem extends StatelessWidget {
  final AlarmModel alarm;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const AlarmListItem({
    super.key,
    required this.alarm,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(89.r),
      ),
      child: Row(
        children: [
          // Time and Date
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarm.formattedTime,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                Text(
                  alarm.formattedDate,
                  style: TextStyle(
                    color: AppColors.textGray,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Switch(
            value: alarm.isEnabled,
            onChanged: (_) => onToggle(),
            activeThumbColor: AppColors.textWhite,
            activeTrackColor: AppColors.lightPurple,
            inactiveThumbColor: AppColors.backgroundDark,
            inactiveTrackColor: AppColors.textWhite,
          ),
        ],
      ),
    );
  }
}
