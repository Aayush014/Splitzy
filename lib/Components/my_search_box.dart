import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchBox extends StatelessWidget {
  final ColorScheme themeColor;

  const MySearchBox({super.key, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        height: 50.h,
        width: 350.w,
        decoration: BoxDecoration(
            color: themeColor.secondary,
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            const Icon(Icons.search),
            SizedBox(
              width: 20.w,
            ),
            Text(
              "Search",
              style: GoogleFonts.raleway(
                fontSize: 20.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
