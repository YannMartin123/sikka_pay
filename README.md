# 🧾 SikkaPay

SikkaPay is a lightweight Dart SDK that simulates mobile money operations (deposit, withdraw, transfer)
with simple in-memory logic and PIN-based authentication.

## 🔧 Features

- ✅ Deposit money without PIN
- ✅ Withdraw money with PIN
- ✅ Transfer money with PIN
- ✅ Create accounts with initial balance and 4-digit PIN

## 🚀 Usage

```dart
import 'package:sikka_pay/sikka_pay.dart';

void main() {
  final sdk = SikkaPay(apiKey: 'your-api-key');

  sdk.createAccount(phoneNumber: '670000000', initialBalance: 5000, pinCode: '1234');
  sdk.deposit(phoneNumber: '670000000', amount: 2000);
  sdk.withdraw(phoneNumber: '670000000', amount: 1000, pinCode: '1234');
  print(sdk.getBalance('670000000')); // 6000
}
