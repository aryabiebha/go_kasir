import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'adaptive_breakpoints.dart';

/// An adaptive split-view container that embodies "One Core Engine, Two Adaptive Experiences".
///
/// - On Tablet (`>= 720dp`): Displays a side-by-side split pane (e.g. Product Catalog + Live Cart,
///   or Customer List + Ledger Transactions).
/// - On Phone (`< 720dp`): Renders the [primary] view, with an option to toggle the [secondary]
///   view or delegate to a customized [phoneBuilder].
class AdaptiveSplitView extends StatelessWidget {
  /// The main pane (e.g., Catalog, Item List, Customer Table).
  final Widget primary;

  /// The contextual side pane (e.g., Active Cart, Detail Drawer, Ledger Summary).
  final Widget? secondary;

  /// Flex weight for the [primary] pane on tablet. Defaults to 5.
  final int primaryFlex;

  /// Flex weight for the [secondary] pane on tablet. Defaults to 3.
  final int secondaryFlex;

  /// Fixed width for the [secondary] pane on tablet. If non-null, overrides [secondaryFlex].
  final double? secondaryWidth;

  /// Divider color between panes on tablet.
  final Color dividerColor;

  /// Custom builder when rendering on a compact phone screen.
  final Widget Function(BuildContext context, Widget primary, Widget? secondary)? phoneBuilder;

  const AdaptiveSplitView({
    super.key,
    required this.primary,
    this.secondary,
    this.primaryFlex = 5,
    this.secondaryFlex = 3,
    this.secondaryWidth,
    this.dividerColor = AppColors.borderSubtle,
    this.phoneBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = AppBreakpoints.isTabletWidth(constraints.maxWidth);

        if (isTablet && secondary != null) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Primary Pane (Left)
              Expanded(
                flex: primaryFlex,
                child: primary,
              ),

              // Vertical Divider
              VerticalDivider(
                width: 1.0,
                thickness: 1.0,
                color: dividerColor,
              ),

              // Secondary Pane (Right)
              if (secondaryWidth != null)
                SizedBox(
                  width: secondaryWidth,
                  child: secondary!,
                )
              else
                Expanded(
                  flex: secondaryFlex,
                  child: secondary!,
                ),
            ],
          );
        }

        // Phone Layout
        if (phoneBuilder != null) {
          return phoneBuilder!(context, primary, secondary);
        }

        return primary;
      },
    );
  }
}
