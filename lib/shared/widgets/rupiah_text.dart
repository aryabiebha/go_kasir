import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/rupiah_util.dart';

/// Renders an integer Rupiah amount with guaranteed tabular figures
/// for perfect vertical decimal and digit alignment in tables, carts, and receipts.
class RupiahText extends StatelessWidget {
  /// The currency amount in integer Rupiah. Never accepts double or num.
  final int amount;

  /// Whether to prepend "Rp". Defaults to true.
  final bool withPrefix;

  /// Whether to put a space after "Rp" (i.e. "Rp 10.000" vs "Rp10.000"). Defaults to true.
  final bool spacePrefix;

  /// Base text style to extend.
  final TextStyle? style;

  /// Convenience fontSize override.
  final double? fontSize;

  /// Convenience fontWeight override.
  final FontWeight? fontWeight;

  /// Convenience color override.
  final Color? color;

  /// Text alignment.
  final TextAlign? textAlign;

  const RupiahText({
    super.key,
    required this.amount,
    this.withPrefix = true,
    this.spacePrefix = true,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
  });

  /// Large hero price variant for checkout totals.
  const RupiahText.large({
    super.key,
    required this.amount,
    this.withPrefix = true,
    this.spacePrefix = true,
    this.color = AppColors.deepForest,
    this.textAlign,
  })  : style = null,
        fontSize = 24.0,
        fontWeight = FontWeight.w800;

  /// Medium price variant for product catalog and card items.
  const RupiahText.medium({
    super.key,
    required this.amount,
    this.withPrefix = true,
    this.spacePrefix = true,
    this.color = AppColors.deepForest,
    this.textAlign,
  })  : style = null,
        fontSize = 16.0,
        fontWeight = FontWeight.w700;

  /// Small price variant for receipt line items and compact lists.
  const RupiahText.small({
    super.key,
    required this.amount,
    this.withPrefix = true,
    this.spacePrefix = true,
    this.color = AppColors.textPrimary,
    this.textAlign,
  })  : style = null,
        fontSize = 13.0,
        fontWeight = FontWeight.w600;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final effectiveStyle = (style ?? defaultStyle).copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    final formattedText = RupiahUtil.format(
      amount,
      withPrefix: withPrefix,
      spacePrefix: spacePrefix,
    );

    return Text(
      formattedText,
      style: effectiveStyle,
      textAlign: textAlign,
    );
  }
}
