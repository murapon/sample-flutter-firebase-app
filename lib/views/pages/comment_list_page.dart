import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../storage/DBComment.dart';

class CommentListPage extends StatefulWidget {
  final arguments;

  const CommentListPage({this.arguments});

  @override
  _CommentListPageState createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentListPage> {
  List displayComments = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.action);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('一覧'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          iconSize: 30,
          onPressed: () => setState(
            () {
              Navigator.pushNamed(context, '/top');
            },
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          (() {
            if (displayComments.isNotEmpty) {
              return Expanded(
                child: Scrollbar(
                  isAlwaysShown: true, // true: スクロール時以外もバーを表示する
                  /// スクロールする領域
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayComments.length,
                        itemBuilder: (context, index) {
                          var comment = displayComments[index];
                          return Container(
                            child: ListTile(
                              title: Text(
                                comment['comment'],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/comment_detail', arguments: {
                                  'doc_id': comment['doc_id'],
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: Text('コメントはありません'));
            }
          })(),
        ],
      ),
    );
  }

  void _load() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var uid = firebaseAuth.currentUser?.uid;
    DBComment dbComment = DBComment();
    var dbComments = await dbComment.getList(uid);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        for (final dbComment in dbComments) {
          var comment = dbComment.data();
          displayComments.add({
            'doc_id': dbComment.id,
            'comment': comment['comment'],
          });
        }
      });
    });
  }
}
