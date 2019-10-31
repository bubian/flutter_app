import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'routers/routers.dart';
import 'routers/application.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/utils/shared_preferences.dart';
import 'views/welcome_page/index.dart';
import 'package:flutter_app/utils/provider.dart';
import 'package:flutter_app/views/welcome_page/splash_page.dart';

SpUtil sp;
var db;
const int ThemeColor = 0xFFC91B3A;

class FlutterApp extends StatelessWidget {
  FlutterApp(){
    final router = new Router();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  showWelcomePage() {
    bool showWelcome = sp.getBool(sharedPreferencesKeys.showWelcome);
    return SplashPage();
//    if (showWelcome == null || showWelcome == true) {
//      return WelcomePage();
//    } else {
//      return null;
//    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(ThemeColor),
        backgroundColor: Color(0xFFEFEFEF),
        accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          //设置Material的默认字体样式
          body1: TextStyle(
              color: Color(0xFF888888),
              fontSize: 16.0,
              decoration: TextDecoration.none),
        ),
        iconTheme: IconThemeData(
          color: Color(ThemeColor),
          size: 35.0,
        ),
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          body: showWelcomePage()
      ),
      onGenerateRoute: Application.router.generator,
    );
  }
}

void main() async {
  final provider = new Provider();
  await provider.init(true);
  sp = await SpUtil.getInstance();
  db = Provider.db;
  runApp(FlutterApp());
}
