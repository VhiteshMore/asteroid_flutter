import 'package:asteroid_flutter/models/particle.dart';

class WeaponProjectile extends Particle {

  @override
  double? posX;
  @override
  double? posY;
  //Convert to radian or degrees wrt to reference (0,0) and +,- signs
  @override
  double? direction;
  @override
  double? speed;

  WeaponProjectile({
    required this.posX,
    required this.posY,
    this.direction = 0,
    this.speed = 0,
  }) : super(
            acceleration: 0,
            posX: posX,
            posY: posY,
            direction: direction,
            speed: speed);

  //change or update direction
  @override
  void updateDirection({required double direction}) {
    // TODO: implement updateDirection
  }

  //move or update
  @override
  void updatePosition({required double dx, required double dy}) {
    // TODO: implement updatePosition
  }

}