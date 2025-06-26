import '../domain/entities/account.dart';
import '../infrastructure/account_repository.dart';
import '../application/deposit_usecase.dart';
import '../application/withdraw_usecase.dart';
import '../application/transfer_usecase.dart';

class SikkaPay {
  final String apiKey;
  final AccountRepository _repository;

  final DepositUseCase _depositUseCase;
  final WithdrawUseCase _withdrawUseCase;
  final TransferUseCase _transferUseCase;

  SikkaPay({required this.apiKey})
    : _repository = AccountRepository(),
      _depositUseCase = DepositUseCase(AccountRepository()),
      _withdrawUseCase = WithdrawUseCase(AccountRepository()),
      _transferUseCase = TransferUseCase(AccountRepository());

  void createAccount({
    required String phoneNumber,
    required double initialBalance,
    required String pinCode,
  }) {
    final account = Account(
      phoneNumber: phoneNumber,
      balance: initialBalance,
      pinCode: pinCode,
    );
    _repository.createAccount(account);
  }

  double getBalance(String phoneNumber) {
    return _repository.getAccountOrThrow(phoneNumber).balance;
  }

  /// Déposer de l’argent dans un compte
  void deposit({required String phoneNumber, required double amount}) {
    _depositUseCase.execute(phoneNumber: phoneNumber, amount: amount);
  }

  /// Retirer de l’argent d’un compte (avec PIN)
  void withdraw({
    required String phoneNumber,
    required double amount,
    required String pinCode,
  }) {
    _withdrawUseCase.execute(
      phoneNumber: phoneNumber,
      amount: amount,
      pinCode: pinCode,
    );
  }

  /// Transférer de l’argent entre deux comptes (avec PIN)
  void transfer({
    required String from,
    required String to,
    required double amount,
    required String pinCode,
  }) {
    _transferUseCase.execute(
      from: from,
      to: to,
      amount: amount,
      pinCode: pinCode,
    );
  }
}
