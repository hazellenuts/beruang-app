import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.whiteTextColor),
        bodyMedium: TextStyle(color: AppColors.whiteTextColor),
        bodySmall: TextStyle(color: AppColors.whiteTextColor),
        
        headlineLarge: TextStyle(color: AppColors.whiteTextColor),
        headlineMedium: TextStyle(color: AppColors.whiteTextColor),
        headlineSmall: TextStyle(color: AppColors.whiteTextColor),
        
        titleLarge: TextStyle(color: AppColors.whiteTextColor),
        titleMedium: TextStyle(color: AppColors.whiteTextColor),
        titleSmall: TextStyle(color: AppColors.whiteTextColor),

        labelLarge: TextStyle(color: AppColors.whiteTextColor),
        labelMedium: TextStyle(color: AppColors.whiteTextColor),
        labelSmall: TextStyle(color: AppColors.whiteTextColor),
      ),
      
    );
  }
}
