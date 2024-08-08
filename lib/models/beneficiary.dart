class Beneficiary {
  late final String id;
  final String nickname;
  final String phoneNumber;

  Beneficiary({
    required this.id,
    required this.nickname,
    required this.phoneNumber,
  });

  // Factory constructor to create a Beneficiary instance from a JSON map
  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  // Method to convert a Beneficiary instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'phoneNumber': phoneNumber,
    };
  }
}

class Transaction {
  final Beneficiary beneficiary;
  final int amount;
  final String date;

  Transaction(
      {required this.beneficiary, required this.amount, required this.date});
}
