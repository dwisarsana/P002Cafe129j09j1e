import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color burntOrange = Color(0xFFD84315);
  static const Color tomatoRed = Color(0xFFFF6347);
  static const Color goldenYellow = Color(0xFFFFC107);
  static const Color darkOven = Color(0xFF263238);
  static const Color creamDough = Color(0xFFFFF8E1);
  static const Color flourWhite = Color(0xFFFAFAFA);
  static const Color butterYellow = Color(0xFFFFCA28);
  static const Color iceBlue = Color(0xFF81D4FA);
  static const Color copper = Color(0xFFBCAAA4);
  static const Color sage = Color(0xFFA5D6A7);
  static const Color coral = Color(0xFFFF8A65);
  static const Color slate = Color(0xFF37474F);
  static const Color charcoal = Color(0xFF1A1A1A);
  static const Color cream = Color(0xFFFFF8E1);

  // Gradients for existing widgets compatibility
  static const LinearGradient leafGradient = LinearGradient(
    colors: [tomatoRed, burntOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunGradient = LinearGradient(
    colors: [Color(0xAAFFB74D), Color(0x00FFB74D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static ThemeData get theme => ThemeData(
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: charcoal,
        colorScheme: ColorScheme.fromSeed(
          seedColor: burntOrange,
          brightness: Brightness.dark,
          surface: charcoal,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: flourWhite,
            letterSpacing: -1.0,
            height: 1.2,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: flourWhite,
            letterSpacing: -0.5,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: flourWhite,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: flourWhite,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: flourWhite,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFFB0BEC5), // Light slate / grey
            height: 1.4,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFFB0BEC5),
            letterSpacing: 0.5,
          ),
        ),
      );

  // Compatibility alias for lightTheme
  static ThemeData get lightTheme => theme;
}
