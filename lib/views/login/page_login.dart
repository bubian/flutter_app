import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_app/config/native_build_config.dart';
import 'package:flutter_app/utils/regular_match.dart';
import 'package:flutter_app/views/common/dialog_graph_verify.dart';
import 'package:flutter_app/views/login/login_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/plugins/AppBuildInfo.dart';
import 'package:flutter_app/log/flutter_log.dart';
import 'package:flutter_app/routers/routers.dart';

/// 墨水瓶（`InkWell`）可用时使用的字体样式。
final TextStyle _availableStyle = TextStyle(
  fontSize: 16.0,
  color: const Color(0xFF00CACE),
);

/// 墨水瓶（`InkWell`）不可用时使用的样式。
final TextStyle _unavailableStyle = TextStyle(
  fontSize: 16.0,
  color: const Color(0xFFCCCCCC),
);

class LoginPage extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int countdown;

  const LoginPage({Key key, this.countdown: 60}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  /// 1 - 验证码登录 2 - 密¨码登录 3 - 邀请码登录
  int loginType = 1;

  /// 倒计时的计时器。
  Timer _timer;

  /// 当前倒计时的秒数。
  int _seconds;

  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;
  String _verifyStr = '获取验证码';


  TextEditingController _userController = new TextEditingController();
  TextEditingController _passWordController = new TextEditingController();

  void doLogin(String user,String pw) async {
    showLoadingDialog();
//    await LoginRequest.doLoginRequest(loginType, user, pw);
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pop();
    Navigator.of(context).pushNamedAndRemoveUntil(Routers.home,(Route<dynamic> route) => false);
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("登录中，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
  }

  Widget createTextField(BuildContext context, String hintText, int type,autovalidate,
      TextEditingController _controller) {
    return Theme(
      data: new ThemeData(primaryColor: Colors.red, hintColor: Color(0xffa8afc3)),
      child: new ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 54,
        ),
        child: new Padding(
          padding: EdgeInsets.only(left: 19, top: 15),
          child: new TextFormField(
            obscureText: 2 == type,
            controller: _controller,
            // 使用maxLength在有最大长度和当前输入长度的提示
            // maxLength: 1 == type ? 11 : 18,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(1 == type ? 11 : 18)
            ],
            autovalidate: autovalidate,
            validator: (value) {
              return value.length < 4 && value.length > 0 ? "密码长度不够4位" : null;
            },
            decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Color(0xffa8afc3),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                border: UnderlineInputBorder()),
          ),
        ),
      ),
    );
  }

  void _openGraphVerifyDialog(){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: new GraphVerifyDialog(
             callback: (){
               _startTimer();
             },
          ),
          contentPadding: EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(0),
        );
      }
    );
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    bool isActive = null == _timer ? false : _timer.isActive;
    if (isActive) {
      return;
    }
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.countdown;
        inkWellStyle = _availableStyle;
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = '${_seconds}s';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: <Widget>[new Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 78, left: 8, right: 27),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.fromLTRB(19, 0, 0, 0),
                child: new Text(
                  "首次使用手机登录",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
              new Stack(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 8, left: 19),
                    child: new Text(
                      "最高领99元红包",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  new Image.asset(
                    "assets/images/signin.webp",
                    width: 235,
                    height: 70,
                  ),
                ],
              ),
              new Container(
                margin: EdgeInsets.only(top: 15),
                child: createTextField(context, "请输入您的手机号码", 1, false,_userController),
              ),
              new Stack(
                children: <Widget>[
                  createTextField(context, "请输入短信验证码", 2, true,_passWordController),
                  new Container(
                    height: 54.0,
                    child: new Align(
                      alignment: FractionalOffset.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            String user = _userController.text.toString();
                            if (!RegularMatch.isChinaPhoneLegal(user)) {
                              Fluttertoast.showToast(
                                  msg: "请输入正确的电话号码!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  fontSize: 12,
                                  timeInSecForIos: 1);
                              return;
                            }
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new SimpleDialog(
                                    contentPadding:
                                    EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    children: <Widget>[GraphVerifyDialog()],
                                  );
                                });
                            _openGraphVerifyDialog();
                          });
                        },
                        child: new Visibility(
                          visible: 1 == loginType,
                          child: new GestureDetector(
                            onTap: (){_openGraphVerifyDialog();},
                            child: new Text(
                              _verifyStr,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                margin: EdgeInsets.only(left: 19, top: 25),
                child: new Stack(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        loginType = 3;
                        setState(() {});
                      },
                      child: new Text(
                        "我有邀请码",
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    new GestureDetector(
                      onTap: () {
                        loginType = (loginType == 2 ? 1 : 2);
                        _passWordController.clear();
                        setState(() {

                        });
                      },
                      child: new Align(
                        alignment: FractionalOffset.centerRight,
                        child: new Text(
                          2 == loginType ? "验证码登录" : "密码登陆",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 19, top: 25),
                child: new RaisedButton(
                  onPressed: () {
                    String user = _userController.text;
                    String pw = _passWordController.text;

                    RegExp exp = RegExp(
                        r'^((15[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
                    if (null == user || user.length < 11 || !exp.hasMatch(user)) {
                      Fluttertoast.showToast(
                          msg: "请输入正确的电话号码!", toastLength: Toast.LENGTH_SHORT);
                      return;
                    }

                    if (null == pw || pw.length < 6) {
                      Fluttertoast.showToast(
                          msg: "请输入正确的密码!", toastLength: Toast.LENGTH_SHORT);
                      return;
                    }
                    doLogin(user,pw);
                  },
//              color: Color(0xff095BAE),
                  color: Color(0xff017EFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22.5)),
                  ),
                  child: new Text(
                    "开启医联",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 19, top: 150),
                height: 40,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new GestureDetector(
                        onTap: () {},
                        child: new Container(
                          margin: EdgeInsets.only(right: 10.5),
                          child: new Stack(
                            children: <Widget>[
                              new Image.asset(
                                "assets/images/qq.webp",
                                height: 40,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              new Align(
                                alignment: FractionalOffset.center,
                                child: new Text(
                                  "QQ登陆",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                    new Expanded(
                      child: new GestureDetector(
                        onTap: () {},
                        child: new Container(
                          margin: EdgeInsets.only(left: 10.5),
                          child: new Stack(
                            children: <Widget>[
                              new Image.asset(
                                "assets/images/wechat.webp",
                                height: 40,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                              new Align(
                                alignment: FractionalOffset.center,
                                child: new Text(
                                  "微信登陆",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),],
      )
    );
  }
}
