import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/table/AttendanceTable.dart';
import 'dart:math';

class TestCustomView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    EdgeInsets padding = MediaQuery.of(context).padding;
    double top = max(padding.top , EdgeInsets.zero.top);

    return Container(
      margin: EdgeInsets.only(top: 2*top,bottom: 2*top),
      child: AttendanceTable(
        width: MediaQuery.of(context).size.width,
        height: 300,
        horizontalTitle: const["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
        verticalTitle: const["上午","下午"],
        headerTitle: const["星期","时间"],
        backgroundColor: Colors.blue,
      ),
    );
  }
}