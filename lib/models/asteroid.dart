import 'dart:ui';

import 'package:asteroid_flutter/models/particle.dart';
import 'package:asteroid_flutter/models/shape.dart';
import 'package:flutter/material.dart';

enum AsteroidShape {

  circle,
  rectangle,
  square,
  polygon;

  static Shape getShape(AsteroidShape asteroidShape, {double? radius, double? side, double? width, double? height, List<Offset>? vertices}) {
    Shape shape = Circle(radius: 10);
    switch (asteroidShape) {
      case AsteroidShape.circle:
        if (radius != null) {
          shape = Circle(radius: radius);
        }
      case AsteroidShape.rectangle:
        if (width != null && height != null) {
          shape = Rectangle(width: width, height: height);
        }
      case AsteroidShape.square:
        if (side != null) {
          shape = Square(side: side);
        }
      case AsteroidShape.polygon:
        if (vertices != null && vertices.isNotEmpty) {
          shape = Polygon(vertices: vertices);
        }
    }
    return shape;
  }

}

class Asteroid extends Particle {

  final Shape shape;
  @override
  double? posX;
  @override
  double? posY;
  @override
  double? direction;
  @override
  double? speed;
  @override
  double? acceleration;
  final Color color;
  final int? points;

  Asteroid({
    required this.shape,
    this.color = Colors.white,
    this.posX,
    this.posY,
    this.speed ,
    this.direction,
    this.acceleration,
    this.points = 4,
  }) : super(
          acceleration: acceleration,
          posX: posX,
          posY: posY,
          direction: direction,
          speed: speed,
        );

}