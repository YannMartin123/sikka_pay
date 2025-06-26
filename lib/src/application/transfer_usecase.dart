import '../infrastructure/account_repository.dart';
import '../domain/exceptions/insufficient_funds_exception.dart';

class TransferUseCase {
  final AccountRepository repository;

  TransferUseCase(this.repository);

  void execute({
    required String from,
    required String to,
    required double amount,
    required String pinCode,
  }) {
    if (!repository.authenticate(from, pinCode)) {
      throw Exception('Code PIN incorrect.');
    }

    final sender = repository.getAccountOrThrow(from);
    final receiver = repository.getAccountOrThrow(to);

    if (sender.balance < amount) {
      throw InsufficientFundsException(from);
    }

    sender.balance -= amount;
    receiver.balance += amount;

    repository.saveAccount(sender);
    repository.saveAccount(receiver);
  }
}
