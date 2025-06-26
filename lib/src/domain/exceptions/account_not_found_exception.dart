// account_not_found_exception.dart
class AccountNotFoundException implements Exception {
  final String phoneNumber;
  AccountNotFoundException(this.phoneNumber);
  @override
  String toString() => 'AccountNotFoundException: $phoneNumber non trouvé';
}
