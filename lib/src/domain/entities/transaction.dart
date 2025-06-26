enum TransactionType { deposit, withdraw, transfer }

class Transaction {
  final String id;
  final String phoneNumber;
  final double amount;
  final TransactionType type;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.phoneNumber,
    required this.amount,
    required this.type,
    required this.timestamp,
  });
}
