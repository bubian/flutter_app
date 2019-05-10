import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/login/page_login.dart';

// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//    return new AppPage();
    return null;
  },
);

// login的首页
var loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new LoginPage();
  },
);