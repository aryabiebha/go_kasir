import 'package:flutter/material.dart';

/// Centralized color palette for the GoKasir Design System.
///
/// Follows the mandatory "Green Forest" brand identity tailored for
/// retail store environments ("warung kelontong" & minimarkets) with high
/// legibility under direct store lighting.
abstract final class AppColors {
  // --- Mandatory Brand Forest Palette ---
  /// #051F20 - Dominant deep forest for app bars, tablet navigation rails & primary dark surfaces.
  static const Color deepForest = Color(0xFF051F20);

  /// #0B2B26 - Forest green for elevated dark surfaces and rail gradients.
  static const Color forestGreen = Color(0xFF0B2B26);

  /// #163832 - Pine green for primary buttons, active interactive elements, and key accents.
  static const Color pineGreen = Color(0xFF163832);

  /// #235347 - Moss green for secondary actions, active tabs, and secondary borders.
  static const Color mossGreen = Color(0xFF235347);

  /// #8EB69B - Sage green for muted icons, borders, and subtle chips.
  static const Color sageGreen = Color(0xFF8EB69B);

  /// #DAF1DE - Mint cream for active indicator pills, highlights, and light accents.
  static const Color mintCream = Color(0xFFDAF1DE);

  // --- High-Contrast Store Surfaces (Light Mode) ---
  /// #F6FAF7 - Crisp light mint/green tinted canvas background for bright retail environments.
  static const Color surfaceBackground = Color(0xFFF6FAF7);

  /// #FFFFFF - Pure white for product cards, cart sheets, and dialog surfaces.
  static const Color surfaceWhite = Color(0xFFFFFFFF);

  /// #EBF3EE - Subtle container background for chips, search bars, and input fills.
  static const Color surfaceContainer = Color(0xFFEBF3EE);

  /// #DDE8E0 - Subtle divider and card outline border.
  static const Color borderSubtle = Color(0xFFDDE8E0);

  /// #B5C9BD - Stronger border for active inputs and dividers.
  static const Color borderStrong = Color(0xFFB5C9BD);

  // --- Typography / Text Colors ---
  /// Primary text: High-contrast deep forest for maximum readability.
  static const Color textPrimary = Color(0xFF051F20);

  /// Secondary text: Mid-tone green-gray for labels, timestamps, and secondary info.
  static const Color textSecondary = Color(0xFF385548);

  /// Muted text: For placeholders, disabled labels, and subtle metadata.
  static const Color textMuted = Color(0xFF6B877B);

  /// On dark text: Pure white for text on primary dark buttons, rails, and banners.
  static const Color textOnDark = Color(0xFFFFFFFF);

  /// On dark secondary: Mint cream for subheadings on dark surfaces.
  static const Color textOnDarkMuted = Color(0xFFDAF1DE);

  // --- Semantic Status Colors ---
  // Success / Lunas / Stok Aman
  static const Color success = Color(0xFF15803D);
  static const Color successBg = Color(0xFFDCFCE7);
  static const Color successBorder = Color(0xFF86EFAC);
  static const Color successText = Color(0xFF14532D);

  // Warning / Kasbon / Cicilan / Stok Menipis
  static const Color warning = Color(0xFFB45309);
  static const Color warningBg = Color(0xFFFEF3C7);
  static const Color warningBorder = Color(0xFFFCD34D);
  static const Color warningText = Color(0xFF78350F);

  // Danger / Kasbon Belum Lunas / Stok Habis / Error
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerBg = Color(0xFFFEE2E2);
  static const Color dangerBorder = Color(0xFFFCA5A5);
  static const Color dangerText = Color(0xFF7F1D1D);

  // Info / Blue Accent
  static const Color info = Color(0xFF1D4ED8);
  static const Color infoBg = Color(0xFFDBEAFE);
  static const Color infoBorder = Color(0xFF93C5FD);
  static const Color infoText = Color(0xFF1E3A8A);
}
