import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Controller/group_controller.dart';
import 'package:splitzy/Firebase%20Services/firebase_firestore_services.dart';
import 'package:splitzy/Firebase%20Services/google_auth_services.dart';
import 'package:splitzy/Screens/create_group_screen.dart';
import 'package:splitzy/Screens/group_expenses_screen.dart';
import 'package:splitzy/Screens/join_group_screen.dart';
import 'package:splitzy/Screens/personal_expense_screen.dart';
import 'package:splitzy/Screens/setting_screen.dart';

import '../Components/floating_button.dart';
import '../Components/greatings_toast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    GroupController controller = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        title: MultiTapButton(
          onSingleTap: () => showToast("Hey there:)", context),
          onDoubleTap: () => showToast("How are you?", context),
          onTripleTap: () => showToast("Why do you keep tapping?", context),
          onFourTaps: () => showToast("What do you want?", context),
          onFiveTaps: () => showToast("Break it off...", context),
          onSixTaps: () => showToast(
              "I'm not sure what you are\nhoping to achieve...", context),
          onSevenTaps: () =>
              showToast("You are enjoying this, aren't\nyou?", context),
          onEightTaps: () => showToast(
              "You've wasted about 30\nseconds of your time", context),
          onNineTaps: () =>
              showToast("on this absolutely dumb\nfeature", context),
          onTenTaps: () =>
              showToast("Just tapping, tapping, tapping...", context),
          child: Text(
            "Splitzy",
            style: GoogleFonts.playfairDisplay(
                fontSize: 47.sp, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () =>
                Get.to(const SettingScreen(), transition: Transition.fade),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 28.r, // Fixed radius
              backgroundImage: NetworkImage(
                GoogleAuthServices.googleAuthServices.currentUser()?.photoURL ??
                    "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
          // Fixed padding
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10.h), // Fixed space
            SizedBox(
              width: 320.w, // Width using screenutil
              child: Column(
                children: [
                  // Expense Box
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.to(const PersonalExpenseScreen(),
                          transition: Transition.fade);
                    },
                    child: Container(
                      height: 75.h, // Responsive height
                      width: 350.w, // Responsive width
                      decoration: BoxDecoration(
                        color: themeColor.secondary,
                        borderRadius: BorderRadius.circular(12.r),
                        border:
                            Border.all(color: themeColor.surface, width: 1.7.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        // Responsive padding
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Expenses",
                              style: GoogleFonts.playfairDisplay(
                                  color: themeColor.surface,
                                  fontSize: 20.sp), // Responsive font size
                            ),
                            Obx(
                              () => Text(
                                controller.personalTotal.toString(),
                                style: GoogleFonts.poppins(
                                    color: themeColor.surface,
                                    fontSize: 20.sp), // Responsive font size
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // Fixed space
                  // Tab Bar
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ButtonsTabBar(
                              width: 100.w,
                              height: 47.h,
                              radius: 12.r,
                              unselectedBorderColor: themeColor.surface,
                              borderWidth: 1.5.w,
                              unselectedLabelStyle: GoogleFonts.playfairDisplay(
                                  color: themeColor.surface),
                              labelStyle: GoogleFonts.playfairDisplay(
                                  color: themeColor.tertiary),
                              backgroundColor: themeColor.surface,
                              unselectedBackgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              contentCenter: true,
                              tabs: const [
                                Tab(text: "My Group"),
                                Tab(text: "Friends"),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                              height: 450.h, // Fixed height
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                dragStartBehavior: DragStartBehavior.start,
                                children: [
                                  // First Tab with StreamBuilder

                                  StreamBuilder<List<QuerySnapshot>>(
                                    stream: FirebaseFireStoreServices
                                        .firebaseFireStoreServices
                                        .dataShow()
                                        .asBroadcastStream(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<QuerySnapshot>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              "An error occurred: ${snapshot.error}"),
                                        );
                                      }

                                      // Check if there is no data
                                      if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Center(
                                          child: SvgPicture.asset(
                                              "assets/img/empty.svg"),
                                        );
                                      }

                                      // Combine all documents from each QuerySnapshot into a single list
                                      List<DocumentSnapshot> groupDocuments =
                                          snapshot.data!
                                              .expand((querySnapshot) =>
                                                  querySnapshot.docs)
                                              .toList();

                                      // Build ListView with combined document data
                                      return ListView.builder(
                                        itemCount: groupDocuments.length,
                                        itemBuilder: (context, index) {
                                          Map<String, dynamic>? groupData =
                                              groupDocuments[index].data()
                                                  as Map<String, dynamic>?;

                                          if (groupData == null) {
                                            return const Text(
                                                "Group data not found");
                                          }

                                          return CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              Get.to(
                                                GroupExpensesScreen(
                                                  name: groupData['groupName'],
                                                  code: groupData['groupCode']
                                                      .toString(),
                                                ),
                                                transition: Transition.fade,
                                              );
                                            },
                                            child: ListTile(
                                              title: Text(
                                                groupData['groupName'],
                                                style: GoogleFonts.raleway(
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              subtitle: Text(
                                                "Code :- ${groupData['groupCode'].toString()}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              trailing: Container(
                                                height: 40.h,
                                                width: 40.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          themeColor.surface),
                                                ),
                                                child: const Icon(Icons.add),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),

                                  // Second Tab with Obx for GetX state management
                                  Obx(() {
                                    if (controller.isLoading.value) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    return Column(
                                      children: [
                                        if (controller.uniqueFriends.isEmpty)
                                          SvgPicture.asset(
                                              "assets/img/friend.svg",
                                              height: 400.h)
                                        else
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: controller
                                                  .uniqueFriends.length,
                                              itemBuilder: (context, index) {
                                                var friendData = controller
                                                    .uniqueFriends[index];

                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.h),
                                                  child: ListTile(
                                                    minVerticalPadding: 20.h,
                                                    leading: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 50.h,
                                                      width: 50.w,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            friendData[
                                                                    'photoUrl'] ??
                                                                "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
                                                          ),
                                                        ),
                                                        color: themeColor
                                                            .secondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
                                                      ),
                                                    ),
                                                    title: Text(
                                                      friendData['name'] ??
                                                          "Unknown Friend",
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    trailing: Container(
                                                      height: 40.h,
                                                      width: 40.w,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: themeColor
                                                                .surface),
                                                      ),
                                                      child: const Icon(
                                                          Icons.navigate_next),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
        text: "New Group",
        onTap: () {
          showJoinCreateGroupBottomSheet(context, themeColor);
        },
        themeColor: themeColor,
      ),
    );
  }

  void showJoinCreateGroupBottomSheet(
      BuildContext context, ColorScheme themeColor) {
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
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  height: 4.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.to(CreateGroupScreen(), transition: Transition.fade);
                },
                child: ListTile(
                  leading: Icon(Icons.group_add,
                      color: themeColor.primary, size: 30.sp),
                  title: Text(
                    'Create Group',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: themeColor.surface,
                    ),
                  ),
                  subtitle: Text(
                    'Start a new group',
                    style:
                        TextStyle(color: themeColor.surface.withOpacity(0.5)),
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Get.to(JoinGroupScreen(), transition: Transition.fade);
                },
                child: ListTile(
                  leading:
                      Icon(Icons.group, color: themeColor.primary, size: 30.sp),
                  title: Text(
                    'Join Group',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: themeColor.surface,
                    ),
                  ),
                  subtitle: Text(
                    'Join an existing group with a code',
                    style:
                        TextStyle(color: themeColor.surface.withOpacity(0.5)),
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
}
