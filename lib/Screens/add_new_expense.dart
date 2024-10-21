import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Components/floating_button.dart';
import 'package:splitzy/Components/my_category_box.dart';
import 'package:splitzy/Components/my_text_field.dart';

class AddNewExpense extends StatelessWidget {
  const AddNewExpense({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        title: Text(
          "Add New Expense",
          style: GoogleFonts.playfairDisplay(
              fontSize: 31.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Expense Title",
                style: GoogleFonts.raleway(
                  fontSize: 16.sp,
                ),
              ),
              MyTextField(themeColor: themeColor,hintText: "Add Title here",color: themeColor.secondary,),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Select Category (Optional)",
                style: GoogleFonts.raleway(
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 110.h,
                child: ListView.builder(
                  itemCount: 7,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      MyCategoryBox(themeColor: themeColor),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        text: "Save",
        onTap: () {},
        themeColor: themeColor,
      ),
    );
  }
}
