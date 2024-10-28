import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Components/floating_button.dart';
import 'package:splitzy/Components/my_text_field.dart';
import 'package:splitzy/Controller/group_controller.dart';
import 'package:splitzy/Firebase%20Services/firebase_firestore_services.dart';
import 'package:splitzy/Model/expense_modal.dart';

class PersonalAddNewExpanseScreen extends StatelessWidget {
  const PersonalAddNewExpanseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtTitle = TextEditingController();
    TextEditingController txtAmount = TextEditingController();
    var themeColor = Theme.of(context).colorScheme;
    GroupController controller = Get.put(GroupController());
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
        child: Form(
          key: controller.globalKey,
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
                MyTextField(
                  themeColor: themeColor,
                  controller: txtTitle,
                  hintText: "Add Title here",
                  color: themeColor.secondary,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Expense amount",
                  style: GoogleFonts.raleway(
                    fontSize: 16.sp,
                  ),
                ),
                MyTextField(
                  themeColor: themeColor,
                  controller: txtAmount,
                  textInputType: TextInputType.number,
                  hintText: "Add Amount here",
                  color: themeColor.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        text: "Save",
        onTap: () {
          if (controller.globalKey.currentState!.validate()) {
            ExpenseModal expenseModal = ExpenseModal(
                title: txtTitle.text,
                amount: txtAmount.text,
                timestamp: Timestamp.fromDate(DateTime.now()));
            FirebaseFireStoreServices.firebaseFireStoreServices
                .setDataPersonExpense(expenseModal);
            Navigator.pop(context);
          }
        },
        themeColor: themeColor,
      ),
    );
  }
}
