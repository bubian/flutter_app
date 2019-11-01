import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/api/config/domain_name.dart';
import 'package:flutter_app/api/config/path_name.dart';
import 'package:flutter_app/api/dio_manager.dart';
import 'package:flutter_app/config/native_build_config.dart';
import 'package:flutter_app/log/flutter_log.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class LoginRequest{
  static Future doLoginRequest(int loginType,String user,String pw) async {
    var url = _getUrl(loginType);
    var d = Map<String,String>();
    d["username"] = user;
    d["password"] = pw;
    d["sys_p"] = "a";
    d["sys_m"] = "MI 8 Lite";
    d["sys_v"] = "8.1.0";
    d["sys_d"] = "9367fb3f129427b08d0fc81329e729dd";
    d["cli_v"] = "7.5.4";
    d["sys_vc"] = "27";
    d["cli_c"] =  "medlinker";
    d["sys_pkg"] =  "app";
    d["sessName"] =  "777785894__sgOgWsSGqitjSfYcAGDaC9k8J450cDdnXTxnMFQIIHELvYwVqU41royOmR3NMf2T";
    d["sess"] =  "eyJpdiI6Imd2VmVzNWVHMzNLWHZYdDFpRnZqNlE9PSIsInZhbHVlIjoiQTVDRHFxcDFLeWRMV1NFcldQcndWT2J5Z1ZxcUY2bDgwVkd6elwvNXFvblk3S3dVdEhSNVZrdUlKbEtlNWhCVTBMNkJNeXJScjdkeXBsQ2NrM3VtajgyZkROc1A5UWw4cCtrYWR0SDZyMERBUXNEUENIQnNoQXJPMTZTZWZmN21BIiwibWFjIjoiY2RkNzk4ZDg1MmZhMmViMTIxMjBjZTc3MjBlY2NkMmU1ZmRlMDdlMmQ5MGU3ZDBmZWJjNGI1ODdkZWVkMDRlYiJ9";
    print("url = $url");
    FLog.i("url = $url");
    Response response = await DioManager().get(url,data: d);

    if (response.statusCode== HttpStatus.ok) {
      var json = await response.data;
      var data = jsonDecode(json);
      print(data.toString());
    } else {
      Fluttertoast.showToast(msg: "登录失败!");
    }
  }

  static _getUrl(int loginType){
    String buildType = NativeBuildConfig.nativeBuildType;
    FLog.i("native build type = $buildType");
    if(1 == loginType){
      return DomainName.getBaseUrl() + PathName.LOGIN_VC_PATH;
    }else{
      return DomainName.getBaseUrl() + PathName.LOGIN_PW_PATH;
    }
  }

  static getVerifyCode(){

  }
}