import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final ColorScheme themeColor;

  const FloatingButton({super.key, required this.text, required this.onTap, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 52.h,
        width: 205.w,
        decoration: BoxDecoration(
          color: themeColor.primary,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          text,
          style:
          GoogleFonts.playfair(fontSize: 20.sp, fontWeight: FontWeight.bold,color: themeColor.tertiary),
        ),
      ),
    );
  }
}