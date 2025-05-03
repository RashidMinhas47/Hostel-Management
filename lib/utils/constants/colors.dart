import 'package:flutter/material.dart';

class TColors{

  TColors._();

// App theme colors
  static const Color primary = Color(0xffff4b4b);
  static const Color green = Color(0xff28d203);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color lighterGrey = Color(0xFFF8F8F8);
  static const Color action = Color(0xffda6e6e);
  static const Color actionDark =  Color(0xFF732A2A);

  static const Color secondary = Color(0xFFFFA726);
  static const Color accent = Color(0xFFb0c7ff);

  static const Gradient linearGradient= LinearGradient(
    begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
       Color(0xffff9a9e),
       Color(0xfffad0c4),
       Color(0xffff9a9e),

  ],
  );
  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = TColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color white = Color(0xFFFFFFFF);
}