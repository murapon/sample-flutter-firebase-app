import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DBMemo {
  /// メモを登録
  void register(uid, memo) {
    FirebaseFirestore.instance.collection('memo').add(
        {'uid': uid, 'memo': memo, 'create_at': DateTime.now(), 'update_at': DateTime.now()}); // データ
  }

  /// メモを更新
  void update(docId, memo) async {
    FirebaseFirestore.instance
        .collection('memo')
        .doc(docId)
        .update({'memo': memo, 'update_at': DateTime.now()});
  }

  /// メモを削除
  void delete(docId) {
    var _store = FirebaseFirestore.instance;
    _store.collection('memo').doc(docId).delete();
  }

  /// メモ一覧取得
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getList(uid) async {
    final _store = FirebaseFirestore.instance;
    var dbMemo = await _store
        .collection('memo')
        .where('uid', isEqualTo: uid)
        .orderBy('update_at', descending: true)
        .limit(300)
        .get();
    return dbMemo.docs;
  }

  /// メモ取得
  Future<Map<String, dynamic>?> get(docId) async {
    final _store = FirebaseFirestore.instance;
    var dbMemo = await _store.collection('memo').doc(docId).get();
    return dbMemo.data();
  }
}
