import 'package:dio/dio.dart';
import 'package:flutter_app/api/interceptors/api_interceptor.dart';

class DioManager extends Dio{

  factory DioManager() => _sharedInstance();
  static DioManager _dioManager = DioManager._();


  // 私有构造函数
  DioManager._(){
    // 添加拦截器
    interceptor.request.onSend = ApiInterceptor.onSend(options);
    interceptor.response.onSuccess= ApiInterceptor.onSuccess(options);
    interceptor.response.onError= ApiInterceptor.onError(options);
  }
  // 静态、同步、私有访问点
  static DioManager _sharedInstance() {
    return _dioManager;
  }

}