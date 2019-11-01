import 'package:flutter_app/config/native_build_config.dart';
import 'package:flutter_app/plugins/AppBuildInfo.dart';
class ConfigInit{

  static initNativeConfig() async{
    String res = await AppBuildInfo.buildType();
    NativeBuildConfig.nativeBuildType = res;
  }
}