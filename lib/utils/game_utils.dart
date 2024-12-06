import 'dart:math' as math;

import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/particle.dart';
import 'package:flutter/material.dart';

class GameUtils {

  static List<Particle> generateAsteroids({required double height, required double width, int minLimit = 10, int maxLimit = 10, AsteroidShape shape = AsteroidShape.circle,}) {
    final rng = math.Random();
    List<Particle> particles = [];
    for (int i = 0; i < maxLimit; i++) {
      final asft = generatePeripheralOffset(height: height, width: width, initialFrameOffsetLimit: 10);
      particles.add(Asteroid(
        color: Colors.primaries[rng.nextInt(Colors.primaries.length)],
        shape: shape,
        speed: 10,
        posX: asft.dx,
        posY: asft.dy,
        direction: asft.direction,
        acceleration: 0,
      ));
    }
    return particles;
  }

  static Offset generatePeripheralOffset({required double height, required double width, int initialFrameOffsetLimit = 10 }) {
    final _rng = math.Random();
    Offset generatedOffset = Offset.zero;
    double leftPeripheralX = -(_rng.nextDouble() * initialFrameOffsetLimit);
    double topPeripheralY = -(_rng.nextDouble() * initialFrameOffsetLimit);
    double rightPeripheralX = (_rng.nextDouble() * initialFrameOffsetLimit) + width;
    double bottomPeripheralY = (_rng.nextDouble() * initialFrameOffsetLimit) + height;
    //Generate Peripheral LTRB (x,y) for the game board with +-{initialFrameOffsetLimit}
    double innerLeftX = leftPeripheralX + (_rng.nextDouble() * initialFrameOffsetLimit);
    double innerRightX = rightPeripheralX - ((_rng.nextDouble() * initialFrameOffsetLimit));
    double innerTopY = topPeripheralY + (_rng.nextDouble() * initialFrameOffsetLimit);
    double innerBottomY = bottomPeripheralY - ((_rng.nextDouble() * initialFrameOffsetLimit));
    double rngSign = randomSign();
    double peripheralLeftX = (leftPeripheralX + _rng.nextDouble() * (innerLeftX - leftPeripheralX));
    double peripheralTopY = (topPeripheralY + _rng.nextDouble() * (innerTopY - topPeripheralY));
    double peripheralRightX = (innerRightX + _rng.nextDouble() * (rightPeripheralX - innerRightX));
    double peripheralBottomY = (innerBottomY + _rng.nextDouble() * (bottomPeripheralY - innerBottomY));

    if (rngSign > 0) {
      generatedOffset = Offset(randomSign() < 0 ? peripheralLeftX : peripheralRightX, (topPeripheralY + _rng.nextDouble() * (bottomPeripheralY - topPeripheralY)));
    } else {
      generatedOffset = Offset((leftPeripheralX + _rng.nextDouble() * (rightPeripheralX - leftPeripheralX)), randomSign() < 0 ? peripheralTopY : peripheralBottomY);
    }
    return generatedOffset;
  }

  static getDirection() {
    double direction = 0;
    return direction;
  }

  static double randomSign() {
    var rng = math.Random();
    return rng.nextBool() ? 1 : -1;
  }

}