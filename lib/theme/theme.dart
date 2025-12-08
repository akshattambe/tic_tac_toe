import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF3B82F6),
    scaffoldBackgroundColor: const Color(0xFFF3F4F6),
    cardColor: Colors.white,
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayMedium: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
      headlineSmall: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
      bodyMedium: const TextStyle(
        fontSize: 16,
        color: Color(0xFF4B5563),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF1F2937)),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF3B82F6),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF60A5FA),
    scaffoldBackgroundColor: const Color(0xFF111827),
    cardColor: const Color(0xFF1F2937),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayMedium: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineSmall: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: const TextStyle(
        fontSize: 16,
        color: Color(0xFFD1D5DB),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F2937),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF60A5FA),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}
