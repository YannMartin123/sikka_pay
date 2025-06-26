import 'package:test/test.dart';
import 'package:sikka_pay/sikka_pay.dart';
import 'package:sikka_pay/src/infrastructure/fake_account_data_source.dart';

void main() {
  group('SikkaPay SDK (refonte)', () {
    late SikkaPay sdk;
    late FakeAccountDataSource db;

    setUp(() {
      db = FakeAccountDataSource();
      final repo = AccountRepository(db);
      sdk = SikkaPay(apiKey: 'demo-key', repository: repo);

      sdk.createAccount(
        phoneNumber: '611111111',
        initialBalance: 5000,
        pinCode: '1111',
      );
      sdk.createAccount(
        phoneNumber: '622222222',
        initialBalance: 3000,
        pinCode: '2222',
      );
    });

    test('Dépôt d’argent', () {
      sdk.deposit(phoneNumber: '611111111', amount: 1000);
      expect(sdk.getBalance('611111111'), 6000);
    });

    test('Retrait avec bon PIN', () {
      sdk.withdraw(phoneNumber: '611111111', amount: 1000, pinCode: '1111');
      expect(sdk.getBalance('611111111'), 4000);
    });

    test('Transfert entre comptes', () {
      sdk.transfer(
        from: '611111111',
        to: '622222222',
        amount: 500,
        pinCode: '1111',
      );
      expect(sdk.getBalance('611111111'), 4500);
      expect(sdk.getBalance('622222222'), 3500);
    });

    test('Erreur si mauvais PIN', () {
      expect(
        () => sdk.withdraw(
          phoneNumber: '611111111',
          amount: 1000,
          pinCode: '9999',
        ),
        throwsException,
      );
    });
  });
}
