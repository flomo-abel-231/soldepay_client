class CardTransaction {
  final String id;
  final String description;
  final double amount;
  final String currency;
  final String date;
  final String status;
  final String type;
  final String createdAt;

  CardTransaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.currency,
    required this.date,
    required this.status,
    required this.type,
    required this.createdAt,
  });

  factory CardTransaction.fromJson(Map<String, dynamic> json) {
    return CardTransaction(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      currency: json['currency'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
