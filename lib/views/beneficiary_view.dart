import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/beneficiary_view_model.dart';
import '../models/beneficiary.dart';
import 'top_up_view.dart';
import 'add_beneficiary_dialog.dart';

class BeneficiaryView extends StatefulWidget {
  @override
  _BeneficiaryViewState createState() => _BeneficiaryViewState();
}

class _BeneficiaryViewState extends State<BeneficiaryView> {
  @override
  void initState() {
    super.initState();
    Provider.of<BeneficiaryViewModel>(context, listen: false)
        .fetchBeneficiaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beneficiaries'),
        actions: [
          Consumer<BeneficiaryViewModel>(
            builder: (context, viewModel, child) => IconButton(
              icon: Icon(Icons.add),
              onPressed: viewModel.beneficiaries.length < 5
                  ? () => _showAddBeneficiaryDialog(context, viewModel)
                  : null,
            ),
          ),
        ],
      ),
      body: Consumer<BeneficiaryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.beneficiaries.isEmpty && viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.hasError) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          } else {
            return Column(children: [
              Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.beneficiaries.length,
                    itemBuilder: (context, index) {
                      final Beneficiary beneficiary =
                          viewModel.beneficiaries[index];

                      return Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        margin: EdgeInsets.all(4.0),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(beneficiary.nickname,
                                  style: TextStyle(fontSize: 18)),
                              Text(beneficiary.phoneNumber,
                                  style: TextStyle(color: Colors.grey)),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TopUpView(
                                            beneficiary: beneficiary)),
                                  );
                                },
                                child: Text('Top Up'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ))
            ]);
          }
        },
      ),
    );
  }

  void _showAddBeneficiaryDialog(
      BuildContext context, BeneficiaryViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AddBeneficiaryDialog(viewModel: viewModel),
    );
  }
}
