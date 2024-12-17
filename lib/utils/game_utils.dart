import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:asteroid_flutter/index.dart';

class GameUtils {

  static final math.Random _rng = math.Random();

  //Generate Asteroids based on mi
  static List<Asteroid> generateAsteroids(
      {required double height,
      required double width,
      required Offset center,
      double? speed,
      int maxLimit = 10,
      AsteroidShape shape = AsteroidShape.circle,
      double? initialFrameOffsetLimit,}) {
    final rng = _rng;
    List<Asteroid> particles = [];
    for (int i = 0; i < maxLimit; i++) {
      final astOffset = generatePeripheralOffset(height: height, width: width, initialFrameOffsetLimit: initialFrameOffsetLimit ?? 40);
      particles.add(Asteroid(
        color: Colors.primaries[rng.nextInt(Colors.primaries.length)],
        ///Todo: Add Support for Custom Shapes
        shape: Circle(radius: (15 + (_rng.nextDouble() * 25))),
        speed: speed ?? 10,
        posX: astOffset.dx,
        posY: astOffset.dy,
        direction: getDirection(center: center, pOfst: astOffset),
        acceleration: 0,
      ));
    }
    return particles;
  }

  static Offset generatePeripheralOffset({required double height, required double width, double initialFrameOffsetLimit = 10 }) {
    Offset generatedOffset = Offset.zero;
    double pseudoRng = _rng.nextDouble();
    double pseudoOffset = pseudoRng * initialFrameOffsetLimit;

    //Generate peripheral maximum limit from all sides LTRB
    double leftPeripheralX = -pseudoOffset;
    double topPeripheralY = -pseudoOffset;
    double rightPeripheralX = pseudoOffset + width;
    double bottomPeripheralY = pseudoOffset + height;

    //Generate Peripheral minimum limit from all sides LTRB
    double innerLeftX =  pseudoOffset;
    double innerRightX = rightPeripheralX - pseudoOffset;
    double innerTopY =  pseudoOffset;
    double innerBottomY = bottomPeripheralY - pseudoOffset;

    double rngSign = randomSign();
    double leftRangeX = (leftPeripheralX + (pseudoRng * (innerLeftX - leftPeripheralX.abs())));
    double topRangeY = (topPeripheralY + pseudoRng * (innerTopY - topPeripheralY.abs()));
    double rightRangeX = (innerRightX + pseudoRng * (rightPeripheralX - innerRightX));
    double bottomRangeY = (innerBottomY + pseudoRng * (bottomPeripheralY - innerBottomY));

    if (rngSign > 0) {
      generatedOffset = Offset(randomSign() < 0 ? leftRangeX : rightRangeX, (topPeripheralY + _rng.nextDouble() * (bottomPeripheralY - topPeripheralY.abs())));
    } else {
      generatedOffset = Offset((leftPeripheralX + _rng.nextDouble() * (rightPeripheralX - leftPeripheralX.abs())), randomSign() < 0 ? topRangeY : bottomRangeY);
    }
    return generatedOffset;
  }

  //Get Random Direction with +-(45 degree)tolerance with respect to the line from offset point to center of game screen
  static double getDirection({required Offset center, required Offset pOfst,double toleranceAngle = 0.523599}) {
    double direction = 0;
    double calculatedDirection = math.atan2(center.dy - pOfst.dy, center.dx - pOfst.dx);
    double minToleranceAngle = calculatedDirection - toleranceAngle;
    double maxToleranceAngle = toleranceAngle + calculatedDirection;
    direction = minToleranceAngle + (_rng.nextDouble() * (maxToleranceAngle.abs() - minToleranceAngle.abs()));
    return direction;
  }

  static double randomSign() {
    return _rng.nextBool() ? 1 : -1;
  }

  //Check instersection between two objects
  static bool intersects(Particle object1, Particle object2) {
    bool obj2RGrObj1L = object1.shape!.left(Offset(object1.posX!, object1.posY!)) < object2.shape!.right(Offset(object2.posX!, object2.posY!));
    bool obj1RGrObj2L = object1.shape!.right(Offset(object1.posX!, object1.posY!)) > object2.shape!.left(Offset(object2.posX!, object2.posY!));
    bool obj2BGrObj1T = object1.shape!.top(Offset(object1.posX!, object1.posY!)) < object2.shape!.bottom(Offset(object2.posX!, object2.posY!));
    bool obj1BGrObj2T = object1.shape!.bottom(Offset(object1.posX!, object1.posY!)) > object2.shape!.top(Offset(object2.posX!, object2.posY!));
    return obj2RGrObj1L && obj1RGrObj2L && obj2BGrObj1T && obj1BGrObj2T;
  }

}