import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_kasir/app.dart';

void main() {
  testWidgets('GoKasirApp smoke test - boots cleanly with ProviderScope', (WidgetTester tester) async {
    // Build our app inside ProviderScope and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: GoKasirApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the POS checkout screen is loaded as the initial destination
    expect(find.text('Kasir'), findsWidgets);
    expect(find.text('Checkout'), findsOneWidget);
  });
}
