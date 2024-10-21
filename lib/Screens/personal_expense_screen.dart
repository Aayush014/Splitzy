import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/floating_button.dart';

class PersonalExpenseScreen extends StatelessWidget {
  const PersonalExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        title: Text(
          "My Expense",
          style: GoogleFonts.playfairDisplay(
              fontSize: 38.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.settings,
            size: 28.sp,
            color: themeColor.primary,
          ),
          SizedBox(
            width: 10.w,  // Use .w for width
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(
                "This screen can track your personal expenses. Your groups on Splitzy from now will be automatically added.",
                style: GoogleFonts.raleway(fontSize: 15.sp),  // Use .sp for text scaling
              ),
              SizedBox(
                height: 40.h,
              ),
              Container(
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
                        fontSize: 17.sp,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ListTile(
                minVerticalPadding: 10.h,
                leading: Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      color: themeColor.secondary,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: const Icon(Icons.fastfood),
                ),
                title: Text(
                  "Food",
                  style: GoogleFonts.raleway(
                      fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  "₹100",
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, fontWeight: FontWeight.w300),
                ),
                trailing: Text(
                  "23\nSept",
                  style: TextStyle(
                      fontSize: 14.sp, color: themeColor.surface, height: 1.5.h),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        text: "Add Expense",
        onTap: () {}, themeColor: themeColor,
      ),
    );
  }
}
