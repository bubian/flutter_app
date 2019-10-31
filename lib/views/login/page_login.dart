import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils/regular_match.dart';
import 'package:flutter_app/views/common/dialog_graph_verify.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  /// 1 - 验证码登录 2 - 密码登录 3 - 邀请码登录
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

  void doLogin() async {
    var url = _getUrl();
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data.toString());
    } else {
      Fluttertoast.showToast(msg: "登录失败!");
    }
  }

  _getUrl(){
    if(1 == loginType){
      return "";
    }else if(2 == loginType){

    }else{
      return "";
    }
  }

  _getVerifyCode(){

  }

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
  }

  Widget createTextField(BuildContext context, String hintText, int type,
      TextEditingController _controller) {
    return Theme(
      data:
          new ThemeData(primaryColor: Colors.red, hintColor: Color(0xffa8afc3)),
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
            autovalidate: true,
            validator: (value) {
              return value.length < 4 ? "密码长度不够4位" : null;
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
        //todo
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
      body: new Container(
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
              child: createTextField(context, "请输入您的手机号码", 1, _userController),
            ),
            new Stack(
              children: <Widget>[
                createTextField(context, "请输入短信验证码", 2, _passWordController),
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
                          _startTimer();
                        });
                      },
                      child: new Visibility(
                        visible: 1 == loginType,
                        child: new Text(
                          _verifyStr,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
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
                  String passwd = _passWordController.text;

                  RegExp exp = RegExp(
                      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
                  if (null == user || user.length < 11 || !exp.hasMatch(user)) {
                    Fluttertoast.showToast(
                        msg: "请输入正确的电话号码!", toastLength: Toast.LENGTH_SHORT);
                    return;
                  }

                  if (null == passwd || passwd.length < 6) {
                    Fluttertoast.showToast(
                        msg: "请输入正确的密码!", toastLength: Toast.LENGTH_SHORT);
                    return;
                  }
                  doLogin();
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
      ),
    );
  }
}
