import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageUtils{
  ImageUtils() :super();

  static double getWidth() {
    return  ui.window.physicalSize.width;
  }
  static double getRatio () {
    return ui.window.devicePixelRatio;
  }
  static double getHeight() {

    return  ui.window.physicalSize.height;
  }

  static Future<ui.Image> getImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    Uint8List lst = new Uint8List.view(data.buffer);
    Codec codec = await ui.instantiateImageCodec(lst);
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  static Future<ui.Image> loadImageByFile(
      String path) async {
    var list = await File(path).readAsBytes();
    return loadImageByUint8List(list);
  }

  static Future<ui.Image> loadImageByUint8List(
      Uint8List list, {
        int width,
        int height,
      }) async {
    ui.Codec codec = await ui.instantiateImageCodec(list,);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }
}

class CanvasOffset extends Offset {
  const CanvasOffset(double width, double height) : super(width, height) ;
}