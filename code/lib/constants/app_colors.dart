import 'package:flutter/material.dart';

class AppColors {
  static const Color darkColor = Color(0xFF1A1A19);
  static const Color greenColor = Color(0xFF31511E);
  static const Color inputBackgroundColor = Color(0xFF1A1A19);  // Add this line

  static const BoxDecoration gradientBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        darkColor,
        greenColor,
      ],
    ),
  );

  // Added reversed gradient
  static const BoxDecoration reversedGradientBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        greenColor,
        darkColor,
      ],
    ),
  );
}
