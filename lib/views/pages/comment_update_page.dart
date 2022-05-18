import 'package:flutter/material.dart';

import '../../storage/DBComment.dart';
import '../widgets/ShowDialog.dart';

class CommentUpdatePage extends StatefulWidget {
  final arguments;

  const CommentUpdatePage({this.arguments});

  @override
  _CommentUpdatePageState createState() => _CommentUpdatePageState();
}

class _CommentUpdatePageState extends State<CommentUpdatePage> {
  late Map _request;
  String comment = '';

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
              controller: TextEditingController(text: comment), //ここに初期値
              onChanged: (value) {
                comment = value;
              },
            ),
            ElevatedButton(
              child: const Text('変更'),
              onPressed: () async {
                if (comment == '') {
                  ShowDialog.displayConfirmDialog(context, 'エラーメッセージ');
                } else {
                  DBComment dbComment = DBComment();
                  dbComment.update(_request['doc_id'], comment);
                  Navigator.pushNamed(context, '/comment_detail', arguments: {
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
    // コメント取得
    DBComment dbComment = DBComment();
    var data = await dbComment.get(_request['doc_id']);
    comment = data!['comment'];
    setState(() {});
  }
}
