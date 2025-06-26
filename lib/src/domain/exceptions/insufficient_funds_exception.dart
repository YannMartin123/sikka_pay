// account_not_found_exception.dart
class InsufficientFundsException implements Exception {
  final String phoneNumber;
  InsufficientFundsException(this.phoneNumber);
  @override
  String toString() =>
      'InsufficientFundsException: solde du numero $phoneNumber non suffisant ';
}
