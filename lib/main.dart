import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'cache/CacheAppVersion.dart';
import 'storage/DBAppVersion.dart';
import 'views/pages/memo_detail_page.dart';
import 'views/pages/memo_list_page.dart';
import 'views/pages/memo_register_page.dart';
import 'views/pages/memo_update_page.dart';
import 'views/pages/default_page.dart';
import 'views/pages/top_page.dart';
import 'views/pages/version_up_page.dart';

Future<void> main() async {
  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // アプリのビルドナンバーを取得し、今のビルドナンバー以下だったらバージョンアップを促す
  DBAppVersion dbAppVersion = DBAppVersion();
  var version = await dbAppVersion.getVersion();
  final info = await PackageInfo.fromPlatform();
  if (version!['build_number'] > int.parse(info.buildNumber)) {
    // アプリ内のバージョンと違ったら強制バージョンアップ
    CacheAppVersion().downloadUrl = version['android_url'];
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          ),
      home: VersionUpPage(),
    ));
    return;
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp() : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => DefaultPage());
            case '/top':
              return MaterialPageRoute(builder: (_) => TopPage(arguments: settings.arguments));
            case '/memo_list':
              return MaterialPageRoute(builder: (_) => MemoListPage());
            case '/memo_detail':
              return MaterialPageRoute(builder: (_) => MemoDetailPage(arguments: settings.arguments));
            case '/memo_register':
              return MaterialPageRoute(builder: (_) => MemoRegisterPage());
            case '/memo_update':
              return MaterialPageRoute(builder: (_) => MemoUpdatePage(arguments: settings.arguments));
          }
        });
  }
}
