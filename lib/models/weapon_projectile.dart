import 'package:asteroid_flutter/models/particle.dart';

class WeaponProjectile extends Particle {

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
  double? acceleration;

  WeaponProjectile({
    required this.posX,
    required this.posY,
    required this.direction,
    required this.speed,
  });

  //move or update
  @override
  void updatePosition() {}

  @override
  set direction(double? _direction) {
    direction = _direction;
  }

  @override
  set posX(double? _posX) {
    posX = _posX;
  }

  @override
  set posY(double? _posY) {
    posY = _posY;
  }

  @override
  set speed(double? _speed) {
    speed = _speed;
  }

  @override
  void updateDirection() {
    // TODO: implement updateDirection
  }

}