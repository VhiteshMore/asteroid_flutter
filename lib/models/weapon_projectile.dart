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

}