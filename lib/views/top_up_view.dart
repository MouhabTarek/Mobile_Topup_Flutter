import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/beneficiary.dart';
import '../models/top_up_option.dart';
import '../viewmodels/beneficiary_view_model.dart';

class TopUpView extends StatefulWidget {
  final Beneficiary beneficiary;

  const TopUpView({super.key, required this.beneficiary});

  @override
  _TopUpViewState createState() => _TopUpViewState();
}

class _TopUpViewState extends State<TopUpView> {
  List<TopUpOption> topUpOptions = [
    TopUpOption(amount: 5),
    TopUpOption(amount: 10),
    TopUpOption(amount: 20),
    TopUpOption(amount: 30),
    TopUpOption(amount: 50),
    TopUpOption(amount: 75),
    TopUpOption(amount: 100),
  ];

  int? selectedAmount;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BeneficiaryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up ${widget.beneficiary.nickname}'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Select Top-Up Amount', style: TextStyle(fontSize: 20)),
          Expanded(
            child: ListView.builder(
              itemCount: topUpOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('AED ${topUpOptions[index].amount}'),
                  leading: Radio(
                    value: topUpOptions[index].amount,
                    groupValue: selectedAmount,
                    onChanged: (value) {
                      setState(() {
                        selectedAmount = value as int;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedAmount != null ? () => _topUp(viewModel) : null,
              child: const Text('Confirm Top-Up'),
            ),
          ),
        ],
      ),
    );
  }

  void _topUp(BeneficiaryViewModel viewModel) {
    final amount = selectedAmount ?? 0;
    if (viewModel.userBalance >= amount + 1) { // Include transaction fee
      viewModel.topUpBeneficiary(widget.beneficiary, amount);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Top-Up Successful')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient balance')),
      );
    }
  }
}