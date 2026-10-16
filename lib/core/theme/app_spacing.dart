import 'package:flutter/material.dart';

/// Centralized 4dp/8dp grid spacing system for consistent layout density.
abstract final class AppSpacing {
  /// 2.0 dp - Micro padding / divider offsets
  static const double xxs = 2.0;

  /// 4.0 dp - Extra small padding / badge insets
  static const double xs = 4.0;

  /// 8.0 dp - Small padding / internal element gaps
  static const double sm = 8.0;

  /// 12.0 dp - Medium padding / card inner spacing
  static const double md = 12.0;

  /// 16.0 dp - Large padding / screen edges on mobile
  static const double lg = 16.0;

  /// 20.0 dp - Extra large padding
  static const double xl = 20.0;

  /// 24.0 dp - 2XL padding / screen edges on tablet
  static const double xxl = 24.0;

  /// 32.0 dp - Section separators / dialog padding
  static const double xxxl = 32.0;

  /// 48.0 dp - Minimum touch target height for POS buttons & key elements
  static const double touchTargetMin = 48.0;
}

/// Centralized corner radius tokens.
abstract final class AppRadius {
  /// 4.0 dp - Subtle rounded tags and badges
  static const double xs = 4.0;
  static const Radius radiusXs = Radius.circular(xs);
  static const BorderRadius borderXs = BorderRadius.all(radiusXs);

  /// 8.0 dp - Inputs, chips, and small buttons
  static const double sm = 8.0;
  static const Radius radiusSm = Radius.circular(sm);
  static const BorderRadius borderSm = BorderRadius.all(radiusSm);

  /// 12.0 dp - Standard cards and modal dialogs
  static const double md = 12.0;
  static const Radius radiusMd = Radius.circular(md);
  static const BorderRadius borderMd = BorderRadius.all(radiusMd);

  /// 16.0 dp - Elevated surfaces and large cards
  static const double lg = 16.0;
  static const Radius radiusLg = Radius.circular(lg);
  static const BorderRadius borderLg = BorderRadius.all(radiusLg);

  /// 24.0 dp - Bottom sheets and pills
  static const double xl = 24.0;
  static const Radius radiusXl = Radius.circular(xl);
  static const BorderRadius borderXl = BorderRadius.all(radiusXl);

  /// 999.0 dp - Fully rounded capsules and pill buttons
  static const double full = 999.0;
  static const Radius radiusFull = Radius.circular(full);
  static const BorderRadius borderFull = BorderRadius.all(radiusFull);
}
