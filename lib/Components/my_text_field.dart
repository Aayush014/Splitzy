import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final ColorScheme themeColor;
  final String hintText;
  final Color color;
  const MyTextField({super.key, required this.themeColor, required this.hintText,required this.color,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        cursorColor: themeColor.surface,
        cursorHeight: 30,
        cursorWidth: 3,
        style: TextStyle(fontSize: 30, color: themeColor.onSurface),
        // Text style when typing
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.raleway(
            fontSize: 25,
            color: color,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
