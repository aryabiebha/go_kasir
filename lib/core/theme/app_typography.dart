import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized typography styles for the GoKasir Design System.
///
/// Designed for retail environments requiring immediate visual recognition.
/// Provides [tabularNumerals] to guarantee vertical alignment in pricing,
/// quantities, receipts, and ledger tables.
abstract final class AppTypography {
  /// Font feature that enables proportional tabular digits for numbers.
  static const List<FontFeature> tabularFigures = [FontFeature.tabularFigures()];

  // --- Display Styles (Large hero numbers, checkout grand totals) ---
  static const TextStyle displayLarge = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    color: AppColors.textPrimary,
    fontFeatures: tabularFigures,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
    fontFeatures: tabularFigures,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.textPrimary,
    fontFeatures: tabularFigures,
  );

  // --- Headline Styles (Screen titles, modal titles) ---
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // --- Title Styles (Card headers, product names) ---
  static const TextStyle titleLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // --- Body Styles (Standard content, descriptions) ---
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // --- Label Styles (Buttons, badges, tabs, form labels) ---
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.textMuted,
  );

  // --- POS Specific Numerals & Currency Styles ---
  /// Price text with tabular numerals for alignment.
  static TextStyle priceLarge({Color color = AppColors.deepForest}) => TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        color: color,
        fontFeatures: tabularFigures,
      );

  static TextStyle priceMedium({Color color = AppColors.deepForest}) => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: color,
        fontFeatures: tabularFigures,
      );

  static TextStyle priceSmall({Color color = AppColors.deepForest}) => TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w600,
        color: color,
        fontFeatures: tabularFigures,
      );

  /// Builds a complete Material 3 [TextTheme].
  static TextTheme createTextTheme() {
    return const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }
}
