import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GraphVerifyDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CodeDialog(callback: callback);

  final Function() callback;
  GraphVerifyDialog({this.callback});
}

class CodeDialog extends State<GraphVerifyDialog> {

  double xOffset;
  Function() callback;

  CodeDialog({this.xOffset: 0,this.callback});

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.minPositive,
      height: 280,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: <Widget>[
              new Image(
                width: double.infinity,
                alignment: Alignment.center,
                fit: BoxFit.fill,
                height: 175,
                image:AssetImage("assets/images/food04.jpeg"),

              ),
              new Container(
                width: 65,
                height: 65,
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: new BoxDecoration(
                  color: Color(0xffffffff),
                  shape: BoxShape.rectangle,

                ),
              ),

              new Transform(
                transform: Matrix4.translationValues(xOffset + 20,0,0),
                child: new Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 15),
                  child: new Image(
                    width: 65,
                    height: 65,
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    image:AssetImage("assets/images/food06.jpeg"),
                  ),
                ),
              ),
            ],
          ),
          new Padding(
            padding: EdgeInsets.only(top: 19, bottom: 15),
            child: new Text(
              "拖动滑块，把图片拼合就验证成功啦!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ),
          new Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              new Container(
                width: 270,
                height: 38,
                decoration: new BoxDecoration(
                  color: Color(0xffffcccc),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  shape: BoxShape.rectangle,
                ),
              ),
              new GestureDetector(
                //手指按下时会触发此回调
                onPanDown: (DragDownDetails e){
                  setState(() {
                    xOffset = 0;
                  });
                },
                onPanUpdate: (DragUpdateDetails e){
                  setState(() {
                    if(xOffset + e.delta.dx >= 165){
                      xOffset = 165;
                      return;
                    }
                    xOffset = xOffset + e.delta.dx;
                  });
                },

                onPanEnd: (DragEndDetails e){
                  setState(() {
                    xOffset = 0;
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(msg: "验证成功!",toastLength: Toast.LENGTH_SHORT);
                    if(null != callback){
                      callback();
                    }
                  });

                },

                child: new Transform(
                    transform: new Matrix4.translationValues(xOffset, 0, 0),
                  child: new Container(
                    width: 97,
                    height: 30,
                    margin: EdgeInsets.only(left: 4),
                    decoration: new BoxDecoration(
                      color: Color(0xfff35656),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      shape: BoxShape.rectangle,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "拖动滑块",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),/**/
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}
