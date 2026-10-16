/// Strictly integer-based Indonesian Rupiah (IDR) currency formatter and parser.
///
/// NOTE: In accordance with retail POS architectural integrity, this utility
/// NEVER uses `double`, `float`, or `num` to prevent floating-point
/// rounding errors in financial transactions and ledger balancing.
abstract final class RupiahUtil {
  /// Formats an integer [amount] into standard Indonesian Rupiah representation.
  ///
  /// Examples:
  /// - `format(0)` -> `"Rp 0"`
  /// - `format(15500)` -> `"Rp 15.500"`
  /// - `format(1250000)` -> `"Rp 1.250.000"`
  /// - `format(-5000)` -> `"-Rp 5.000"`
  /// - `format(15500, withPrefix: false)` -> `"15.500"`
  /// - `format(-5000, spacePrefix: false)` -> `"-Rp5.000"`
  static String format(
    int amount, {
    bool withPrefix = true,
    bool spacePrefix = true,
  }) {
    final bool isNegative = amount < 0;
    final int absAmount = amount.abs();
    final String digits = absAmount.toString();

    final buffer = StringBuffer();
    final int length = digits.length;
    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }
    final formattedDigits = buffer.toString();

    if (!withPrefix) {
      return isNegative ? '-$formattedDigits' : formattedDigits;
    }

    final prefix = spacePrefix ? 'Rp ' : 'Rp';
    return isNegative ? '-$prefix$formattedDigits' : '$prefix$formattedDigits';
  }

  /// Formats an integer [amount] into compact readable shorthand for summary cards.
  ///
  /// Strictly uses integer arithmetic without floating-point conversion.
  /// Examples:
  /// - `formatCompact(500)` -> `"Rp 500"`
  /// - `formatCompact(15000)` -> `"Rp 15 rb"`
  /// - `formatCompact(15500)` -> `"Rp 15,5 rb"`
  /// - `formatCompact(1200000)` -> `"Rp 1,2 jt"`
  /// - `formatCompact(5000000)` -> `"Rp 5 jt"`
  /// - `formatCompact(-1500000)` -> `"-Rp 1,5 jt"`
  static String formatCompact(
    int amount, {
    bool withPrefix = true,
    bool spacePrefix = true,
  }) {
    final bool isNegative = amount < 0;
    final int absAmount = amount.abs();
    final prefix = withPrefix ? (spacePrefix ? 'Rp ' : 'Rp') : '';

    String body;
    if (absAmount < 1000) {
      body = absAmount.toString();
    } else if (absAmount < 1000000) {
      final int thousands = absAmount ~/ 1000;
      final int remainder = (absAmount % 1000) ~/ 100;
      body = remainder > 0 ? '$thousands,$remainder rb' : '$thousands rb';
    } else if (absAmount < 1000000000) {
      final int millions = absAmount ~/ 1000000;
      final int remainder = (absAmount % 1000000) ~/ 100000;
      body = remainder > 0 ? '$millions,$remainder jt' : '$millions jt';
    } else {
      final int billions = absAmount ~/ 1000000000;
      final int remainder = (absAmount % 1000000000) ~/ 100000000;
      body = remainder > 0 ? '$billions,$remainder M' : '$billions M';
    }

    if (!withPrefix) {
      return isNegative ? '-$body' : body;
    }
    return isNegative ? '-$prefix$body' : '$prefix$body';
  }

  /// Parses a formatted string back to an integer value.
  /// Returns `null` if the string contains no valid digits.
  ///
  /// Examples:
  /// - `parse("Rp 15.500")` -> `15500`
  /// - `parse("-Rp 5.000")` -> `-5000`
  /// - `parse("1250000")` -> `1250000`
  /// - `parse("invalid")` -> `null`
  static int? parse(String? text) {
    if (text == null || text.trim().isEmpty) return null;

    final trimmed = text.trim();
    final bool isNegative = trimmed.startsWith('-') || trimmed.contains('-Rp');

    final cleanDigits = trimmed.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanDigits.isEmpty) return null;

    final parsed = int.tryParse(cleanDigits);
    if (parsed == null) return null;

    return isNegative ? -parsed : parsed;
  }
}
