import 'package:asteroid_flutter/models/particle.dart';

class Player implements Particle{

  final double height;
  final double width;
  @override
  final double posX;
  @override
  final double posY;
  //Convert to radian or degrees wrt to reference (0,0) and +,- signs
  @override
  final double direction;
  @override
  final double speed;
  @override
  final double acceleration;
  final double score;

  Player({
    required this.height,
    required this.width,
    required this.posX,
    required this.posY,
    required this.direction,
    required this.speed,
    required this.acceleration,
    required this.score,
  });

  //move or update
  @override
  void updatePosition() {}

  //change or update direction
  @override
  void updateDirection() {}

  @override
  set acceleration(double? _acceleration) {
    // TODO: implement acceleration
  }

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

}