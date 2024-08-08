import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_topup/views/top_up_view.dart';
import 'package:mobile_topup/models/beneficiary.dart';

void main() {
  testWidgets('TopUpView displays top-up options and processes transaction', (WidgetTester tester) async {
    final beneficiary = Beneficiary(id: '1', nickname: 'John', phoneNumber: '1234567890');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TopUpView(beneficiary: beneficiary),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify if the top-up options are displayed
    expect(find.text('AED 5'), findsOneWidget);
    expect(find.text('AED 10'), findsOneWidget);

    // Select a top-up amount
    await tester.tap(find.text('AED 10'));
    await tester.pump();

    // Verify if the 'Confirm Top-Up' button is enabled
    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled, true);

    // Tap the 'Confirm Top-Up' button
    await tester.tap(find.text('Confirm Top-Up'));
    await tester.pump();

    // Verify the success message
    expect(find.text('Top-Up Successful'), findsOneWidget);
  });
}