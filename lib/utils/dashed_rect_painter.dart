import 'package:flutter/material.dart';
import 'dart:math';

class DashedRectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;

  DashedRectPainter({this.strokeWidth = 2.0, this.color = Colors.grey, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(a: const Point(0, 0), b: Point(x, 0), gap: gap);
    Path _rightPath = getDashedPath(a: Point(x, 0), b: Point(x, y), gap: gap);
    Path _bottomPath = getDashedPath(a: Point(0, y), b: Point(x, y), gap: gap);
    Path _leftPath = getDashedPath(a: const Point(0, 0), b: Point(0, y), gap: gap);

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({required Point<double> a, required Point<double> b, required double gap}) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    Point<double> currentPoint = Point(a.x, a.y);
    num radians = atan(size.height / size.width);
    num dx = cos(radians) * gap < 0 ? cos(radians) * gap * -1 : cos(radians) * gap;
    num dy = sin(radians) * gap < 0 ? sin(radians) * gap * -1 : sin(radians) * gap;
    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw ? path.lineTo(currentPoint.x, currentPoint.y) : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = Point(currentPoint.x + dx, currentPoint.y + dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}