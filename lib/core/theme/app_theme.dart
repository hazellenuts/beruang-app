import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightTextColor, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.lightTextColor, fontSize: 14),
        bodySmall: TextStyle(color: AppColors.lightTextColor, fontSize: 12),
        
        headlineLarge: TextStyle(color: AppColors.lightTextColor, fontSize: 24, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: AppColors.lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(color: AppColors.lightTextColor, fontSize: 18, fontWeight: FontWeight.bold),
        
        titleLarge: TextStyle(color: AppColors.lightTextColor, fontSize: 40, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: AppColors.lightTextColor, fontSize: 32, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(color: AppColors.lightTextColor, fontSize: 28, fontWeight: FontWeight.bold),

        labelLarge: TextStyle(color: AppColors.lightaccent, fontSize: 16, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(color: AppColors.lightaccent, fontSize: 14, fontWeight: FontWeight.bold),
        labelSmall: TextStyle(color: AppColors.lightaccent, fontSize: 12, fontWeight: FontWeight.bold),
      ),

      colorScheme: ColorScheme.light(
        primary: AppColors.lightprimary,
        primaryContainer: AppColors.lightprimaryVariant,
        secondary: AppColors.lightsecondary,
        secondaryContainer: AppColors.lightsecondaryVariant,
        surface: AppColors.lightsurface,
        surfaceTint: AppColors.lightsurfaceVariant,
        onPrimary: AppColors.lightOnPrimary,
        onSecondary: AppColors.lightOnSecondary,
        tertiary: AppColors.lightaccent,
        onTertiary: AppColors.lightOnAccent,
        tertiaryContainer: AppColors.lightaccentVariant,
        onBackground: AppColors.lightTextColor
      ),
      
    );
  }
}
