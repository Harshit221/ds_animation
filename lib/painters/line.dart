import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BoltLine extends CustomPainter{
  static double _minLength = 10;
  static double _minWidth = 5;
  Offset start;
  Offset end;
  Offset _direction;
  Offset _perp;
  Random _random;
  List<Paint> paints1 = [
    // Paint()..color = Colors.yellow[600].withOpacity(0.8)..strokeWidth = 15.0..maskFilter = MaskFilter.blur(BlurStyle.normal, 20),
    Paint()..color = Colors.yellow[600].withOpacity(0.8)..strokeWidth = 8.0..maskFilter = MaskFilter.blur(BlurStyle.normal, 10),
    Paint()..color = Colors.yellow[600]..strokeWidth = 1.5
  ];
  List<Paint> paints2 = [
    // Paint()..color = Colors.yellow[600].withOpacity(0.8)..strokeWidth = 15.0..maskFilter = MaskFilter.blur(BlurStyle.normal, 20),
    Paint()..color = Colors.orange[600].withOpacity(0.8)..strokeWidth = 8.0..maskFilter = MaskFilter.blur(BlurStyle.normal, 10),
    Paint()..color = Colors.orange[600]..strokeWidth = 1.5
  ];
  BoltLine() {
    _random = Random();
  }

  void paint(Canvas canvas, Size size) {

    start = Offset(size.width/3, size.height/3);
    end = Offset(size.width*2/3, size.height/3);

    _direction = (end-start) / (end-start).distance;
    _perp = perpendicular(_direction);
    Offset p1 = start;
    Offset p2;
    double max = (end - start).distance / _minLength;
    List<Offset> points1 = List();
    List<Offset> points2 = List();
    points1.add(start);
    points2.add(start);
    for(int i=0; i<max;i++) {
      p2 = p1 + _direction * _length1 + _perp * (_length2 * _sign);
      points1.add(p2);
      p2 = p1 + _direction * _length1 + _perp * (_length2 * _sign);
      points2.add(p2);
      p1 += _direction * _minLength;
    }
    points1.add(end);
    points2.add(end);
    paints1.forEach((paint) {
      canvas.drawPoints(PointMode.polygon, points1, paint);
    });
    paints2.forEach((paint) {
      canvas.drawPoints(PointMode.polygon, points2, paint);
    });
  }
  int get _sign => _random.nextBool() ? 1 : -1;
  double get _length1 => _random.nextDouble() * _minLength;
  double get _length2 => _random.nextDouble() * _minWidth;
  Offset perpendicular(Offset o) => Offset(o.dy, -o.dx);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}