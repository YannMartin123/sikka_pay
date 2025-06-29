enum TransactionType { deposit, withdrawal, transfer }

class Transaction {
  final String phoneNumber;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final String? destination; // Pour les transferts

  Transaction({
    required this.phoneNumber,
    required this.type,
    required this.amount,
    required this.date,
    this.destination,
  });

  @override
  String toString() {
    return '[$type] $amount F le ${date.toIso8601String()}'
        '${destination != null ? ' → $destination' : ''}';
  }
}
