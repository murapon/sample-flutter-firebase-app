import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  final arguments;

  const TopPage({this.arguments});

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('サンプルアプリタイトル'), automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('登録する'),
              onPressed: () {
                Navigator.pushNamed(context, '/memo_register', arguments: {});
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text('一覧'),
              onPressed: () {
                Navigator.pushNamed(context, '/memo_list', arguments: {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
