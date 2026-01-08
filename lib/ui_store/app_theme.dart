import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,

      secondary: AppColors.secondary,
      onSecondary: Colors.white,

      surface: AppColors.surface,
      onSurface: AppColors.onSurface,

      error: AppColors.accent,
      onError: Colors.white,

      outline: AppColors.outline,
    ),
    appBarTheme: const AppBarTheme(elevation: 0),
  );
}
