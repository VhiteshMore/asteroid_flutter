import 'dart:ui';

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {

  final Offset p1;
  final Offset p2;
  final Color? color;

  LinePainter({
    required this.p1,
    required this.p2,
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(p1, p2, paint);
    // canvas.drawCircle(p2, 5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}