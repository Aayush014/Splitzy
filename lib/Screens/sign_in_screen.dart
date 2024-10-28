import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:splitzy/Screens/home_screen.dart';

import '../Firebase Services/google_auth_services.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/logo.png",
              height: 200.h,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Splitzy",
              style: GoogleFonts.playfairDisplay(
                fontSize: 70.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.h,
              ),
              child: Divider(
                thickness: 2.h,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SignInButton(
              width: 250.h,
              buttonType: ButtonType.google,
              onPressed: () async {
                String status = await GoogleAuthServices.googleAuthServices
                    .signInWithGoogle();
                if (status == 'Success') {
                  Get.offAll( const HomeScreen());
                }
              },
              btnColor: Colors.black,
              btnTextColor: Colors.white,
              buttonSize: ButtonSize.large,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "By creating an account you\nagree with our privacy policy",
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.w500, fontSize: 15.sp),
            )
          ],
        ),
      ),
    );
  }
}