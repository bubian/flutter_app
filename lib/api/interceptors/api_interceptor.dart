
import 'package:dio/dio.dart';

class ApiInterceptor{

  static onSend(Options options){
    if(null == options) return;
    var data = options.data;
    if(null == data){
      data =  Map<String,String>();
    }
    data["sys_p"] = "a";
    data["sys_m"] = "MI 8 Lite";
    data["sys_v"] = "8.1.0";
    data["sys_d"] = "9367fb3f129427b08d0fc81329e729dd";
    data["cli_v"] = "7.5.4";
    data["sys_vc"] = "27";
    data["cli_c"] =  "medlinker";
    data["sys_pkg"] =  "app";
    data["sessName"] =  "777785894__sgOgWsSGqitjSfYcAGDaC9k8J450cDdnXTxnMFQIIHELvYwVqU41royOmR3NMf2T";
    data["sess"] =  "eyJpdiI6Imd2VmVzNWVHMzNLWHZYdDFpRnZqNlE9PSIsInZhbHVlIjoiQTVDRHFxcDFLeWRMV1NFcldQcndWT2J5Z1ZxcUY2bDgwVkd6elwvNXFvblk3S3dVdEhSNVZrdUlKbEtlNWhCVTBMNkJNeXJScjdkeXBsQ2NrM3VtajgyZkROc1A5UWw4cCtrYWR0SDZyMERBUXNEUENIQnNoQXJPMTZTZWZmN21BIiwibWFjIjoiY2RkNzk4ZDg1MmZhMmViMTIxMjBjZTc3MjBlY2NkMmU1ZmRlMDdlMmQ5MGU3ZDBmZWJjNGI1ODdkZWVkMDRlYiJ9";
  }

  static onSuccess(Options options){

  }

  static onError(Options options){
    print(options.toString());
  }
}