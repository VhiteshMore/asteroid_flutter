import 'package:asteroid_flutter/models/particle.dart';

enum AsteroidShape {

  circle(height: 20, width: 20),
  rectangle(height: 20, width: 20),
  square(height: 20, width: 20),
  polygon(height: 20, width: 20, points: 4);

  final double height;
  final double width;
  final int? points;

  const AsteroidShape({required this.height, required this.width, this.points});

}

class Asteroid extends Particle {

  final AsteroidShape shape;
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

  Asteroid({
    required this.shape,
    this.posX,
    this.posY,
    this.speed ,
    this.direction,
    this.acceleration,
  }) : super(
          acceleration: acceleration,
          posX: posX,
          posY: posY,
          direction: direction,
          speed: speed,
        );

  @override
  void updateDirection({required double direction}) {
    // TODO: implement updateDirection
  }

  @override
  void updatePosition({required double dx, required double dy}) {
    // TODO: implement updatePosition
  }



}