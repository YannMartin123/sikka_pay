import '../domain/entities/account.dart';
import 'fake_database.dart';
import '../domain/exceptions/account_not_found_exception.dart';

class AccountRepository {
  Account getAccountOrThrow(String phoneNumber) {
    final account = FakeDatabase.getAccount(phoneNumber);
    if (account == null) throw AccountNotFoundException(phoneNumber);
    return account;
  }

  void saveAccount(Account account) {
    FakeDatabase.updateAccount(account);
  }

  bool authenticate(String phoneNumber, String pinCode) {
    final account = FakeDatabase.getAccount(phoneNumber);
    if (account == null) return false;
    return account.verifyPin(pinCode);
  }

  bool exists(String phoneNumber) {
    return FakeDatabase.accountExists(phoneNumber);
  }

  void createAccount(Account account) {
    if (exists(account.phoneNumber)) {
      throw Exception('Le compte ${account.phoneNumber} existe déjà.');
    }
    FakeDatabase.addAccount(account);
  }
}
