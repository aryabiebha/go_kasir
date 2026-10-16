import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'rupiah_text.dart';

/// Clean high-contrast container surface with subtle border.
class PosCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Color borderColor;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onTap;

  const PosCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.margin,
    this.backgroundColor = AppColors.surfaceWhite,
    this.borderColor = AppColors.borderSubtle,
    this.borderRadius = AppRadius.borderMd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius is BorderRadius
              ? borderRadius as BorderRadius
              : AppRadius.borderMd,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );

    return card;
  }
}

/// Specialized dashboard and report metric card for retail financial figures.
class PosMetricCard extends StatelessWidget {
  final String title;
  final int? amount;
  final String? valueString;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final String? subtitle;
  final Widget? badge;
  final VoidCallback? onTap;

  const PosMetricCard({
    super.key,
    required this.title,
    this.amount,
    this.valueString,
    required this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.subtitle,
    this.badge,
    this.onTap,
  }) : assert(amount != null || valueString != null, 'Either amount or valueString must be provided');

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColors.pineGreen;
    final effectiveIconBg = iconBackgroundColor ?? AppColors.surfaceContainer;

    return PosCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: effectiveIconBg,
                  borderRadius: AppRadius.borderSm,
                ),
                child: Icon(icon, color: effectiveIconColor, size: 20.0),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (amount != null)
            RupiahText.large(
              amount: amount!,
              color: AppColors.deepForest,
            )
          else
            Text(
              valueString!,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
                color: AppColors.deepForest,
              ),
            ),
          if (subtitle != null || badge != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (subtitle != null)
                  Expanded(
                    child: Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ?badge,
              ],
            ),
          ],
        ],
      ),
    );
  }
}
