import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitzy/Firebase%20Services/google_auth_services.dart';
import 'package:splitzy/Micro%20Components/my_divider.dart';
import 'package:splitzy/Utils/auth_gate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/theme_controller.dart';
import '../Micro Components/Setting Screen Components/my_switch.dart';
import '../Micro Components/Setting Screen Components/profile_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
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
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Column(
            children: [
              ProfileCard(themeColor: themeColor),
              SizedBox(height: 20.h),
              _buildThemeToggle(themeController),
              const MyDivider(),
              _buildListTile("Phone Number",
                  subtitle: GoogleAuthServices.googleAuthServices
                          .currentUser()
                          ?.phoneNumber ??
                      '98790 04689'),
              _buildListTile("Default Currency", subtitle: "INR (₹)"),
              _buildListTile("Payment Info"),
              _buildListTile("Preference"),
              const MyDivider(),
              _buildListTile("FAQs"),
              _buildListTile("Rate this app",onTap: () {
                Uri url = Uri.parse("https://forms.gle/nCBCAQtUadBmYtJn9");
                launchUrl(url);
              },),
              _buildListTile("Contact Us"),
              _buildListTile("Privacy"),
              const MyDivider(),
              _buildLogoutTile(themeColor),
              _buildVersionInfo(themeColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(ThemeController themeController) {
    return ListTile(
      title: Text(
        "Dark Theme",
        style:
            GoogleFonts.raleway(fontSize: 18.sp, fontWeight: FontWeight.w500),
      ),
      trailing: MySwitch(onChanged: (p0) => themeController.toggleTheme()),
    );
  }

  Widget _buildListTile(String title, {String? subtitle,void Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style:
            GoogleFonts.raleway(fontSize: 18.sp, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }

  Widget _buildLogoutTile(ColorScheme themeColor) {
    return ListTile(
      onTap: () async {
        await GoogleAuthServices.googleAuthServices.signOut();
        Get.offAll(const AuthGate(), transition: Transition.fade);
      },
      title: Text(
        "Log Out",
        style: TextStyle(
            fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.red),
      ),
    );
  }

  Widget _buildVersionInfo(ColorScheme themeColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: ListTile(
        title: Text(
          "v0.0.1",
          style: TextStyle(
              color: themeColor.surface,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}