import 'package:flutter/material.dart';

class GraphVerifyDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CodeDialog();
}

class CodeDialog extends State<GraphVerifyDialog> {

  double xOffset;

  CodeDialog({this.xOffset: 0});
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              new Container(
                width: double.infinity,
                height: 175,
                color: Color(0xffa2000d),
              ),
              new Container(
                width: 65,
                height: 65,
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: new BoxDecoration(
                  color: Color(0xffffffff),
                  shape: BoxShape.rectangle,
                ),
              )
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
                onHorizontalDragStart: (DragStartDetails details){

                },
                onHorizontalDragUpdate: (DragUpdateDetails details){
                  xOffset = xOffset + details.delta.dx;
                  setState(() {});
                },
                onHorizontalDragCancel: (){

                },
                onHorizontalDragEnd: (DragEndDetails details){

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
