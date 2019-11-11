import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/utils/ImageUtils.dart';

class AttendanceTable extends StatefulWidget {
  AttendanceTable({
    this.data,
    Key key,
    this.width,
    this.height,
    this.frameLine: 0x1111,
    this.frameLineColor: const Color(0xffe2e7f1),
    this.tableContentColor: Colors.black,
    this.backgroundColor = Colors.white,
    this.horizontalTitle,
    this.verticalTitle,
    this.headerTitle,
    this.contentLine = 0x11,
    this.frameLineWidth = 2,
  }) : super(key: key);

  final double width;
  final double height;

  final String data;

  //从右至左，分别表示有无left，top，right，bottom边框线（0 - 无，1 - 有）
  final int frameLine;
  final Color frameLineColor;
  final Color tableContentColor;
  final Color backgroundColor;
  final double frameLineWidth;

  //从右至左，分别表示有无横向分割线，垂直分割线
  final int contentLine;
  final List<String> horizontalTitle;
  final List<String> verticalTitle;

  /// 第一个单元格title
  final List<String> headerTitle;
  BuildContext context;

  ui.Image image;

  List<int> contentData = List();

  @override
  State<StatefulWidget> createState() {
    ImageUtils.getImage("assets/images/hook.png").then((it) {
      image = it;
    });
    contentData.add(7);
    contentData.add(6);
    contentData.add(5);
    contentData.add(4);
    contentData.add(3);
    contentData.add(2);
    contentData.add(1);
    return AttendanceTableState(width,height,this);
  }
}

class AttendanceTableState extends State<AttendanceTable>{

  AttendanceTableState(
      this.width,
      this.height,
      this.table

  );

  final double width;
  final double height;
  final AttendanceTable table;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (DragDownDetails e) {
        setState(() {
          table.contentData[0] = 1;
          table.contentData[1] = 2;
          table.contentData[2] = 2;
          table.contentData[3] = 2;
          table.contentData[4] = 2;
          table.contentData[5] = 2;
        });
      },
      child: CustomPaint(
        size: Size(width, height),
        painter: _AttendanceTablePaint(table, width, height),
      ),
    );
  }

}

class _AttendanceTablePaint extends CustomPainter {
  _AttendanceTablePaint(this.table, this.width, this.height) {
    if (null == table) {
      return;
    }
    frameLinePaint.color = table.frameLineColor;
    frameLinePaint.strokeWidth = table.frameLineWidth;
    frameLinePaint.style = PaintingStyle.stroke;
    tableHeadTextHeight = getTableHeadTextHeight(table.headerTitle);
    if (null == table.horizontalTitle && null == table.headerTitle) {
      isPlaceholderOneCell = false;
    } else {
      isPlaceholderOneCell =
          table.horizontalTitle.length > 0 && table.verticalTitle.length > 0;
    }

    int vL = null == table.verticalTitle ? 0 : table.verticalTitle.length;
    int hL = null == table.horizontalTitle ? 0 : table.horizontalTitle.length;

    int t = isPlaceholderOneCell ? 1 : 0;

    row = vL + t;
    column = hL + t;
    back.color = table.backgroundColor;
  }

  AttendanceTable table;
  num width;
  num height;
  num cellHeight;
  num cellWidth;
  num tableHeadTextHeight;
  var isPlaceholderOneCell;

  Path horizontalFrameLinePath = Path();
  Path verticalFrameLinePath = Path();
  Paint frameLinePaint = Paint();
  Paint back = Paint();
  Paint imagePaint = Paint()..isAntiAlias = true;

  TextPainter tableHeadPaint = TextPainter();
  TextPainter tableContentPaint = TextPainter();

  final MODE_ENCODER_DATA = 2;
  final List<int> ENCODER = const [4, 2, 1];

  /// 表格行数
  var row;

  /// 表格列数
  var column;

  double getTableHeadTextHeight(List<String> titles) {
    if (null == titles || titles.length < 2) {
      return 0;
    }
    return 5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0.0, 0.0, width, height);
    canvas.clipRect(rect);
    canvas.drawRect(rect, back);
    if (isDrawTable()) {
      return;
    }

    cellWidth = width / column;
    cellHeight = height / row;

    //绘制边线
    drawFrameLine(canvas);
    //绘制单元格类容
    drawTableContent(canvas);
  }

  bool isDrawTable() {
    return (null == table || (row <= 0 && column <= 0));
  }

  void drawFrameLine(Canvas canvas) {
    drawHorizontalFrameLine(canvas);
    drawVerticalFrameLine(canvas);
  }

  void drawHorizontalFrameLine(Canvas canvas) {
    ///记录水平横线路径
    if ((0x0010 & table.frameLine) != 0) {
      horizontalFrameLinePath.moveTo(0, 0);
      horizontalFrameLinePath.lineTo(width, 0);
    }

    if ((table.contentLine & 0x01) != 0) {
      for (int i = 1; i < row; i++) {
        double y = cellHeight * i;
        horizontalFrameLinePath.moveTo(0, y);
        horizontalFrameLinePath.lineTo(width, y);
      }
    }
    if ((0x1000 & table.frameLine) != 0) {
      horizontalFrameLinePath.moveTo(0, height);
      horizontalFrameLinePath.lineTo(width, height);
    }
    canvas.drawPath(horizontalFrameLinePath, frameLinePaint);
  }

  void drawVerticalFrameLine(Canvas canvas) {
    //记录垂直横线路径
    if ((0x0001 & table.frameLine) != 0) {
      verticalFrameLinePath.moveTo(0, 0);
      verticalFrameLinePath.lineTo(0, height);
    }

    if ((table.contentLine & 0x10) != 0) {
      for (int i = 1; i < column; i++) {
        double x = cellWidth * i;
        verticalFrameLinePath.moveTo(x, 0);
        verticalFrameLinePath.lineTo(x, height);
      }
    }

    if ((0x0100 & table.frameLine) != 0) {
      verticalFrameLinePath.moveTo(width, 0);
      verticalFrameLinePath.lineTo(width, height);
    }
    canvas.drawPath(verticalFrameLinePath, frameLinePaint);
  }

  void drawTableContent(Canvas canvas) {
    drawTableHeader(canvas);
    drawContentData(canvas);
  }

  void drawTableHeader(Canvas canvas) {
    if (null == table.headerTitle || table.headerTitle.length < 2) {
      return;
    }
    //绘制第一个单元格分类
    canvas.drawLine(Offset.zero, Offset(cellWidth, cellHeight), frameLinePaint);

    String topTitle = table.headerTitle[0];
    String leftTitle = table.headerTitle[1];

    double l = -cellWidth / 3;
    double t = cellHeight / 4;

    drawText(canvas, topTitle, Offset(l, t));
    drawText(canvas, leftTitle, Offset(-2 * cellWidth / 3, 3 * cellHeight / 4));
  }

  void drawContentData(Canvas canvas) {
    drawTableTitleText(canvas);
    drawContentText(canvas);
  }

  void drawTableTitleText(Canvas canvas) {
    int startIndex = isPlaceholderOneCell ? 1 : 0;

    if (null != table.horizontalTitle) {
      for (int h = startIndex;
          (h - startIndex) < table.horizontalTitle.length;
          h++) {
        drawCell(canvas, h, table.horizontalTitle[h - startIndex]);
      }
    }

    if (null != table.verticalTitle) {
      for (int v = startIndex;
          (v - startIndex) < table.verticalTitle.length;
          v++) {
        drawCell(canvas, v * column, table.verticalTitle[v - startIndex]);
      }
    }
  }

  void drawContentText(Canvas canvas) {
    int startRowIndex = isPlaceholderOneCell ? 1 : 0;
    int startColumnIndex = isPlaceholderOneCell ? 1 : 0;

    int startIndex = startRowIndex * column + row - 1;
    startIndex = startIndex < 0 ? 0 : startIndex;

    int n = row * column;

    for (int i = startIndex; i < n; i++) {
      int hIndex = i % row;
      int vIndex = i ~/ row;

      if (startRowIndex - 1 >= hIndex) {
        continue;
      }

      if (hIndex >= row || vIndex >= column) {
        return;
      }

      int encoderStart = hIndex - startColumnIndex;
      encoderStart = encoderStart < 0 ? 0 : encoderStart;

      if (encoderStart >= ENCODER.length) {
        return;
      }
      int encoder = ENCODER[encoderStart];

      int vIndexStart = vIndex - startRowIndex;
      vIndexStart = vIndexStart < 0 ? 0 : vIndexStart;
      if (vIndexStart >= table.contentData.length) {
        return;
      }
      if ((encoder & table.contentData[vIndexStart]) != 0) {
        drawCellBitmap(canvas, i);
      }
    }
  }

  drawCellBitmap(Canvas canvas, int position) {
    double w = table.image.width.toDouble();
    double h = table.image.height.toDouble();

    num l = getCellX(position) + (cellWidth - w) / 2;
    num t = getCellY(position) + (cellHeight - h) / 2;

    print("---$table.image--l=$l,t=$t");

    canvas.drawImage(table.image, Offset(l, t), imagePaint);
  }

  void drawCell(Canvas canvas, int position, String horizontalTitle) {
    if (horizontalTitle.isEmpty) {
      return;
    }
    double l = getCellX(position);
    double t = getCellY(position);

    double x = l;
    double y = t + cellHeight / 2;
    drawText(canvas, horizontalTitle, Offset(x, y),
        maxWith: cellWidth, fontSize: 12);
  }

  num getCellX(int position) {
    num hIndex = position % column;
    return hIndex * cellWidth;
  }

  num getCellY(int position) {
    num vIndex = position ~/ column;
    return vIndex * cellHeight;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  drawText(Canvas canvas, String text, Offset offset,
      {Color color = Colors.white,
      double maxWith = 100,
      double fontSize,
      String fontFamily,
      TextAlign textAlign = TextAlign.center,
      FontWeight fontWeight = FontWeight.bold}) {
    //  绘制文字
    var paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: fontFamily,
        textAlign: textAlign,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
    paragraphBuilder.pushStyle(
        ui.TextStyle(color: color, textBaseline: ui.TextBaseline.alphabetic));
    paragraphBuilder.addText(text);
    var paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: maxWith));
    double h = paragraph.height / 2;

    canvas.drawParagraph(paragraph, Offset(offset.dx, offset.dy - h));
  }
}
