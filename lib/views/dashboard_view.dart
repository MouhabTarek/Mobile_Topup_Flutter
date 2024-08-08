import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/beneficiary_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BeneficiaryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Balance: AED ${viewModel.userBalance}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Verification Status: ${viewModel.isVerified ? "Verified" : "Unverified"}',
              style: const TextStyle(fontSize: 18),
            ),
            // Additional user info can go here
          ],
        ),
      ),
    );
  }
}