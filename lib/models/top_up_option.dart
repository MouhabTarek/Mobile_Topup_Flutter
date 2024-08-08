class TopUpOption {
  final int amount;
  bool isSelected;

  TopUpOption({
    required this.amount,
    this.isSelected = false,
  });

  // Factory constructor to create a TopUpOption instance from a JSON map
  factory TopUpOption.fromJson(Map<String, dynamic> json) {
    return TopUpOption(
      amount: json['amount'] as int,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  // Method to convert a TopUpOption instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'isSelected': isSelected,
    };
  }
}