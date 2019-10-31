import 'dart:async';

import 'package:flutter/services.dart';

class NativeBridge {
  static const MethodChannel _channel =
      const MethodChannel('native_bridge');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
