import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Centralized ThemeData definition for GoKasir.
abstract final class AppTheme {
  /// Primary high-contrast light theme optimized for retail store lighting.
  static ThemeData get lightTheme {
    final textTheme = AppTypography.createTextTheme();

    final colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.pineGreen,
      onPrimary: AppColors.textOnDark,
      primaryContainer: AppColors.mintCream,
      onPrimaryContainer: AppColors.deepForest,
      secondary: AppColors.mossGreen,
      onSecondary: AppColors.textOnDark,
      secondaryContainer: AppColors.surfaceContainer,
      onSecondaryContainer: AppColors.textPrimary,
      tertiary: AppColors.sageGreen,
      onTertiary: AppColors.textPrimary,
      error: AppColors.danger,
      onError: AppColors.textOnDark,
      errorContainer: AppColors.dangerBg,
      onErrorContainer: AppColors.dangerText,
      surface: AppColors.surfaceWhite,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceContainer,
      outline: AppColors.borderSubtle,
      outlineVariant: AppColors.borderStrong,
      shadow: Color(0x0F051F20),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.surfaceBackground,
      textTheme: textTheme,

      // App Bar styling
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.deepForest,
        foregroundColor: AppColors.textOnDark,
        elevation: 0.0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: AppColors.textOnDark,
          letterSpacing: -0.2,
        ),
        iconTheme: IconThemeData(color: AppColors.mintCream),
      ),

      // Card styling
      cardTheme: const CardThemeData(
        color: AppColors.surfaceWhite,
        elevation: 0.0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderMd,
          side: BorderSide(color: AppColors.borderSubtle, width: 1.0),
        ),
      ),

      // Navigation Bar (Phone Bottom Bar)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceWhite,
        elevation: 2.0,
        indicatorColor: AppColors.mintCream,
        height: 68.0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: AppColors.deepForest,
            );
          }
          return const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            color: AppColors.textMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.deepForest, size: 24.0);
          }
          return const IconThemeData(color: AppColors.textMuted, size: 22.0);
        }),
      ),

      // Navigation Rail (Tablet Left Sidebar)
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AppColors.deepForest,
        indicatorColor: AppColors.mintCream,
        elevation: 0.0,
        labelType: NavigationRailLabelType.all,
        selectedIconTheme: IconThemeData(color: AppColors.deepForest, size: 26.0),
        unselectedIconTheme: IconThemeData(color: AppColors.sageGreen, size: 24.0),
        selectedLabelTextStyle: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          color: AppColors.mintCream,
        ),
        unselectedLabelTextStyle: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          color: AppColors.sageGreen,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIconColor: AppColors.textMuted,
        suffixIconColor: AppColors.textMuted,
        border: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: const BorderSide(color: AppColors.borderSubtle, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: const BorderSide(color: AppColors.borderSubtle, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: const BorderSide(color: AppColors.pineGreen, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.borderSm,
          borderSide: const BorderSide(color: AppColors.danger, width: 1.2),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: 1.0,
        space: 1.0,
      ),

      // Dialog Theme
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.surfaceWhite,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderLg),
        elevation: 6.0,
      ),
    );
  }
}
