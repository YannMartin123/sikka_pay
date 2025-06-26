import '../domain/entities/account.dart';
import '../domain/datasources/account_data_source.dart';

class AccountRepository {
  final AccountDataSource dataSource;

  AccountRepository(this.dataSource);

  void createAccount(Account account) {
    if (dataSource.exists(account.phoneNumber)) {
      throw Exception('Le compte ${account.phoneNumber} existe déjà.');
    }
    dataSource.saveAccount(account);
  }

  Account getAccountOrThrow(String phoneNumber) {
    final acc = dataSource.getAccount(phoneNumber);
    if (acc == null) {
      throw Exception('Compte introuvable: $phoneNumber');
    }
    return acc;
  }

  void update(Account account) => dataSource.saveAccount(account);

  // ✅ Ajoute ces deux méthodes
  bool authenticate(String phoneNumber, String pinCode) {
    return dataSource.authenticate(phoneNumber, pinCode);
  }

  void saveAccount(Account account) {
    dataSource.saveAccount(account);
  }

  void clear() => dataSource.clear();
}
