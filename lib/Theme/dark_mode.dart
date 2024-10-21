import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
  ),
  scaffoldBackgroundColor: Colors.grey.shade900,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xff29AB87),
    secondary: Colors.grey[850]!,
    tertiary: Colors.black,
    surface: Colors.white,
  ),
);

