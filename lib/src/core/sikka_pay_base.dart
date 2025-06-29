import 'package:sikka_pay/src/domain/entities/transaction.dart';

import '../domain/entities/account.dart';
import '../infrastructure/account_repository.dart';
import '../utils/logger.dart';
import '../utils/validator.dart';
import 'api_key_guard.dart';

import '../application/deposit_usecase.dart';
import '../application/withdraw_usecase.dart';
import '../application/transfer_usecase.dart';

class SikkaPay {
  final String _apiKey;
  final AccountRepository _repository;

  final DepositUseCase _deposit;
  final WithdrawUseCase _withdraw;
  final TransferUseCase _transfer;

  SikkaPay({required String apiKey, required AccountRepository repository})
    : _apiKey = apiKey,
      _repository = repository,
      _deposit = DepositUseCase(repository),
      _withdraw = WithdrawUseCase(repository),
      _transfer = TransferUseCase(repository) {
    ApiKeyGuard.verify(apiKey);
    Logger.info('SDK initialisée avec $_apiKey');
  }

  void createAccount({
    required String phoneNumber,
    required double initialBalance,
    required String pinCode,
  }) {
    ApiKeyGuard.check(_apiKey);

    Validator.phone(phoneNumber);
    Validator.amount(initialBalance);
    Validator.pin(pinCode);

    if (_repository.exists(phoneNumber)) {
      throw Exception('Le compte $phoneNumber existe déjà.');
    }

    final account = Account(
      phoneNumber: phoneNumber,
      balance: initialBalance,
      pinCode: pinCode,
    );

    _repository.saveAccount(account);
    Logger.info('Compte créé : $phoneNumber');
  }

  double getBalance(String phoneNumber) {
    Validator.phone(phoneNumber);
    return _repository.getAccountOrThrow(phoneNumber).balance;
  }

  void deposit({required String phoneNumber, required double amount}) {
    Validator.phone(phoneNumber);
    Validator.amount(amount);
    Logger.info('Dépôt de $amount sur $phoneNumber');
    _deposit.execute(phoneNumber: phoneNumber, amount: amount);
  }

  void withdraw({
    required String phoneNumber,
    required double amount,
    required String pinCode,
  }) {
    Validator.phone(phoneNumber);
    Validator.amount(amount);
    Validator.pin(pinCode);
    Logger.info('Retrait de $amount depuis $phoneNumber');
    _withdraw.execute(
      phoneNumber: phoneNumber,
      amount: amount,
      pinCode: pinCode,
    );
  }

  void transfer({
    required String from,
    required String to,
    required double amount,
    required String pinCode,
  }) {
    Validator.phone(from);
    Validator.phone(to);
    Validator.amount(amount);
    Validator.pin(pinCode);
    Logger.info('Transfert de $amount de $from vers $to');
    _transfer.execute(from: from, to: to, amount: amount, pinCode: pinCode);
  }

  List<Transaction> getTransactionHistory(String phoneNumber) {
    return _repository.getTransactions(phoneNumber);
  }
}
