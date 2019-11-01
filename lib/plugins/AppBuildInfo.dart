import 'package:flutter/services.dart';
import 'dart:async';


class AppBuildInfo{
  static const MethodChannel _channel = const MethodChannel('native_bridge');

  static Future<String> buildType() async{
    String res = await _channel.invokeMethod('getBuildType');
    return res;
  }
}