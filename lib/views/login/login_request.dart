import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/config/domain_name.dart';
import 'package:flutter_app/api/config/path_name.dart';
import 'package:flutter_app/api/dio_manager.dart';
import 'package:flutter_app/config/native_build_config.dart';
import 'package:flutter_app/log/flutter_log.dart';
import 'package:flutter_app/routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class LoginRequest{
  static Future doLoginRequest(int loginType,String user,String pw) async {
    var url = _getUrl(loginType);
    var d = Map<String,String>();
    print("url = $url");
    FLog.i("url = $url");
    Response response = await DioManager().get(url,data: d);

    if (response.statusCode== HttpStatus.ok) {
      var json = await response.data;
//      var data = jsonDecode(json);
      print(json);
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