import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCategoryBox extends StatelessWidget {
  final ColorScheme themeColor;
  const MyCategoryBox({super.key, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 100.h,
        decoration: BoxDecoration(
            border: Border.all(color: themeColor.surface, width: 1.5.w),
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.fastfood,
              size: 30.sp,
            ),
            Text(
              "Food & Drink",
              style: TextStyle(fontSize: 15.sp),
            )
          ],
        ),
      ),
    );
  }
}
