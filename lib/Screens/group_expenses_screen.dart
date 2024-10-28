import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Firebase%20Services/firebase_firestore_services.dart';
import 'package:splitzy/Firebase%20Services/google_auth_services.dart';
import 'package:splitzy/Micro%20Components/my_divider.dart';
import 'package:splitzy/Screens/add_new_expense.dart';

import '../Components/my_search_box.dart';
import '../Model/group_expense_model.dart';
import '../Model/user_model.dart';

class GroupExpensesScreen extends StatelessWidget {
  const GroupExpensesScreen(
      {super.key, required this.name, required this.code});

  final String code, name;

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    return StreamBuilder(
      stream:
          FirebaseFireStoreServices.firebaseFireStoreServices.userDataGet(code),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show loading while waiting for data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<UserModal> users = snapshot.data!.docs
            .map(
              (e) => UserModal.fromData(e.data() as Map),
            )
            .toList();
        return StreamBuilder(
          stream: FirebaseFireStoreServices.firebaseFireStoreServices
              .expenseDataGet(code),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Show loading while waiting for data
            } else if (snapshots.hasError) {
              return Text('Error: ${snapshots.error}');
            }

            List<GroupExpenseModal> expense = snapshots.data!.docs
                .map(
                  (e) => GroupExpenseModal.fromData(
                      e.data() as Map<String, dynamic>),
                )
                .toList();

            List expenseId = snapshots.data!.docs.map((e) => e.id).toList();
            String getMonthName(int month) {
              List<String> monthNames = [
                'Jan',
                'Feb',
                'March',
                'April',
                'May',
                'June',
                'July',
                'Aug',
                'Sept',
                'Oct',
                'Nov',
                'Dec'
              ];

              return monthNames[month - 1];
            }

            int totalAmount = 0;

            double owedAmount = 0;
            double owesAmount = 0;

            for (GroupExpenseModal expenses in expense) {
              totalAmount += int.parse(expenses.amount);
              if (expenses.userEmail ==
                  GoogleAuthServices.googleAuthServices.currentUser()!.email) {
                owedAmount += double.parse(expenses.userAmount);
              }
              for (UserExpenseModal userExpenseModal in expenses.userExpense) {
                if (userExpenseModal.email ==
                    GoogleAuthServices.googleAuthServices
                        .currentUser()!
                        .email) {
                  owesAmount += double.parse(userExpenseModal.amount);
                }
              }
            }

            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 70.h,
                automaticallyImplyLeading: false,
                title: Column(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 35.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${users.length.toString()} Member",
                      style: GoogleFonts.raleway(
                          fontSize: 15.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                actions: [
                  CupertinoButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.r),
                                topRight: Radius.circular(25.r),
                              ),
                            ),
                            padding: EdgeInsets.all(16.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "Group Settings",
                                    style: GoogleFonts.raleway(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: const Icon(Icons.cancel),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                groupListTile(
                                    themeColor, () {}, name, Icons.edit),
                                groupListTile(themeColor, () {}, "Add members",
                                    Icons.group_add),
                                groupListTile(themeColor, () {},
                                    "Share invite link", Icons.share),
                                const MyDivider(),
                                groupListTile(themeColor, () {
                                  FirebaseFireStoreServices
                                      .firebaseFireStoreServices
                                      .leaveGroup(code);
                                }, "Leave Group", Icons.logout),
                                groupListTile(themeColor, () {
                                  FirebaseFireStoreServices
                                      .firebaseFireStoreServices
                                      .deleteGroup(code);
                                  Navigator.of(context).pop();
                                }, "Delete Group", Icons.delete),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.settings,
                      size: 28.h,
                      color: themeColor.primary,
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  )
                ],
              ),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 75.h,
                            child: ListView.builder(
                              itemCount: users.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Container(
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: themeColor.surface),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                        users[index].url,
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
                      (owedAmount > owesAmount)
                          ? Align(
                              alignment: Alignment.center,
                              child: Text(
                                "You owed ${GoogleAuthServices.googleAuthServices.currentUser()!.displayName} ₹${owedAmount - owesAmount}",
                                style: GoogleFonts.raleway(
                                    fontSize: 20.sp,
                                    color: const Color(0xff79EA86)),
                              ))
                          : Align(
                              alignment: Alignment.center,
                              child: Text(
                                "You owes ${GoogleAuthServices.googleAuthServices.currentUser()!.displayName} ₹${owedAmount - owesAmount}",
                                style: GoogleFonts.raleway(
                                    fontSize: 20.sp,
                                    color: const Color(0xffe75757)),
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
                          itemCount: expense.length,
                          itemBuilder: (context, index) {
                            String currentAmount = '';
                            for (UserExpenseModal user
                                in expense[index].userExpense) {
                              if (user.email ==
                                  GoogleAuthServices.googleAuthServices
                                      .currentUser()!
                                      .email) {
                                currentAmount = user.amount;
                              }
                            }
                            return ListTile(
                              minTileHeight: 45.h,
                              onLongPress: () {
                                if (GoogleAuthServices.googleAuthServices
                                        .currentUser()!
                                        .email ==
                                    expense[index].userEmail) {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            topRight: Radius.circular(25.r),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(16.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              title: Text(
                                                "Expense actions",
                                                style: GoogleFonts.raleway(
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              trailing: CupertinoButton(
                                                padding: EdgeInsets.zero,
                                                child: const Icon(Icons.cancel),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            ListTile(
                                              trailing: Icon(Icons.history,
                                                  color: themeColor.primary,
                                                  size: 30.sp),
                                              title: Text(
                                                'Show history & comments',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: themeColor.surface,
                                                ),
                                              ),
                                            ),
                                            const MyDivider(),
                                            ListTile(
                                              onTap: () {
                                                FirebaseFireStoreServices
                                                    .firebaseFireStoreServices
                                                    .deleteExpense(
                                                        code, expenseId[index]);
                                                Navigator.pop(context);
                                              },
                                              trailing: Icon(Icons.delete,
                                                  color: Colors.red,
                                                  size: 30.sp),
                                              title: Text(
                                                'Delete',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              leading: Container(
                                alignment: Alignment.center,
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    color: themeColor.secondary,
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Text(
                                  "${expense[index].timestamp.toDate().day}\n${getMonthName(expense[index].timestamp.toDate().month)}",
                                  style: GoogleFonts.raleway(
                                      fontSize: 13.sp,
                                      color: themeColor.surface,
                                      height: 0.h),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              title: Text(
                                expense[index].title,
                                style: GoogleFonts.raleway(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "₹${expense[index].amount}",
                                style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300),
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
                                    (expense[index].userEmail ==
                                            GoogleAuthServices
                                                .googleAuthServices
                                                .currentUser()!
                                                .email)
                                        ? expense[index].userAmount
                                        : currentAmount,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      color: (expense[index].userEmail ==
                                              GoogleAuthServices
                                                  .googleAuthServices
                                                  .currentUser()!
                                                  .email)
                                          ? Colors.green
                                          : Colors.red,
                                      height: 1.2.h,
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
                              "₹$totalAmount",
                              style: GoogleFonts.poppins(
                                  fontSize: 17.sp, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        FloatingActionButton.extended(
                          shape: const StadiumBorder(),
                          extendedPadding:
                              EdgeInsets.symmetric(horizontal: 30.w),
                          icon: const Icon(Icons.add),
                          label: Text("Expense",
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Get.to(
                                AddNewExpense(
                                  code: code,
                                  userList: users,
                                ),
                                transition: Transition.fade);
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
          },
        );
      },
    );
  }
}

Widget groupListTile(
    var themeColor, Function()? onTap, String title, IconData icon) {
  return ListTile(
    onTap: onTap,
    trailing: Icon(icon, color: themeColor.primary, size: 25.sp),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: themeColor.surface,
      ),
    ),
  );
}
