import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Components/my_text_field.dart';
import 'package:splitzy/Firebase%20Services/firebase_firestore_services.dart';

import '../Components/floating_button.dart'; // Add this in pubspec.yaml

class JoinGroupScreen extends StatelessWidget {
  final TextEditingController groupIdController = TextEditingController();

  JoinGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        title: Text(
          "Join Group",
          style: GoogleFonts.playfairDisplay(
              fontSize: 38.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Card(
              color: themeColor.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 8,
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: Padding(
                padding: EdgeInsets.all(16.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "Ask your friend for the group code, then enter it here.",
                      style: GoogleFonts.raleway(),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Card(
                      color: Colors.transparent,
                      child: MyTextField(
                          controller: groupIdController,
                          themeColor: themeColor,
                          hintText: "  Enter Group ID",
                          color: themeColor.surface),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "To sign in with a group code :",
                      style: GoogleFonts.raleway(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\n   ●  Use an authorized account.",
                      style: GoogleFonts.raleway(),
                    ),
                    Text(
                      "   ●  Use group code with 6 character.",
                      style: GoogleFonts.raleway(),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () {
                // Navigate to Create Group Screen
              },
              child: Text(
                'Don’t have a group? Create one',
                style: GoogleFonts.raleway(color: themeColor.surface),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
          text: "Join Group", onTap: () {
        FirebaseFireStoreServices.firebaseFireStoreServices.joinToAccount(groupIdController.text);
        Navigator.pop(context);

      }, themeColor: themeColor),
    );
  }
}
