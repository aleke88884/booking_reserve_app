import 'package:flutter/material.dart';

final Color kPrimaryColor = Color(0xFF1976D2); // Material Blue 700
final Color kSecondaryColor = Color(0xFF64B5F6); // Blue 300
final Color kBackgroundColor = Color(0xFFF5F5F5); // Light background
final Color kCardColor = Colors.white;
final Color kTextColor = Colors.black87;
final Color kDisabledColor = Colors.grey.shade400;

final ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBackgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  textTheme: TextTheme(
    headlineLarge:
        TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextColor),
    bodyLarge: TextStyle(fontSize: 16, color: kTextColor),
    bodyMedium: TextStyle(fontSize: 14, color: kTextColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  cardTheme: CardTheme(
    color: kCardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: kSecondaryColor,
  ),
);

final ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: Color(0xFF121212),
  appBarTheme: AppBarTheme(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  cardTheme: CardTheme(
    color: Color(0xFF1E1E1E),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E1E1E),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  ),
);
