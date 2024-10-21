import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/create_button.dart';

Widget listTileWithSubTitle({required String title, subtitle}) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 5.0.h),
    child: ListTile(
      title: Text(
        title,
        style: GoogleFonts.raleway(fontSize: 15.sp, fontWeight: FontWeight.w400),
      ),
      subtitle: Text(
        subtitle,
        style:  TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget listTileWithoutSubTitle({required String title}) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 5.0.h),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
