import 'package:flutter/material.dart';

class CartConstants {
  // Colors
  static const Color primaryColor = Color(0xFF6366F1);
  static const Color errorColor = Colors.red;
  static const Color textGreyColor = Colors.grey;
  static const Color successColor = Colors.green;
  static const Color discountColor = Color(0xFF4CAF50);

  // Dimensions
  static const double cardElevation = 4.0;
  static const double iconSize = 64.0;
  static const double largeIconSize = 80.0;
  static const double smallIconSize = 16.0;
  static const double borderRadius = 8.0;
  static const double largeBorderRadius = 16.0;
  static const double padding = 16.0;
  static const double smallPadding = 8.0;
  static const double spacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double itemImageSize = 50.0;
  static const double dividerHeight = 24.0;

  // Animation
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOut;

  // Text styles
  static const TextStyle titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle subtitleStyle = TextStyle(fontSize: 16, color: textGreyColor);

  static const TextStyle errorTextStyle = TextStyle(fontSize: 16);

  static const TextStyle sectionTitleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle itemNameStyle = TextStyle(fontWeight: FontWeight.w500);

  static const TextStyle priceStyle = TextStyle(color: primaryColor, fontWeight: FontWeight.bold);

  static const TextStyle totalStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle discountTextStyle = TextStyle(color: discountColor, fontWeight: FontWeight.w500);

  static const TextStyle vatTextStyle = TextStyle(fontSize: 16);

  static const TextStyle removeTextStyle = TextStyle(color: errorColor);
}
