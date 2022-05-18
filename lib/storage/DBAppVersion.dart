
import 'package:cloud_firestore/cloud_firestore.dart';

class DBAppVersion {
  /// アカウント情報を取得
  Future<Map<String, dynamic>?> getVersion() async {
    final _firebase = FirebaseFirestore.instance;
    var _versions = await _firebase
        .collection('app_version')
        .doc('gkuScFwZVeWytbL9kIUY')
        .get();
    return _versions.data();
  }
}
