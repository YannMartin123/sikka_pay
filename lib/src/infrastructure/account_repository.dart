import 'package:sikka_pay/src/domain/entities/transaction.dart';
import '../domain/entities/account.dart';
import '../domain/datasources/account_data_source.dart';

class AccountRepository {
  final AccountDataSource dataSource;

  AccountRepository(this.dataSource);

  void createAccount(Account account) {
    if (exists(account.phoneNumber)) {
      throw Exception('Le compte ${account.phoneNumber} existe déjà.');
    }
    dataSource.saveAccount(account);
  }

  bool exists(String phoneNumber) {
    return dataSource.exists(phoneNumber);
  }

  Account getAccountOrThrow(String phoneNumber) {
    final acc = dataSource.getAccount(phoneNumber);
    if (acc == null) {
      throw Exception('Compte introuvable: $phoneNumber');
    }
    return acc;
  }

  bool authenticate(String phoneNumber, String pinCode) {
    return dataSource.authenticate(phoneNumber, pinCode);
  }

  void update(Account account) => dataSource.saveAccount(account);

  void saveAccount(Account account) {
    dataSource.saveAccount(account);
  }

  void clear() => dataSource.clear();

  void saveTransaction(Transaction tx) => dataSource.saveTransaction(tx);

  List<Transaction> getTransactions(String phone) =>
      dataSource.getTransactions(phone);
}
