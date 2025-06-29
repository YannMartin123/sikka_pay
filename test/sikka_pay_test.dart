import 'package:sikka_pay/src/domain/entities/transaction.dart';
import 'package:test/test.dart';
import 'package:sikka_pay/sikka_pay.dart';
import 'package:sikka_pay/src/infrastructure/fake_account_data_source.dart';
import 'package:sikka_pay/src/infrastructure/account_repository.dart';

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

  test('SikkaPay SDK (v1.1.0) Historique des transactions', () {
    final db = FakeAccountDataSource();
    final sdk = SikkaPay(apiKey: 'demo-key', repository: AccountRepository(db));

    sdk.createAccount(
      phoneNumber: '699999999',
      initialBalance: 100,
      pinCode: '0000',
    );

    sdk.deposit(phoneNumber: '699999999', amount: 1000);
    sdk.withdraw(phoneNumber: '699999999', amount: 300, pinCode: '0000');

    final history = sdk.getTransactionHistory('699999999');
    expect(history.length, 2);

    // On s’assure de l’ordre chronologique exact
    expect(history.first.type, TransactionType.deposit);
    expect(history.last.type, TransactionType.withdrawal);
  });
}
