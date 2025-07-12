import 'package:flutter/material.dart';

class AppConstants {
  // App info
  static const String appTitle = 'POS System';

  // Colors
  static const Color primaryColor = Color(0xFF6366F1);
  static const Color snackbarBackgroundColor = Color(0xFF6366F1);
  static const Color snackbarTextColor = Colors.white;
  static const Color progressBackgroundColor = Colors.white24;
  static const Color progressValueColor = Colors.white;

  // Dimensions
  static const double snackbarWidth = 140.0;
  static const double snackbarBorderRadius = 12.0;
  static const double snackbarElevation = 6.0;
  static const double progressSize = 20.0;
  static const double progressStrokeWidth = 2.0;
  static const double spacing = 8.0;

  // Padding
  static const EdgeInsets snackbarPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 16);

  // Duration
  static const Duration snackbarDuration = Duration(seconds: 5);
  static const Duration progressDuration = Duration(seconds: 5);

  // Text styles
  static const TextStyle snackbarTextStyle = TextStyle(color: snackbarTextColor);

  // Theme
  static ThemeData get appTheme => ThemeData(
    primarySwatch: Colors.indigo, 
    useMaterial3: true
  );
}
