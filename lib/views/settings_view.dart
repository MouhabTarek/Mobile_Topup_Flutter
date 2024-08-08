import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/beneficiary_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BeneficiaryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: 
          Column(
            children: [
              SwitchListTile( //switch at left side of label
                value: viewModel.isVerified, 
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (value) {
                viewModel.verifyUser(value);
              },
                title: const Text("User verification")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
