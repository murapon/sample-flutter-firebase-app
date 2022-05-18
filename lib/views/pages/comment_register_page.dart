import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../storage/DBComment.dart';
import '../widgets/ShowDialog.dart';

class CommentRegisterPage extends StatefulWidget {
  final arguments;

  const CommentRegisterPage({this.arguments});

  @override
  _CommentRegisterPageState createState() => _CommentRegisterPageState();
}

class _CommentRegisterPageState extends State<CommentRegisterPage> {
  String comment = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登録')),
      body: Center(
        child: Column(children: <Widget>[
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(labelText: 'コメント', hintText: '・・・・・・'),
            onChanged: (value) {
              comment = value;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (comment == '') {
                ShowDialog.displayConfirmDialog(context, 'エラーメッセージ');
              } else {
                FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                var uid = firebaseAuth.currentUser?.uid;
                DBComment dbComment = DBComment();
                dbComment.register(uid, comment);
                Navigator.pushNamed(context, '/comment_list', arguments: {});
              }
            },
            child: const Text('登録'),
          ),
        ]),
      ),
    );
  }
}
