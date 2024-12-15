import 'dart:math' as math;

import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/particle.dart';
import 'package:flutter/material.dart';

import '../models/shape.dart';

class GameUtils {

  static final math.Random _rng = math.Random();

  static List<Asteroid> generateAsteroids(
      {required double height,
      required double width,
      required Offset center,
      double? speed,
      int minLimit = 10,
      int maxLimit = 10,
      AsteroidShape shape = AsteroidShape.circle,
      double? initialFrameOffsetLimit}) {
    final rng = _rng;
    List<Asteroid> particles = [];
    for (int i = 0; i < maxLimit; i++) {
      final asft = generatePeripheralOffset(height: height, width: width, initialFrameOffsetLimit: initialFrameOffsetLimit ?? 40);
      particles.add(Asteroid(
        color: Colors.primaries[rng.nextInt(Colors.primaries.length)],
        ///Todo: Custom Shapes
        shape: Circle(radius: 50),
        speed: speed ?? 10,
        posX: asft.dx,
        posY: asft.dy,
        direction: getDirection(center: center, pOfst: asft),
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

  static double getPointerDirection({required Offset p1, required Offset p2}) {
    double rotation = 0;
    double angleInRadians = 0;
    if (p2.dx < p1.dx) {
      if (p2.dy < p1.dy) {
        if (p2.dx - p1.dx < 0 && p2.dx - p1.dx >= -20.5) {
          angleInRadians = -math.atan2(p1.dx - p2.dx, p1.dy - p2.dy);
        } else {
          angleInRadians = -math.atan2(p1.dy - p2.dy, p1.dx - p2.dx);
        }
      } else {
        // if () {
        //
        // }
        angleInRadians = -math.atan2(p1.dx - p2.dx, p1.dy - p2.dy);
      }
    } else {
      if (p2.dy < p1.dy) {
        if (p2.dx - p1.dx <= 20.5 && p2.dx - p1.dx >= 0) {
          angleInRadians = -math.atan2(p1.dx - p2.dx, p1.dy - p2.dy);
        } else {
          angleInRadians = -math.atan2(p2.dy - p1.dy, p2.dx - p1.dx);
        }
      } else {
        if (p2.dy - p1.dy <= 20.5 && p2.dy - p1.dy >= -20.5) {
          angleInRadians = -math.atan2(p1.dx - p2.dx, p1.dy - p2.dy);
        } else {
          angleInRadians = -math.atan2(p1.dx - p2.dx, p1.dy - p2.dy);
        }
      }
    }
    rotation = (angleInRadians + (2 * math.pi)) % (2 * math.pi);
    return rotation;
  }

  static double randomSign() {
    return _rng.nextBool() ? 1 : -1;
  }

  static bool intersects(Particle object1, Particle object2) {
    return object1.shape!.left(Offset(object1.posX!, object1.posY!)) < object2.shape!.right(Offset(object2.posX!, object2.posY!))
        && object1.shape!.right(Offset(object1.posX!, object1.posY!)) > object2.shape!.left(Offset(object2.posX!, object2.posY!))
        && object1.shape!.top(Offset(object1.posX!, object1.posY!)) < object2.shape!.bottom(Offset(object2.posX!, object2.posY!))
        && object1.shape!.bottom(Offset(object1.posX!, object1.posY!)) > object2.shape!.top(Offset(object2.posX!, object2.posY!));
  }

}