import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Supported semantic status types for POS operations.
enum PosStatusType {
  /// Paid in full (Green)
  lunas,

  /// Unpaid customer debt / credit ledger (Red)
  kasbon,

  /// Partial credit payment / installment (Amber)
  cicilan,

  /// Inventory is well-stocked (Green)
  stokAman,

  /// Inventory is running low (Amber)
  stokMenipis,

  /// Inventory depleted / out of stock (Red)
  stokHabis,
}

/// A compact, high-contrast semantic badge for transaction and inventory statuses.
class PosStatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final IconData? icon;

  const PosStatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    this.icon,
  });

  /// Factory constructor resolving from predefined [PosStatusType].
  factory PosStatusBadge.fromType(PosStatusType type, {String? customLabel}) {
    switch (type) {
      case PosStatusType.lunas:
        return PosStatusBadge.lunas(label: customLabel);
      case PosStatusType.kasbon:
        return PosStatusBadge.kasbon(label: customLabel);
      case PosStatusType.cicilan:
        return PosStatusBadge.cicilan(label: customLabel);
      case PosStatusType.stokAman:
        return PosStatusBadge.stokAman(label: customLabel);
      case PosStatusType.stokMenipis:
        return PosStatusBadge.stokMenipis(label: customLabel);
      case PosStatusType.stokHabis:
        return PosStatusBadge.stokHabis(label: customLabel);
    }
  }

  /// LUNAS (Paid in Full) badge.
  const PosStatusBadge.lunas({
    super.key,
    String? label,
  })  : label = label ?? 'LUNAS',
        backgroundColor = AppColors.successBg,
        textColor = AppColors.successText,
        borderColor = AppColors.successBorder,
        icon = Icons.check_circle_outline_rounded;

  /// KASBON (Unpaid Debt) badge.
  const PosStatusBadge.kasbon({
    super.key,
    String? label,
  })  : label = label ?? 'KASBON',
        backgroundColor = AppColors.dangerBg,
        textColor = AppColors.dangerText,
        borderColor = AppColors.dangerBorder,
        icon = Icons.error_outline_rounded;

  /// CICILAN / SEBAGIAN (Partial payment) badge.
  const PosStatusBadge.cicilan({
    super.key,
    String? label,
  })  : label = label ?? 'CICILAN',
        backgroundColor = AppColors.warningBg,
        textColor = AppColors.warningText,
        borderColor = AppColors.warningBorder,
        icon = Icons.timelapse_rounded;

  /// STOK AMAN (Safe inventory level) badge.
  const PosStatusBadge.stokAman({
    super.key,
    String? label,
  })  : label = label ?? 'STOK AMAN',
        backgroundColor = AppColors.successBg,
        textColor = AppColors.successText,
        borderColor = AppColors.successBorder,
        icon = Icons.inventory_2_outlined;

  /// STOK MENIPIS (Low stock alert) badge.
  const PosStatusBadge.stokMenipis({
    super.key,
    String? label,
  })  : label = label ?? 'STOK MENIPIS',
        backgroundColor = AppColors.warningBg,
        textColor = AppColors.warningText,
        borderColor = AppColors.warningBorder,
        icon = Icons.warning_amber_rounded;

  /// STOK HABIS (Depleted stock alert) badge.
  const PosStatusBadge.stokHabis({
    super.key,
    String? label,
  })  : label = label ?? 'STOK HABIS',
        backgroundColor = AppColors.dangerBg,
        textColor = AppColors.dangerText,
        borderColor = AppColors.dangerBorder,
        icon = Icons.block_rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.borderXs,
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13.0, color: textColor),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
