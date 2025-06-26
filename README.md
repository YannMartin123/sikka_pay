# SikkaPay 🟠

SikkaPay est une SDK Dart légère permettant de simuler les fonctionnalités d’un portefeuille mobile comme Orange Money ou MTN Mobile Money.

## ✨ Fonctionnalités

- Création de compte avec PIN
- Dépôt, retrait et transfert d’argent
- Validation automatique (numéro, montant, PIN)
- Injection de base de données (Fake ou vraie)
- Gestion simple des clés API

---

## 🚀 Installation

Ajoutez ceci à votre `pubspec.yaml` :

```yaml
dependencies:
  sikka_pay:
    git:
      url: https://github.com/votre-utilisateur/sikka_pay.git

🔧 Exemple d’utilisation
dart
Copier
Modifier
import 'package:sikka_pay/sikka_pay.dart';

void main() {
  final repo = AccountRepository(FakeAccountDataSource());
  final sdk = SikkaPay(apiKey: 'demo-key', repository: repo);

  sdk.createAccount(phoneNumber: '670000000', initialBalance: 5000, pinCode: '1234');
  sdk.deposit(phoneNumber: '670000000', amount: 1000);
  print(sdk.getBalance('670000000')); // 6000.0
}