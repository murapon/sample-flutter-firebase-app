import 'package:flutter/material.dart';

import '../../storage/DBMemo.dart';
import '../widgets/ShowDialog.dart';

class MemoUpdatePage extends StatefulWidget {
  final arguments;

  const MemoUpdatePage({this.arguments});

  @override
  _MemoUpdatePageState createState() => _MemoUpdatePageState();
}

class _MemoUpdatePageState extends State<MemoUpdatePage> {
  late Map _request;
  String memo = '';

  @override
  void initState() {
    super.initState();
    _request = Map<String, dynamic>.from(widget.arguments);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('変更')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              maxLength: 50,
              controller: TextEditingController(text: memo), //ここに初期値
              onChanged: (value) {
                memo = value;
              },
            ),
            ElevatedButton(
              child: const Text('変更'),
              onPressed: () async {
                if (memo == '') {
                  ShowDialog.displayConfirmDialog(context, 'エラーメッセージ');
                } else {
                  DBMemo dbMemo = DBMemo();
                  dbMemo.update(_request['doc_id'], memo);
                  Navigator.pushNamed(context, '/memo_detail', arguments: {
                    'doc_id': _request['doc_id'],
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void load() async {
    // メモ取得
    DBMemo dbMemo = DBMemo();
    var data = await dbMemo.get(_request['doc_id']);
    memo = data!['memo'];
    setState(() {});
  }
}
