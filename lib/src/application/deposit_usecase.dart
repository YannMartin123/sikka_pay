import 'package:sikka_pay/src/domain/entities/transaction.dart';

import '../infrastructure/account_repository.dart';

class DepositUseCase {
  final AccountRepository repository;

  DepositUseCase(this.repository);

  void execute({required String phoneNumber, required double amount}) {
    if (amount <= 0) {
      throw ArgumentError('Le montant doit être supérieur à zéro');
    }

    final account = repository.getAccountOrThrow(phoneNumber);
    account.balance += amount;
    repository.saveAccount(account);

    repository.saveTransaction(
      Transaction(
        phoneNumber: phoneNumber,
        type: TransactionType.deposit,
        amount: amount,
        date: DateTime.now(),
      ),
    );
  }
}
