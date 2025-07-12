import 'package:flutter/material.dart';

class CatalogConstants {
  // Colors
  static const Color primaryColor = Color(0xFF6366F1);
  static const Color errorColor = Colors.red;
  static const Color textGreyColor = Colors.grey;

  // Dimensions
  static const double cardElevation = 4.0;
  static const double iconSize = 64.0;
  static const double largeIconSize = 80.0;
  static const double borderRadius = 8.0;
  static const double padding = 16.0;
  static const double smallPadding = 8.0;
  static const double spacing = 16.0;
  static const double smallSpacing = 8.0;

  // Grid settings
  static const int crossAxisCount = 2;
  static const double childAspectRatio = 0.8;
  static const double crossAxisSpacing = 8.0;
  static const double mainAxisSpacing = 8.0;

  // Animation
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOut;

  // Text styles
  static const TextStyle titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle subtitleStyle = TextStyle(fontSize: 16, color: textGreyColor);

  static const TextStyle productNameStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

  static const TextStyle priceStyle = TextStyle(color: primaryColor, fontWeight: FontWeight.bold);

  static const TextStyle errorTextStyle = TextStyle(fontSize: 16);
}
