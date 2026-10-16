import 'package:flutter/material.dart';

/// Form factor categorization according to screen width.
enum DeviceFormFactor {
  /// Phone layout: Single column, bottom navigation, full-screen drawers/sheets.
  phone,

  /// Tablet layout: Multi-pane split view, navigation rail, side cart/detail panels.
  tablet,
}

/// Breakpoint constants for responsive adaptation.
abstract final class AppBreakpoints {
  /// 720dp threshold separating Phone (compact) and Tablet (expanded) layouts.
  static const double tablet = 720.0;

  /// Large tablet / POS terminal with ultra-wide screens.
  static const double largeTablet = 1024.0;

  /// Determines form factor given a screen [width].
  static DeviceFormFactor getFormFactor(double width) {
    return width >= tablet ? DeviceFormFactor.tablet : DeviceFormFactor.phone;
  }

  /// Whether the given [width] is tablet grade (>= 720dp).
  static bool isTabletWidth(double width) => width >= tablet;
}

/// Convenience extensions on [BuildContext] for responsive layout checks.
extension ResponsiveContext on BuildContext {
  /// Current screen width in logical pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Current screen height in logical pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Current device form factor based on width.
  DeviceFormFactor get formFactor => AppBreakpoints.getFormFactor(screenWidth);

  /// True if current width is >= 720dp (Tablet experience).
  bool get isTablet => screenWidth >= AppBreakpoints.tablet;

  /// True if current width is < 720dp (Phone experience).
  bool get isPhone => screenWidth < AppBreakpoints.tablet;
}
