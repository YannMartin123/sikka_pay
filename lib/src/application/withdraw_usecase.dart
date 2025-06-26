import '../infrastructure/account_repository.dart';
import '../domain/exceptions/insufficient_funds_exception.dart';

class WithdrawUseCase {
  final AccountRepository repository;

  WithdrawUseCase(this.repository);

  void execute({
    required String phoneNumber,
    required double amount,
    required String pinCode,
  }) {
    if (!repository.authenticate(phoneNumber, pinCode)) {
      throw Exception('Code PIN incorrect.');
    }

    final account = repository.getAccountOrThrow(phoneNumber);

    if (account.balance < amount) {
      throw InsufficientFundsException(phoneNumber);
    }

    account.balance -= amount;
    repository.saveAccount(account);
  }
}
