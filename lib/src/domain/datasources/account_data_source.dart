import '../entities/account.dart';

abstract class AccountDataSource {
  Account? getAccount(String phoneNumber);
  void saveAccount(Account account);
  bool exists(String phoneNumber);
  bool authenticate(String phoneNumber, String pinCode);
  void clear(); // Pour les tests
}
