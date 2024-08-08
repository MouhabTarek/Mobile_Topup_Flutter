import 'package:flutter/material.dart';
import '../viewmodels/beneficiary_view_model.dart';

class AddBeneficiaryDialog extends StatefulWidget {
  final BeneficiaryViewModel viewModel;

  AddBeneficiaryDialog({required this.viewModel});

  @override
  _AddBeneficiaryDialogState createState() => _AddBeneficiaryDialogState();
}

class _AddBeneficiaryDialogState extends State<AddBeneficiaryDialog> {
  final _formKey = GlobalKey<FormState>();
  String _nickname = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Beneficiary'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nickname'),
              maxLength: 20,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a nickname';
                }
                return null;
              },
              onSaved: (value) {
                _nickname = value ?? '';
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
              onSaved: (value) {
                _phoneNumber = value ?? '';
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _addBeneficiary,
          child: const Text('Add'),
        ),
      ],
    );
  }

  void _addBeneficiary() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.viewModel.addBeneficiary(_nickname, _phoneNumber);
      Navigator.of(context).pop();
    }
  }
}