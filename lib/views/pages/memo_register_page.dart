import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../storage/DBMemo.dart';
import '../widgets/ShowDialog.dart';

class MemoRegisterPage extends StatefulWidget {
  final arguments;

  const MemoRegisterPage({this.arguments});

  @override
  _MemoRegisterPageState createState() => _MemoRegisterPageState();
}

class _MemoRegisterPageState extends State<MemoRegisterPage> {
  String memo = '';

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
            decoration: const InputDecoration(labelText: 'メモ'),
            onChanged: (value) {
              memo = value;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (memo == '') {
                ShowDialog.displayConfirmDialog(context, 'エラーメッセージ');
              } else {
                FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                var uid = firebaseAuth.currentUser?.uid;
                DBMemo dbMemo = DBMemo();
                dbMemo.register(uid, memo);
                Navigator.pushNamed(context, '/memo_list', arguments: {});
              }
            },
            child: const Text('登録'),
          ),
        ]),
      ),
    );
  }
}
