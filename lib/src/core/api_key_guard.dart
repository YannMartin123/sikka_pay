class ApiKeyGuard {
  static const _validKeys = ['demo-key', 'test-key'];

  static void verify(String key) {
    if (!_validKeys.contains(key)) {
      throw Exception('Clé API invalide.');
    }
  }

  /// Méthode raccourcie pour une vérification plus lisible
  static void check(String key) => verify(key);
}
