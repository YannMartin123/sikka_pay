import 'package:sikka_pay/sikka_pay.dart';

void main() {
  final repo = AccountRepository(FakeAccountDataSource());
  final sdk = SikkaPay(apiKey: 'demo-key', repository: repo);

  sdk.createAccount(
    phoneNumber: '670000000',
    initialBalance: 5000,
    pinCode: '1234',
  );
  sdk.createAccount(
    phoneNumber: '690000000',
    initialBalance: 3000,
    pinCode: '5678',
  );

  sdk.deposit(phoneNumber: '670000000', amount: 2000);
  print('Solde après dépôt: ${sdk.getBalance('670000000')}');

  sdk.withdraw(phoneNumber: '670000000', amount: 1000, pinCode: '1234');
  print('Solde après retrait: ${sdk.getBalance('670000000')}');

  sdk.transfer(
    from: '670000000',
    to: '690000000',
    amount: 500,
    pinCode: '1234',
  );

  print('Solde final émetteur: ${sdk.getBalance('670000000')}');
  print('Solde final receveur: ${sdk.getBalance('690000000')}');
}
