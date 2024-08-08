import 'package:flutter/material.dart';
import '../models/beneficiary.dart';
import '../services/api_service.dart';

class BeneficiaryViewModel extends ChangeNotifier {
  List<Beneficiary> _beneficiaries = [];
  List<Transaction> _transactions = [];
  final ApiService _apiService = ApiService();
  int _userBalance = 3000; // Mock initial balance
  bool _isVerified = false; // Mock verification status
  bool _isLoading = false; // Loading state
  bool _hasError = false; // Error state
  String _errorMessage = ''; // Error message

  List<Beneficiary> get beneficiaries => _beneficiaries;
  List<Transaction> get transactions => _transactions;
  int get userBalance => _userBalance;
  bool get isVerified => _isVerified;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> fetchBeneficiaries() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();
    try {
      // Mocking data fetch
      final response = _apiService.fetchBeneficiaries();
      _beneficiaries =
          response.map((data) => Beneficiary.fromJson(data)).toList();
      notifyListeners(); // Ensure listeners are notified after fetching
    } catch (e) {
      print('Error: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addBeneficiary(String nickname, String phoneNumber) {
    if (_beneficiaries.length >= 5) {
      print('Cannot add more than 5 beneficiaries');
      return;
    }

    _beneficiaries.add(
      Beneficiary(
        id: DateTime.now().toString(),
        nickname: nickname,
        phoneNumber: phoneNumber,
      ),
    );
    notifyListeners(); // Notify listeners after adding a new beneficiary
  }

  String topUpBeneficiary(Beneficiary beneficiary, int amount) {
    if (_userBalance >= amount + 1) {
      // Add a charge of AED 1 for the transaction
      _userBalance -= (amount +
          1); // Deduct amount and transaction fee before proceeding with the transaction
      if (_isValidTransaction(beneficiary, amount)) {
        transactions.add(Transaction(
            beneficiary: beneficiary,
            amount: amount,
            date: DateTime.now().toString()));

        notifyListeners();
        print('Top-Up Successful for ${beneficiary.nickname}');

        return 'Top-Up Successful for ${beneficiary.nickname}';
      } else {
        _userBalance += (amount + 1); // rollback the transaction
        print('Top-Up Failed: Exceeded monthly limit');
        return 'Top-Up Failed: Exceeded monthly limit';
      }
    } else {
      _userBalance += (amount + 1); // rollback the transaction

      print('Top-Up Failed: Insufficient balance');
      return 'Top-Up Failed: Insufficient balance';
    }
  }

  bool _isValidTransaction(Beneficiary beneficiary, int amount) {
    int monthlyLimit = _isVerified ? 500 : 1000;
    int totalLimit = 3000; // Monthly total limit for all beneficiaries
    int usedAmount =
        0; // Calculate the total used amount per beneficiary for the month
    int transactionsAmount =
        0; //Caluculate the total used amount for all beneficiaries

    for (var e in transactions) {
      transactionsAmount += e.amount;
    } //updates the usedAmount per beneficiary

    transactions
        .where((x) => beneficiary.id == x.beneficiary.id)
        .forEach((Transaction e) {
      usedAmount += e.amount;
    }); //updates the usedAmount per beneficiary

    if (transactionsAmount > totalLimit) return false;
    if (usedAmount >= monthlyLimit) return false;
    if (usedAmount + amount > totalLimit) return false;

    print("Transactions amount: $transactionsAmount");
    print("used amount: $usedAmount");

    return true;
  }

  void verifyUser(value) {
    _isVerified = value;
    notifyListeners();
  }
}
