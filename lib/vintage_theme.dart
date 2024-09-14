import 'package:flutter/material.dart';

class VintageTheme {
  static const Color primaryColor = Color(0xFF6C4E31); // #6C4E31
  static const Color secondaryColor = Color(0xFF603F26); // #603F26
  static const Color backgroundColor = Color(0xFFFFEAC5); // #FFEAC5
  static const Color surfaceColor = Color(0xFFFFDBB5); // #FFDBB5
  static const Color errorColor = Color(0xFFB00020); // Standard error color
  static const Color onPrimaryColor =
      Color(0xFFFFFFFF); // Text color on primary
  static const Color onSecondaryColor =
      Color(0xFFFFFFFF); // Text color on secondary
  static const Color onBackgroundColor =
      Color(0xFF000000); // Text on background
  static const Color onSurfaceColor = Color(0xFF000000); // Text on surface
  static const Color onErrorColor = Color(0xFFFFFFFF); // Text on error

  static ThemeData get themeData {
    return ThemeData(
      colorScheme: const ColorScheme(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor, // Use `surface` instead of `background`
        background: backgroundColor,
        error: errorColor,
        onPrimary: onPrimaryColor,
        onSecondary: onSecondaryColor,
        onSurface: onSurfaceColor,
        onBackground: onBackgroundColor,
        onError: onErrorColor,
        brightness: Brightness.light, // Adjust for dark or light mode
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: primaryColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: primaryColor, fontSize: 16),
        bodyMedium: TextStyle(color: secondaryColor, fontSize: 14),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor, // Use surfaceColor for input fields
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: primaryColor),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        buttonColor: primaryColor,
      ),
    );
  }
}
