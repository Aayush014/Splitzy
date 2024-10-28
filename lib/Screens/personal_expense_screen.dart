import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Controller/group_controller.dart';
import 'package:splitzy/Firebase%20Services/firebase_firestore_services.dart';
import 'package:splitzy/Model/expense_modal.dart';
import 'package:splitzy/Screens/personal_add_new_expanse_screen.dart';

import '../Components/floating_button.dart';

class PersonalExpenseScreen extends StatefulWidget {
  const PersonalExpenseScreen({super.key});

  @override
  State<PersonalExpenseScreen> createState() => _PersonalExpenseScreenState();
}

class _PersonalExpenseScreenState extends State<PersonalExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    var controller = Get.put(GroupController());
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
            width: 10.w,
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
                style: GoogleFonts.raleway(fontSize: 15.sp),
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
                  borderRadius: BorderRadius.circular(12.r),
                ),
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              StreamBuilder(
                stream: FirebaseFireStoreServices.firebaseFireStoreServices
                    .expenseDataPersonGet(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  List<ExpenseModal> data = snapshot.data!.docs
                      .map(
                        (e) => ExpenseModal.fromData(e.data() as Map),
                  )
                      .toList();

                  List dataId = snapshot.data!.docs
                      .map(
                        (e) => e.id,
                  )
                      .toList();

                  if(data.isNotEmpty)
                    {
                      Timer(Duration(seconds: 5), () {
                        setState(() {
                          controller.calculateTotalAmount(data);
                        });
                      },);
                    }

                  String getMonthName(int month) {
                    List<String> monthNames = [
                      'Jan', 'Feb', 'March', 'April', 'May', 'June', 'July',
                      'Aug', 'Sept', 'Oct', 'Nov', 'Dec'
                    ];
                    return monthNames[month - 1];
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        minVerticalPadding: 10.h,
                        leading: Container(
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              color: themeColor.secondary,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Text(
                            "${data[index].timestamp.toDate().day}\n${getMonthName(data[index].timestamp.toDate().month)}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: themeColor.surface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        title: Text(
                          data[index].title,
                          style: GoogleFonts.raleway(
                              fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "₹${data[index].amount}",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, fontWeight: FontWeight.w300),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            FirebaseFireStoreServices.firebaseFireStoreServices
                                .setDataPersonExpenseDelete(dataId[index]);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        text: "Add Expense",
        onTap: () {
          Get.to(const PersonalAddNewExpanseScreen());
        },
        themeColor: themeColor,
      ),
    );
  }
}
