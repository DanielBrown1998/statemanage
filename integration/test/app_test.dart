import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:client_control/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Add your integration tests here
  testWidgets("Integration Test", (test) async {
    app.main();
    await test.pumpAndSettle();
    expect(find.text("Menu"), findsNothing);
    await test.tap(find.byIcon(Icons.menu));
    await test.pumpAndSettle();
    expect(find.text('Menu'), findsOneWidget);
  });
}
