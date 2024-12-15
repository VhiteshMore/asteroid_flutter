import 'dart:math';

import 'package:flutter/material.dart';

class PointerWidget extends StatelessWidget {
  final double? angle;

  const PointerWidget({super.key, this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationZ(angle != null ? (angle!) : 0),
      child: Transform.rotate(
        angle: pi / 2,
        child: const Icon(
          Icons.details,
          color: Colors.white,
          size: 31,
        ),
      ),
    );
  }
}