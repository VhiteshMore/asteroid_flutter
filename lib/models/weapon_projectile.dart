import 'package:asteroid_flutter/models/particle.dart';
import 'package:asteroid_flutter/models/shape.dart';

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
  @override
  Shape? shape;

  WeaponProjectile({
    required this.posX,
    required this.posY,
    this.direction = 0,
    this.speed = 0,
    this.shape,
  }) : super(
            acceleration: 0,
            posX: posX,
            posY: posY,
            direction: direction,
            speed: speed,
            shape: shape,
  );

}