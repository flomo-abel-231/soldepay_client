class CardBalance {
  final double currentBalance;
  final double availableBalance;

  CardBalance({
    required this.currentBalance,
    required this.availableBalance,
  });

  factory CardBalance.fromJson(Map<String, dynamic> json) {
    return CardBalance(
      currentBalance: (json['currentBalance'] ?? 0).toDouble(),
      availableBalance: (json['availableBalance'] ?? 0).toDouble(),
    );
  }

  double get amount => currentBalance;
}
