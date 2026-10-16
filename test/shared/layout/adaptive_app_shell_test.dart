import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_kasir/app.dart';

void main() {
  group('AdaptiveAppShell - Phone & Tablet Experience', () {
    testWidgets('renders bottom NavigationBar on Phone (< 720dp)', (tester) async {
      // Set compact phone dimensions (e.g. 390 x 844)
      tester.view.physicalSize = const Size(390 * 2.0, 844 * 2.0);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const ProviderScope(
          child: GoKasirApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Verify bottom NavigationBar is present
      expect(find.byType(NavigationBar), findsOneWidget);

      // Verify side NavigationRail is absent
      expect(find.byType(NavigationRail), findsNothing);

      // Verify default destination is Kasir
      expect(find.text('Kasir'), findsWidgets);

      // Tap on "Pengaturan" destination in phone NavigationBar
      await tester.tap(find.text('Pengaturan'));
      await tester.pumpAndSettle();

      // Verify active destination changed to Pengaturan
      expect(find.text('Profil Toko'), findsOneWidget);
    });

    testWidgets('renders side NavigationRail on Tablet (>= 720dp)', (tester) async {
      // Set tablet landscape dimensions (e.g. 1024 x 768)
      tester.view.physicalSize = const Size(1024 * 1.5, 768 * 1.5);
      tester.view.devicePixelRatio = 1.5;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const ProviderScope(
          child: GoKasirApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Verify NavigationRail is present on tablet
      expect(find.byType(NavigationRail), findsOneWidget);

      // Verify bottom NavigationBar is absent on tablet
      expect(find.byType(NavigationBar), findsNothing);

      // Verify GoKasir store brand title in rail header
      expect(find.text('GoKasir'), findsOneWidget);

      // Tap on "Produk & Stok" in NavigationRail
      await tester.tap(find.text('Produk & Stok'));
      await tester.pumpAndSettle();

      // Verify product screen header / actions appear
      expect(find.text('Tambah Produk'), findsOneWidget);
    });
  });
}
