import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Screens/add_new_expense.dart';

import '../Components/my_search_box.dart';
import '../Firebase Services/google_auth_services.dart';

class GroupExpensesScreen extends StatelessWidget {
  const GroupExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text(
              "Goa Trip",
              style: GoogleFonts.playfairDisplay(
                  fontSize: 35.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              "3 Member",
              style: GoogleFonts.raleway(
                  fontSize: 15.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          Icon(
            Icons.settings,
            size: 28.h,
            color: themeColor.primary,
          ),
          SizedBox(
            width: 10.h,
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              Row(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 75.h,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          width: 50.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: themeColor.surface),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                GoogleAuthServices.googleAuthServices
                                        .currentUser()
                                        ?.photoURL ??
                                    "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "You owed Darshan ₹400",
                    style: GoogleFonts.raleway(fontSize: 20.sp, color: const Color(0xff79EA86)),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "You owes Darshan ₹400",
                    style: GoogleFonts.raleway(fontSize: 20.sp, color: const Color(0xffe75757)),
                  )),
              SizedBox(
                height: 30.h,
              ),
              MySearchBox(
                themeColor: themeColor,
              ),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: liveIndex,
                  itemBuilder: (context, index) {
                    int liveIndex = 4;
                    return ListTile(
                      minTileHeight: 45.h,
                      leading: Container(
                        alignment: Alignment.center,
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            color: themeColor.secondary,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Text(
                          "23\nSept",
                          style: GoogleFonts.raleway(
                              fontSize: 13.sp,
                              color: themeColor.surface,
                              height: 0.h),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      title: Text(
                        "Food",
                        style: GoogleFonts.raleway(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        "₹100",
                        style: GoogleFonts.poppins(
                            fontSize: 15.sp, fontWeight: FontWeight.w300),
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            "You get",
                            style: GoogleFonts.raleway(
                                fontSize: 15.sp,
                                color: themeColor.surface,
                                height: 0.h,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "₹300",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: (liveIndex % 2 == 0)
                                  ? Colors.green
                                  : Colors.red,
                              height: 1.2.h,
                              // Adjust this as needed, or remove it
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      // ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Group spending",
                      style: GoogleFonts.raleway(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹1200",
                      style: GoogleFonts.poppins(
                          fontSize: 17.sp, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                FloatingActionButton.extended(
                  shape: const StadiumBorder(),
                  extendedPadding: EdgeInsets.symmetric(horizontal: 30.w),
                  icon: const Icon(Icons.add),
                  label: Text("Expense",style: GoogleFonts.raleway(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Get.to(const AddNewExpense(),transition: Transition.fade);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}

var liveIndex = 4;
