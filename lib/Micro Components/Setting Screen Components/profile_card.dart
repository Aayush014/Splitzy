import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Firebase Services/google_auth_services.dart';

class ProfileCard extends StatelessWidget {
  final ColorScheme themeColor;

  const ProfileCard({super.key, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 150.h,
      width: 320.h,
      decoration: BoxDecoration(
          color: themeColor.secondary,
          borderRadius: BorderRadius.circular(15.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10.h),
          Container(
            height: 70.h,
            width: 70.h,
            decoration: BoxDecoration(
              border: Border.all(color: themeColor.surface),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  GoogleAuthServices.googleAuthServices
                          .currentUser()
                          ?.photoURL ??
                      "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            GoogleAuthServices.googleAuthServices.currentUser()?.displayName ??
                'User',
            style: GoogleFonts.playfairDisplay(
                fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 7.sp,),
          Text(
            GoogleAuthServices.googleAuthServices.currentUser()!.email ??
                "admin@123@gmail.com",
            style: GoogleFonts.raleway(
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
