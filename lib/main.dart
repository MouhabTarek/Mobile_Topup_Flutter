import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/beneficiary_view_model.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MobileTopupApp());
}

class MobileTopupApp extends StatelessWidget {
  const MobileTopupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BeneficiaryViewModel>(
          create: (_) => BeneficiaryViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'MobileTopup Top-Up App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeView(),
      ),
    );
  }
}