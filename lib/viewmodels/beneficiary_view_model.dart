import 'package:flutter/material.dart';
import '../models/beneficiary.dart';
import '../services/api_service.dart';

class BeneficiaryViewModel extends ChangeNotifier {
  List<Beneficiary> _beneficiaries = [];
  final ApiService _apiService = ApiService();
  int _userBalance = 3000; // Mock initial balance
  bool _isVerified = false; // Mock verification status
  bool _isLoading = false; // Loading state
  bool _hasError = false; // Error state
  String _errorMessage = ''; // Error message

  List<Beneficiary> get beneficiaries => _beneficiaries;
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
      _beneficiaries = response.map((data) => Beneficiary.fromJson(data)).toList();
      notifyListeners();  // Ensure listeners are notified after fetching
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
    finally{
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
    notifyListeners();  // Notify listeners after adding a new beneficiary
  }

  void topUpBeneficiary(Beneficiary beneficiary, int amount) {
    if (_userBalance >= amount + 1) { // Add a charge of AED 1 for the transaction
      if (_isValidTransaction(beneficiary, amount)) {
        _userBalance -= (amount + 1); // Deduct amount and transaction fee
        notifyListeners();
        print('Top-Up Successful for ${beneficiary.nickname}');
      } else {
        print('Top-Up Failed: Exceeded monthly limit');
      }
    } else {
      print('Top-Up Failed: Insufficient balance');
    }
  }

  bool _isValidTransaction(Beneficiary beneficiary, int amount) {
    int monthlyLimit = _isVerified ? 500 : 1000;
    int totalLimit = 3000; // Monthly total limit for all beneficiaries
    int usedAmount = 0; // Calculate the total used amount for the month

    // Here you would calculate the actual used amount
    // For example, you could keep a record of previous transactions
    // Mock used amount logic

    if (amount > monthlyLimit) return false;
    if (usedAmount + amount > totalLimit) return false;

    return true;
  }

  void verifyUser(value){
    _isVerified = value;
    notifyListeners();
  }
}