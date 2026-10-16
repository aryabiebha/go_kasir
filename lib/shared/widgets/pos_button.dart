import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Style variants for [PosButton].
enum PosButtonVariant {
  /// Pine green solid background for primary confirmation, payment, checkout.
  primary,

  /// Moss green solid background for secondary actions.
  secondary,

  /// Mint cream light background for tonal options, filters, quick actions.
  tonal,

  /// High-contrast red background for cancellations, voids, debt write-offs.
  danger,

  /// Transparent background with subtle border for secondary / cancel actions.
  ghost,
}

/// A high-touch-target POS button supporting icons, loading states, and full-width layouts.
///
/// Enforces a minimum 48dp touch height for cashier speed and accessibility.
class PosButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final PosButtonVariant variant;
  final IconData? icon;
  final Widget? customIcon;
  final bool isLoading;
  final bool fullWidth;
  final double minHeight;
  final EdgeInsetsGeometry? padding;

  const PosButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PosButtonVariant.primary,
    this.icon,
    this.customIcon,
    this.isLoading = false,
    this.fullWidth = false,
    this.minHeight = AppSpacing.touchTargetMin,
    this.padding,
  });

  /// Convenience constructor for primary action button.
  const PosButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.customIcon,
    this.isLoading = false,
    this.fullWidth = false,
    this.minHeight = AppSpacing.touchTargetMin,
    this.padding,
  }) : variant = PosButtonVariant.primary;

  /// Convenience constructor for secondary action button.
  const PosButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.customIcon,
    this.isLoading = false,
    this.fullWidth = false,
    this.minHeight = AppSpacing.touchTargetMin,
    this.padding,
  }) : variant = PosButtonVariant.secondary;

  /// Convenience constructor for tonal mint button.
  const PosButton.tonal({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.customIcon,
    this.isLoading = false,
    this.fullWidth = false,
    this.minHeight = AppSpacing.touchTargetMin,
    this.padding,
  }) : variant = PosButtonVariant.tonal;

  /// Convenience constructor for danger button.
  const PosButton.danger({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.customIcon,
    this.isLoading = false,
    this.fullWidth = false,
    this.minHeight = AppSpacing.touchTargetMin,
    this.padding,
  }) : variant = PosButtonVariant.danger;

  /// Convenience constructor for ghost button.
  const PosButton.ghost({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.customIcon,
    this.isLoading = false,
    this.fullWidth = false,
    this.minHeight = AppSpacing.touchTargetMin,
    this.padding,
  }) : variant = PosButtonVariant.ghost;

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm);

    final colors = _getColors();

    Widget content = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(colors.foreground),
            ),
          )
        else ...[
          if (customIcon != null) ...[
            customIcon!,
            const SizedBox(width: AppSpacing.xs),
          ] else if (icon != null) ...[
            Icon(icon, size: 18.0, color: colors.foreground),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: colors.foreground,
                letterSpacing: 0.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: colors.background,
      foregroundColor: colors.foreground,
      disabledBackgroundColor: colors.disabledBackground,
      disabledForegroundColor: colors.disabledForeground,
      elevation: 0.0,
      padding: effectivePadding,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderSm,
        side: colors.border != null
            ? BorderSide(color: colors.border!, width: 1.2)
            : BorderSide.none,
      ),
      minimumSize: Size(fullWidth ? double.infinity : 64.0, minHeight),
    );

    Widget button = ElevatedButton(
      onPressed: _isEnabled ? onPressed : null,
      style: buttonStyle,
      child: content,
    );

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  _ButtonColors _getColors() {
    switch (variant) {
      case PosButtonVariant.primary:
        return _ButtonColors(
          background: AppColors.pineGreen,
          foreground: AppColors.textOnDark,
          disabledBackground: AppColors.surfaceContainer,
          disabledForeground: AppColors.textMuted,
        );
      case PosButtonVariant.secondary:
        return _ButtonColors(
          background: AppColors.mossGreen,
          foreground: AppColors.textOnDark,
          disabledBackground: AppColors.surfaceContainer,
          disabledForeground: AppColors.textMuted,
        );
      case PosButtonVariant.tonal:
        return _ButtonColors(
          background: AppColors.mintCream,
          foreground: AppColors.deepForest,
          disabledBackground: AppColors.surfaceContainer,
          disabledForeground: AppColors.textMuted,
        );
      case PosButtonVariant.danger:
        return _ButtonColors(
          background: AppColors.danger,
          foreground: AppColors.textOnDark,
          disabledBackground: AppColors.surfaceContainer,
          disabledForeground: AppColors.textMuted,
        );
      case PosButtonVariant.ghost:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.pineGreen,
          disabledBackground: Colors.transparent,
          disabledForeground: AppColors.textMuted,
          border: AppColors.borderStrong,
        );
    }
  }
}

class _ButtonColors {
  final Color background;
  final Color foreground;
  final Color disabledBackground;
  final Color disabledForeground;
  final Color? border;

  _ButtonColors({
    required this.background,
    required this.foreground,
    required this.disabledBackground,
    required this.disabledForeground,
    this.border,
  });
}
