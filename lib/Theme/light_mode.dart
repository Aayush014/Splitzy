import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
  ),
  scaffoldBackgroundColor: Colors.grey.shade300,//300
  colorScheme: ColorScheme.light(
    primary: const Color(0xff29AB87),
    secondary: Colors.grey[350]!,//400
    tertiary: Colors.white,
    surface: Colors.black,
  ),
);