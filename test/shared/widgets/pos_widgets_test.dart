import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_kasir/shared/widgets/pos_button.dart';
import 'package:go_kasir/shared/widgets/pos_card.dart';
import 'package:go_kasir/shared/widgets/pos_search_bar.dart';
import 'package:go_kasir/shared/widgets/pos_status_badge.dart';
import 'package:go_kasir/shared/widgets/rupiah_text.dart';

void main() {
  Widget wrapWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('PosButton Widget Tests', () {
    testWidgets('triggers onPressed callback when clicked', (tester) async {
      int pressCount = 0;
      await tester.pumpWidget(
        wrapWidget(
          PosButton.primary(
            label: 'Bayar',
            onPressed: () => pressCount++,
          ),
        ),
      );

      expect(find.text('Bayar'), findsOneWidget);
      await tester.tap(find.text('Bayar'));
      await tester.pump();

      expect(pressCount, equals(1));
    });

    testWidgets('does not fire onPressed when isLoading is true', (tester) async {
      int pressCount = 0;
      await tester.pumpWidget(
        wrapWidget(
          PosButton.primary(
            label: 'Simpan',
            isLoading: true,
            onPressed: () => pressCount++,
          ),
        ),
      );

      // Label should be replaced by loading indicator
      expect(find.text('Simpan'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(pressCount, equals(0));
    });

    testWidgets('does not fire onPressed when disabled', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const PosButton.primary(
            label: 'Disabled',
            onPressed: null,
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('renders all style variants without errors', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          Column(
            children: [
              PosButton.primary(label: 'Primary', onPressed: () {}),
              PosButton.secondary(label: 'Secondary', onPressed: () {}),
              PosButton.tonal(label: 'Tonal', onPressed: () {}),
              PosButton.danger(label: 'Danger', onPressed: () {}),
              PosButton.ghost(label: 'Ghost', onPressed: () {}),
            ],
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Tonal'), findsOneWidget);
      expect(find.text('Danger'), findsOneWidget);
      expect(find.text('Ghost'), findsOneWidget);
    });
  });

  group('PosStatusBadge Widget Tests', () {
    testWidgets('renders all semantic status badges with correct labels', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const Column(
            children: [
              PosStatusBadge.lunas(),
              PosStatusBadge.kasbon(),
              PosStatusBadge.cicilan(),
              PosStatusBadge.stokAman(),
              PosStatusBadge.stokMenipis(),
              PosStatusBadge.stokHabis(),
            ],
          ),
        ),
      );

      expect(find.text('LUNAS'), findsOneWidget);
      expect(find.text('KASBON'), findsOneWidget);
      expect(find.text('CICILAN'), findsOneWidget);
      expect(find.text('STOK AMAN'), findsOneWidget);
      expect(find.text('STOK MENIPIS'), findsOneWidget);
      expect(find.text('STOK HABIS'), findsOneWidget);
    });
  });

  group('PosSearchBar Widget Tests', () {
    testWidgets('accepts input, shows clear button, and clears text', (tester) async {
      String currentQuery = '';
      await tester.pumpWidget(
        wrapWidget(
          PosSearchBar(
            onChanged: (q) => currentQuery = q,
          ),
        ),
      );

      // Initially no clear button
      expect(find.byIcon(Icons.close_rounded), findsNothing);

      // Enter text
      await tester.enterText(find.byType(TextField), 'Beras');
      await tester.pump();

      expect(currentQuery, equals('Beras'));
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);

      // Tap clear button
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();

      expect(currentQuery, equals(''));
      expect(find.byIcon(Icons.close_rounded), findsNothing);
    });

    testWidgets('triggers onScanBarcodePressed callback', (tester) async {
      bool scanTriggered = false;
      await tester.pumpWidget(
        wrapWidget(
          PosSearchBar(
            onScanBarcodePressed: () => scanTriggered = true,
          ),
        ),
      );

      expect(find.byIcon(Icons.qr_code_scanner_rounded), findsOneWidget);
      await tester.tap(find.byIcon(Icons.qr_code_scanner_rounded));
      await tester.pump();

      expect(scanTriggered, isTrue);
    });
  });

  group('RupiahText Widget Tests', () {
    testWidgets('formats integer amount and applies tabular figures', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const RupiahText(amount: 15500),
        ),
      );

      expect(find.text('Rp 15.500'), findsOneWidget);

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontFeatures, contains(const FontFeature.tabularFigures()));
    });

    testWidgets('renders large hero and small price variants', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const Column(
            children: [
              RupiahText.large(amount: 1250000),
              RupiahText.small(amount: 3500),
            ],
          ),
        ),
      );

      expect(find.text('Rp 1.250.000'), findsOneWidget);
      expect(find.text('Rp 3.500'), findsOneWidget);
    });
  });

  group('PosCard & PosMetricCard Widget Tests', () {
    testWidgets('renders PosCard with child content and taps', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        wrapWidget(
          PosCard(
            onTap: () => tapped = true,
            child: const Text('Card Content'),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
      await tester.tap(find.text('Card Content'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('renders PosMetricCard with formatted amount and subtitle', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const PosMetricCard(
            title: 'Omzet Hari Ini',
            amount: 1450000,
            icon: Icons.payments_rounded,
            subtitle: '38 Transaksi Berhasil',
          ),
        ),
      );

      expect(find.text('Omzet Hari Ini'), findsOneWidget);
      expect(find.text('Rp 1.450.000'), findsOneWidget);
      expect(find.text('38 Transaksi Berhasil'), findsOneWidget);
      expect(find.byIcon(Icons.payments_rounded), findsOneWidget);
    });
  });
}
