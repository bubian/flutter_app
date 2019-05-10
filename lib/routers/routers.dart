import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './router_hander.dart';
import '../widgets/index.dart';

class Routers {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";
  static String webViewPage = '/web-view-page';

  static void configureRoutes(Router router) {
    List widgetLists = new WidgetList().getWidgetList();
    router.notFoundHandler = new Handler(
        handlerFunc:
            (BuildContext context, Map<String, List<String>> params) {});
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);

    widgetLists.forEach((r){
      Handler handler = new Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return r.buildRouter(context);
      });
      router.define('${r.routerName}', handler: handler);
    });
  }
}
