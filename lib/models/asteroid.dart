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

class Asteroid implements Particle{

  final AsteroidShape shape;
  @override
  final double posX;
  @override
  final double posY;
  //Convert to radian or degrees wrt to reference (0,0) and +,- signs
  @override
  final double direction;
  @override
  final double speed;

  Asteroid({
    required this.shape,
    required this.posX,
    required this.posY,
    required this.direction,
    required this.speed,
  });

  //move or update
  @override
  void updatePosition() {}

  @override
  double? acceleration;

  @override
  set direction(double? _direction) {
    // TODO: implement direction
  }

  @override
  set posX(double? _posX) {
    // TODO: implement posX
  }

  @override
  set posY(double? _posY) {
    // TODO: implement posY
  }

  @override
  set speed(double? _speed) {
    // TODO: implement speed
  }

  @override
  void updateDirection() {
    // TODO: implement updateDirection
  }

}