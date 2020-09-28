import 'dart:math';
import 'dart:ui';

import 'package:ds_amimation/painters/line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Circle1 extends CustomPainter {
  Paint myPaint = Paint();
  double value;
  Circle1();

  @override
  void paint(Canvas canvas, Size size) {
    BoltLine().paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
