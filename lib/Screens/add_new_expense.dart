import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Components/floating_button.dart';
import 'package:splitzy/Components/my_text_field.dart';
import 'package:splitzy/Controller/group_controller.dart';
import 'package:splitzy/Firebase%20Services/firebase_firestore_services.dart';
import 'package:splitzy/Firebase%20Services/google_auth_services.dart';
import '../Model/group_expense_model.dart';
import '../Model/user_model.dart';

class AddNewExpense extends StatelessWidget {
  final String code;
  final List<UserModal> userList;

  const AddNewExpense({super.key, required this.code, required this.userList});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtTitle = TextEditingController();
    TextEditingController txtAmount = TextEditingController();
    var themeColor = Theme.of(context).colorScheme;
    GroupController controller = Get.put(GroupController());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Form(
          key: controller.globalKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                ExpenseTitleInput(themeColor: themeColor, controller: txtTitle),
                SizedBox(height: 30.h),
                ExpenseAmountInput(themeColor: themeColor, controller: txtAmount),
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
            List<UserExpenseModal> userExpense = [];
            for (UserModal user in userList) {
              if (GoogleAuthServices.googleAuthServices.currentUser()!.email !=
                  user.email) {
                userExpense.add(UserExpenseModal(
                    amount: "${int.parse(txtAmount.text) / userList.length}",
                    email: user.email));
              }
            }
            GroupExpenseModal expenseModal = GroupExpenseModal(
                title: txtTitle.text,
                amount: txtAmount.text,
                userAmount:
                "${int.parse(txtAmount.text) - (int.parse(txtAmount.text) / userList.length)}",
                userEmail:
                GoogleAuthServices.googleAuthServices.currentUser()!.email!,
                timestamp: Timestamp.fromDate(DateTime.now()),
                userExpense: userExpense);

            FirebaseFireStoreServices.firebaseFireStoreServices
                .setDataExpense(code, expenseModal);
            Navigator.pop(context);
          }
        },
        themeColor: themeColor,
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Add New Expense",
        style: GoogleFonts.playfairDisplay(
            fontSize: 31.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ExpenseTitleInput extends StatelessWidget {
  final ColorScheme themeColor;
  final TextEditingController controller;

  const ExpenseTitleInput({super.key, required this.themeColor, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expense Title",
          style: GoogleFonts.raleway(fontSize: 16.sp),
        ),
        MyTextField(
          themeColor: themeColor,
          controller: controller,
          hintText: "Add Title here",
          color: themeColor.secondary,
        ),
      ],
    );
  }
}

class ExpenseAmountInput extends StatelessWidget {
  final ColorScheme themeColor;
  final TextEditingController controller;

  const ExpenseAmountInput({super.key, required this.themeColor, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expense Amount",
          style: GoogleFonts.raleway(fontSize: 16.sp),
        ),
        MyTextField(
          themeColor: themeColor,
          controller: controller,
          textInputType: TextInputType.number,
          hintText: "Add Amount here",
          color: themeColor.secondary,
        ),
      ],
    );
  }
}
