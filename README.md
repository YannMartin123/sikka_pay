# 📲 SikkaPay SDK

> Simulateur simple et extensible de service de paiement mobile en Dart.

SikkaPay permet de :
- Créer des comptes
- Effectuer des dépôts, retraits et transferts
- Consulter l’historique des transactions

Idéal pour tester, prototyper ou construire une base avant d’ajouter un backend réel.

---

## ✨ Fonctionnalités

✅ Créer un compte mobile  
✅ Déposer de l’argent  
✅ Retirer de l’argent (avec vérification du PIN)  
✅ Transférer de l’argent entre comptes  
✅ Accéder à l’historique des transactions

---

## ⚙️ Installation

Ajoutez dans votre `pubspec.yaml` :

```yaml
dependencies:
  sikka_pay: ^1.1.0
```
Puis lancez :
```
dart pub get
```
## 🚀 Premiers pas
### 1️⃣ Importer le SDK
```
import 'package:sikka_pay/sikka_pay.dart';
import 'package:sikka_pay/src/infrastructure/fake_account_data_source.dart';
```

### 2️⃣ Initialiser SikkaPay
```
final sdk = SikkaPay(
  apiKey: 'demo-key', // clé valide
  repository: AccountRepository(FakeAccountDataSource()),
);
```
## 🛠️ Utilisation
### ➕ Créer un compte
```
sdk.createAccount(
  phoneNumber: '699999999',
  initialBalance: 500,
  pinCode: '0000',
);
```
### 💰 Déposer de l’argent
```
sdk.deposit(phoneNumber: '699999999', amount: 200);
```

### ➖ Retirer de l’argent
```
sdk.withdraw(
  phoneNumber: '699999999',
  amount: 100,
  pinCode: '0000',
);
```
### 🔁 Transférer de l’argent
```
sdk.transfer(
  from: '699999999',
  to: '688888888',
  amount: 50,
  pinCode: '0000',
);
```

### 📜 Historique des transactions
```
final history = sdk.getTransactionHistory('699999999');

for (final tx in history) {
  print('${tx.type}: ${tx.amount} le ${tx.date}');
}
```
### 🧪 Exécuter les tests
Le SDK est livré avec des tests unitaires.
Lancez-les avec :
```
dart test
```

## 📝 Licence
MIT © Yann