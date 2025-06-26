import '../infrastructure/fake_database.dart';
import '../domain/exceptions/exceptions.dart';

class TransactionService {
  final String apiKey;

  TransactionService({required this.apiKey});

  Future<void> deposit({
    required String phoneNumber,
    required double amount,
  }) async {
    final account = FakeDatabase.getAccount(phoneNumber);
    if (account == null) throw AccountNotFoundException(phoneNumber);
    account.balance += amount;
  }

  Future<void> withdraw({
    required String phoneNumber,
    required double amount,
  }) async {
    final account = FakeDatabase.getAccount(phoneNumber);
    if (account == null) throw AccountNotFoundException(phoneNumber);
    if (account.balance < amount) throw InsufficientFundsException(phoneNumber);
    account.balance -= amount;
  }

  Future<void> transfer({
    required String from,
    required String to,
    required double amount,
  }) async {
    await withdraw(phoneNumber: from, amount: amount);
    await deposit(phoneNumber: to, amount: amount);
  }
}
