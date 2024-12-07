import 'dart:math' as math;

import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/particle.dart';
import 'package:flutter/material.dart';

class GameUtils {

  static final math.Random _rng = math.Random();

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
    double pseudoRng = _rng.nextDouble();
    double pseudoOffset = pseudoRng * initialFrameOffsetLimit;

    double leftPeripheralX = -pseudoOffset;
    double topPeripheralY = -pseudoOffset;
    double rightPeripheralX = pseudoOffset + width;
    double bottomPeripheralY = pseudoOffset + height;

    //Generate Peripheral LTRB (x,y) for the game board with +-{initialFrameOffsetLimit}
    double innerLeftX =  pseudoOffset;
    double innerRightX = rightPeripheralX - pseudoOffset;
    double innerTopY =  pseudoOffset;
    double innerBottomY = bottomPeripheralY - pseudoOffset;

    double rngSign = randomSign();
    double peripheralLeftX = (leftPeripheralX + (pseudoRng * (innerLeftX - leftPeripheralX.abs())));
    double peripheralTopY = (topPeripheralY + pseudoRng * (innerTopY - topPeripheralY.abs()));
    double peripheralRightX = (innerRightX + pseudoRng * (rightPeripheralX - innerRightX));
    double peripheralBottomY = (innerBottomY + pseudoRng * (bottomPeripheralY - innerBottomY));

    double minMaxYAxis = (topPeripheralY + _rng.nextDouble() * (bottomPeripheralY - topPeripheralY));
    double minMaxXAxis = (leftPeripheralX + _rng.nextDouble() * (rightPeripheralX - leftPeripheralX));

    if (rngSign > 0) {
      generatedOffset = Offset(randomSign() < 0 ? peripheralLeftX : peripheralRightX, (topPeripheralY + _rng.nextDouble() * (bottomPeripheralY - topPeripheralY.abs())));
    } else {
      generatedOffset = Offset((leftPeripheralX + _rng.nextDouble() * (rightPeripheralX - leftPeripheralX.abs())), randomSign() < 0 ? peripheralTopY : peripheralBottomY);
    }
    // generatedOffset = Offset(minMaxXAxis, minMaxYAxis);
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