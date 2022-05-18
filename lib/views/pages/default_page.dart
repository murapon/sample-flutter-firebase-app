import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage();

  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  bool isUser = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('サンプルアプリ'),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  void _load() async {
    // ユーザー取得
    FirebaseAuth firebaseAuth = await FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      // 登録済み
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/top', arguments: {});
      });
    }

    if (firebaseAuth.currentUser == null) {
      try {
        await firebaseAuth.signInAnonymously();
      } catch (e) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('サンプルアプリ'),
              content: Text(e.toString()),
            );
          },
        );
      }
    }

    Navigator.pushNamed(context, '/top', arguments: {});
    return;
  }
}
