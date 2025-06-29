import 'package:sikka_pay/src/domain/entities/transaction.dart';

import '../domain/datasources/account_data_source.dart';
import '../domain/entities/account.dart';

class FakeAccountDataSource implements AccountDataSource {
  final Map<String, Account> _accounts = {};
  final Map<String, List<Transaction>> _transactionHistory = {};

  @override
  Account? getAccount(String phoneNumber) => _accounts[phoneNumber];

  @override
  void saveAccount(Account account) {
    _accounts[account.phoneNumber] = account;
  }

  @override
  bool exists(String phoneNumber) => _accounts.containsKey(phoneNumber);

  @override
  bool authenticate(String phoneNumber, String pinCode) {
    final acc = getAccount(phoneNumber);
    return acc != null && acc.pinCode == pinCode;
  }

  @override
  void clear() => _accounts.clear();

  @override
  void saveTransaction(Transaction tx) {
    _transactionHistory.putIfAbsent(tx.phoneNumber, () => []);
    _transactionHistory[tx.phoneNumber]!.add(tx);
  }

  @override
  List<Transaction> getTransactions(String phoneNumber) {
    return _transactionHistory[phoneNumber] ?? [];
  }
}
