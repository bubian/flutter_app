import 'package:flutter_app/config/native_build_config.dart';

class DomainName{

  static String getBaseUrl() {
    //接口服务器
    String url = "";
    switch (NativeBuildConfig.nativeBuildType) {
      case "debug"://dev
        url = "";
        break;
      case "release"://test
        url = "";
        break;
      default:
        break;
    }
    return url;
  }
}