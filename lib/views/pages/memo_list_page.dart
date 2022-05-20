import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../storage/DBMemo.dart';

class MemoListPage extends StatefulWidget {
  final arguments;

  const MemoListPage({this.arguments});

  @override
  _MemoListPageState createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  List displayMemoList = [];

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
            if (displayMemoList.isNotEmpty) {
              return Expanded(
                child: Scrollbar(
                  isAlwaysShown: true, // true: スクロール時以外もバーを表示する
                  /// スクロールする領域
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayMemoList.length,
                        itemBuilder: (context, index) {
                          var memo = displayMemoList[index];
                          return Container(
                            child: ListTile(
                              title: Text(
                                memo['memo'],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/memo_detail', arguments: {
                                  'doc_id': memo['doc_id'],
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
              return const Center(child: Text('メモはありません'));
            }
          })(),
        ],
      ),
    );
  }

  void _load() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var uid = firebaseAuth.currentUser?.uid;
    DBMemo dbMemo = DBMemo();
    var memoList = await dbMemo.getList(uid);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        for (final memo in memoList) {
          var memoData = memo.data();
          displayMemoList.add({
            'doc_id': memo.id,
            'memo': memoData['memo'],
          });
        }
      });
    });
  }
}
