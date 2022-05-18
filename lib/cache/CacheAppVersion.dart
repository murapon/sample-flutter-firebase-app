class CacheAppVersion {
  static final CacheAppVersion _instance = CacheAppVersion._internal();
  CacheAppVersion._internal();
  factory CacheAppVersion() => _instance;

  // キャッシュで保持するデータ
  String downloadUrl = '';
}
