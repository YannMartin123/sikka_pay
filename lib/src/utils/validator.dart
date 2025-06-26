class Validator {
  static void phone(String phone) {
    if (!RegExp(r'^\d{9}$').hasMatch(phone)) {
      throw ArgumentError('Numéro invalide : doit contenir 9 chiffres.');
    }
  }

  static void pin(String pin) {
    if (!RegExp(r'^\d{4}$').hasMatch(pin)) {
      throw ArgumentError('PIN invalide : doit contenir 4 chiffres.');
    }
  }

  static void amount(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Montant invalide : doit être > 0.');
    }
  }
}
