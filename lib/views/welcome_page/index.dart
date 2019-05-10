
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/welcome_page/splash_page.dart';

class WelcomePage extends StatefulWidget{
  WelcomePage({Key key}):super(key:key);

  @override
  _WelcomePageState createState() {
    return new _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: SplashPage()
    );
  }
}