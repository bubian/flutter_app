import 'package:flutter_app/config/native_build_config.dart';

class DomainName{

  static String getBaseUrl() {
    //接口服务器
    String url = "http://app.dev.pdt5.medlinker.net/rest/v1";
    switch (NativeBuildConfig.nativeBuildType) {
      case "debug"://dev
        url = "http://app.qa.medlinker.com/rest/v1";
        break;
      case "release"://test
        url = "https://app.medlinker.com/rest/v1";
        break;
      default:
        break;
    }
    return url;
  }
}