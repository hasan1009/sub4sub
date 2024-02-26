import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubAppTheme {
  static ThemeData lightTheme = ThemeData(brightness: Brightness.light);
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 20,
        ),
        headlineSmall: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
        ),
        bodySmall: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
        ),
      ));
}
