import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:splitzy/Components/my_text_field.dart';
import '../Components/floating_button.dart';
import 'join_group_screen.dart';  // Import the GroupController

class CreateGroupScreen extends StatelessWidget {

  CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        title: Text(
          "Create Group",
          style: GoogleFonts.playfairDisplay(
              fontSize: 38.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
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
              padding: EdgeInsets.all(16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text("Enter a unique group name for your group.",
                      style: GoogleFonts.raleway()),
                  SizedBox(height: 15.h),
                  Card(
                    color: Colors.transparent,
                    child: MyTextField(
                        themeColor: themeColor,
                        hintText: "  Enter Group Name",
                        color: themeColor.surface),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "To create a group :",
                    style: GoogleFonts.raleway(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  Text("\n   ●  Group name must be unique.",
                      style: GoogleFonts.raleway()),
                  Text("   ●  Name have at least 4 characters.",
                      style: GoogleFonts.raleway()),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          TextButton(
            onPressed: () {
              // Navigate to Join Group Screen
              Get.to(JoinGroupScreen());
            },
            child: Text(
              'Already have a group? Join one',
              style: GoogleFonts.raleway(color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        text: "Create Group",
        onTap: () {
        },
        themeColor: themeColor,
      ),
    );
  }
}
