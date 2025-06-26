class Account {
  final String phoneNumber;
  double balance;
  final String pinCode; // code PIN à 4 chiffres

  Account({
    required this.phoneNumber,
    required this.balance,
    required this.pinCode,
  }) {
    _validatePin(pinCode);
  }

  void _validatePin(String pin) {
    if (pin.length != 4 || int.tryParse(pin) == null) {
      throw ArgumentError('Le code PIN doit être composé de 4 chiffres.');
    }
  }

  /// Vérifie que le code PIN fourni est correct
  bool verifyPin(String inputPin) => inputPin == pinCode;
}
