import 'dart:math';

import 'package:flutter/material.dart';

class PointerWidget extends StatelessWidget {
  final double? angle;

  const PointerWidget({super.key, this.angle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white)
      ),
      child: Transform.rotate(
        angle: angle != null ? (angle!) + pi/2 : 0,
        child: const Icon(
          Icons.details,
          color: Colors.white,
          size: 31,
        ),
      ),
    );
  }
}