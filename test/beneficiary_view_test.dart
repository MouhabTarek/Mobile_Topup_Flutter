import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_topup/viewmodels/beneficiary_view_model.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_topup/views/beneficiary_view.dart';
import 'package:mobile_topup/models/beneficiary.dart';

class MockBeneficiaryViewModel extends Mock implements BeneficiaryViewModel {}

void main() {
  testWidgets('BeneficiaryView displays a list of beneficiaries', (WidgetTester tester) async {
    final mockViewModel = MockBeneficiaryViewModel();
    final mockBeneficiaries = [
      Beneficiary(id: '1', nickname: 'John', phoneNumber: '1234567890'),
      Beneficiary(id: '2', nickname: 'Doe', phoneNumber: '0987654321'),
    ];

    when(mockViewModel.beneficiaries).thenReturn(mockBeneficiaries);

    await tester.pumpWidget(
      ChangeNotifierProvider<BeneficiaryViewModel>(
        create: (_) => mockViewModel,
        child:  MaterialApp(
          home: Scaffold(
            body: BeneficiaryView(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify if the beneficiary cards are present
    expect(find.text('John'), findsOneWidget);
    expect(find.text('Doe'), findsOneWidget);
    expect(find.text('Top Up'), findsNWidgets(mockBeneficiaries.length));
  });

  testWidgets('Tapping on Top Up button navigates to TopUpView', (WidgetTester tester) async {
    final mockViewModel = MockBeneficiaryViewModel();
    final mockBeneficiaries = [
      Beneficiary(id: '1', nickname: 'John', phoneNumber: '1234567890'),
    ];

    when(mockViewModel.beneficiaries).thenReturn(mockBeneficiaries);

    await tester.pumpWidget(
      ChangeNotifierProvider<BeneficiaryViewModel>(
        create: (_) => mockViewModel,
        child:  MaterialApp(
          home: Scaffold(
            body: BeneficiaryView(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap the 'Top Up' button
    await tester.tap(find.text('Top Up'));
    await tester.pumpAndSettle();

    // Verify if the TopUpView is displayed
    expect(find.text('Top Up John'), findsOneWidget);
    expect(find.text('Select Top-Up Amount'), findsOneWidget);
  });
}