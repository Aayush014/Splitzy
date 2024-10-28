import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitzy/Theme/dark_mode.dart';
import 'package:splitzy/Theme/light_mode.dart';

class ThemeController extends GetxController {
  static const String themeKey = 'isDarkMode';

  // Reactive boolean to observe the theme status
  RxBool isDarkMode = true.obs;

  // Load the theme from SharedPreferences
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool(themeKey) ?? false;
  }

  // Toggle the theme and save it in SharedPreferences
  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDarkMode.value);
  }

  // Get the current theme based on `isDarkMode`
  ThemeData get currentTheme => isDarkMode.value ? darkMode : lightMode;
}
