import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Firebase%20Services/google_auth_services.dart';
import 'package:splitzy/Micro%20Components/my_divider.dart';
import 'package:splitzy/Utils/auth_gate.dart';

import '../Controller/theme_controller.dart';
import '../Micro Components/Setting Screen Components/my_list_tile.dart';
import '../Micro Components/Setting Screen Components/my_switch.dart';
import '../Micro Components/Setting Screen Components/profile_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        title: Text(
          "My Account",
          style: GoogleFonts.playfairDisplay(
            fontSize: 38.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Column(
              children: [
                ProfileCard(
                  themeColor: themeColor,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListTile(
                  title: Text(
                    "Dark Theme",
                    style: GoogleFonts.raleway(
                        fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                  trailing: MySwitch(
                    onChanged: (p0) {
                      themeController.toggleTheme();
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                const MyDivider(),
                SizedBox(
                  height: 5.h,
                ),
                listTileWithSubTitle(
                  title: "Phone Number",

                  // subtitle: "00000 00000"
                  // subtitle: (GoogleAuthServices.googleAuthServices
                  //             .currentUser()
                  //             ?.phoneNumber !=
                  //         null)
                  //     ? GoogleAuthServices.googleAuthServices
                  //         .currentUser()
                  //         ?.phoneNumber
                  //     : "No phone number available",
                  subtitle: GoogleAuthServices.googleAuthServices
                          .currentUser()
                          ?.phoneNumber ??
                      '98790 04689',
                ),
                listTileWithSubTitle(
                  title: "Default Currency",
                  subtitle: "INR (₹)",
                ),
                listTileWithoutSubTitle(title: "Payment Info"),
                listTileWithoutSubTitle(title: "Preference"),
                const MyDivider(),
                listTileWithoutSubTitle(title: "FAQs"),
                listTileWithoutSubTitle(title: "Rate this app"),
                listTileWithoutSubTitle(title: "Contact Us"),
                listTileWithoutSubTitle(title: "Privacy"),
                const MyDivider(),
                Padding(
                  padding: EdgeInsets.only(top: 5.0.h),
                  child: ListTile(
                    onTap: () async {
                      await GoogleAuthServices.googleAuthServices.signOut();
                      Get.offAll(const AuthGate(), transition: Transition.fade);
                    },
                    title: Text(
                      "Log Out",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0.h,
                  ),
                  child: ListTile(
                    title: Text(
                      "v0.0.1",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
