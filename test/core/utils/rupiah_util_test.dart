import 'package:flutter_test/flutter_test.dart';
import 'package:go_kasir/core/utils/rupiah_util.dart';

void main() {
  group('RupiahUtil - Integer Currency Formatter & Parser', () {
    test('formats zero amount correctly', () {
      expect(RupiahUtil.format(0), equals('Rp 0'));
    });

    test('formats sub-thousand amounts correctly', () {
      expect(RupiahUtil.format(500), equals('Rp 500'));
      expect(RupiahUtil.format(999), equals('Rp 999'));
    });

    test('formats standard POS prices with thousands separator', () {
      expect(RupiahUtil.format(15500), equals('Rp 15.500'));
      expect(RupiahUtil.format(34000), equals('Rp 34.000'));
      expect(RupiahUtil.format(68500), equals('Rp 68.500'));
    });

    test('formats large million and hundred-million amounts', () {
      expect(RupiahUtil.format(1250000), equals('Rp 1.250.000'));
      expect(RupiahUtil.format(10000000), equals('Rp 10.000.000'));
      expect(RupiahUtil.format(100000000), equals('Rp 100.000.000'));
    });

    test('formats negative amounts (debts / discounts) correctly', () {
      expect(RupiahUtil.format(-5000), equals('-Rp 5.000'));
      expect(RupiahUtil.format(-25000), equals('-Rp 25.000'));
      expect(RupiahUtil.format(-1250000), equals('-Rp 1.250.000'));
    });

    test('supports formatting without prefix', () {
      expect(RupiahUtil.format(15500, withPrefix: false), equals('15.500'));
      expect(RupiahUtil.format(-15500, withPrefix: false), equals('-15.500'));
      expect(RupiahUtil.format(0, withPrefix: false), equals('0'));
    });

    test('supports formatting without space after prefix', () {
      expect(RupiahUtil.format(15500, spacePrefix: false), equals('Rp15.500'));
      expect(RupiahUtil.format(-5000, spacePrefix: false), equals('-Rp5.000'));
    });

    test('formats compact shorthand amounts using integer arithmetic', () {
      expect(RupiahUtil.formatCompact(500), equals('Rp 500'));
      expect(RupiahUtil.formatCompact(15000), equals('Rp 15 rb'));
      expect(RupiahUtil.formatCompact(15500), equals('Rp 15,5 rb'));
      expect(RupiahUtil.formatCompact(1200000), equals('Rp 1,2 jt'));
      expect(RupiahUtil.formatCompact(5000000), equals('Rp 5 jt'));
      expect(RupiahUtil.formatCompact(-1500000), equals('-Rp 1,5 jt'));
      expect(RupiahUtil.formatCompact(2500000000), equals('Rp 2,5 M'));
    });

    test('parses formatted strings back to integers accurately', () {
      expect(RupiahUtil.parse('Rp 15.500'), equals(15500));
      expect(RupiahUtil.parse('-Rp 5.000'), equals(-5000));
      expect(RupiahUtil.parse('1.250.000'), equals(1250000));
      expect(RupiahUtil.parse('Rp15500'), equals(15500));
      expect(RupiahUtil.parse('0'), equals(0));
    });

    test('returns null when parsing invalid or empty strings', () {
      expect(RupiahUtil.parse(null), isNull);
      expect(RupiahUtil.parse(''), isNull);
      expect(RupiahUtil.parse('   '), isNull);
      expect(RupiahUtil.parse('tidak_ada_angka'), isNull);
    });
  });
}
