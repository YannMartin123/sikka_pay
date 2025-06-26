import 'package:sikka_pay/sikka_pay.dart';

void main() {
  final sdk = SikkaPay(apiKey: 'demo-key');

  // Dépôt (pas besoin de PIN)
  sdk.deposit(phoneNumber: '670000000', amount: 3000);

  // Retrait (avec PIN)
  sdk.withdraw(phoneNumber: '670000000', amount: 500, pinCode: '1234');

  // Transfert (avec PIN)
  sdk.transfer(
    from: '670000000',
    to: '690000000',
    amount: 1000,
    pinCode: '1234',
  );

  print('Transactions simulées avec succès ✅');
}
