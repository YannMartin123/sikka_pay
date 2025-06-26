import '../domain/entities/account.dart';

class FakeDatabase {
  static final Map<String, Account> _accounts = {
    '670000000': Account(
      phoneNumber: '670000000',
      balance: 10000,
      pinCode: '1234',
    ),
    '690000000': Account(
      phoneNumber: '690000000',
      balance: 8000,
      pinCode: '5678',
    ),
  };

  static Account? getAccount(String phoneNumber) {
    return _accounts[phoneNumber];
  }

  static void updateAccount(Account account) {
    _accounts[account.phoneNumber] = account;
  }

  static bool accountExists(String phoneNumber) {
    return _accounts.containsKey(phoneNumber);
  }

  static void addAccount(Account account) {
    _accounts[account.phoneNumber] = account;
  }

  static Map<String, Account> getAllAccounts() {
    return Map.unmodifiable(_accounts);
  }
}
