import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DBComment {
  /// コメントを登録
  void register(uuid, comment) {
    FirebaseFirestore.instance.collection('comment').add(
        {'uuid': uuid, 'comment': comment, 'create_at': DateTime.now(), 'update_at': DateTime.now()}); // データ
  }

  /// コメントを更新
  void update(docId, comment) async {
    FirebaseFirestore.instance
        .collection('comment')
        .doc(docId)
        .update({'comment': comment, 'update_at': DateTime.now()});
  }

  /// コメントを削除
  void delete(docId) {
    var db = FirebaseFirestore.instance;
    db.collection('comment').doc(docId).delete();
  }

  /// コメント一覧取得
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getList(uuid) async {
    final _store = FirebaseFirestore.instance;
    var comments = await _store
        .collection('comment')
        .where('uuid', isEqualTo: uuid)
        .orderBy('update_at', descending: true)
        .limit(300)
        .get();
    return comments.docs;
  }

  /// コメント取得
  Future<Map<String, dynamic>?> get(docId) async {
    final _store = FirebaseFirestore.instance;
    var comment = await _store.collection('comment').doc(docId).get();
    return comment.data();
  }
}
