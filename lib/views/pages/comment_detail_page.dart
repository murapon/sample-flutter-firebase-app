import 'package:flutter/material.dart';

import '../../storage/DBComment.dart';

class CommentDetailPage extends StatefulWidget {
  final arguments;

  const CommentDetailPage({this.arguments});

  @override
  _CommentDetailPageState createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage> {
  late Map _request;
  String displayComment = '';

  @override
  void initState() {
    super.initState();
    _request = Map<String, dynamic>.from(widget.arguments);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細'),
        leading: IconButton(
          icon: const Icon(Icons.list),
          iconSize: 30,
          onPressed: () => setState(
            () {
              Navigator.pushNamed(context, '/comment_list');
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(displayComment),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('変更'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/comment_update', arguments: {'doc_id': _request['doc_id']});
                  },
                ),
                ElevatedButton(
                  child: const Text('削除'),
                  onPressed: () {
                    showDialog<int>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text('削除してもいいですか？'),
                          actions: <Widget>[
                            OutlinedButton(
                              child: const Text('キャンセル'),
                              onPressed: () => Navigator.of(context).pop(1),
                            ),
                            OutlinedButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  DBComment dbComment = DBComment();
                                  dbComment.delete(_request['doc_id']);
                                  Navigator.pushNamed(context, '/comment_list');
                                }),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void load() async {
    // コメント取得
    DBComment dbComment = DBComment();
    var comment = await dbComment.get(_request['doc_id']);
    displayComment = comment!['comment'];
    setState(() {});
  }
}
