import 'dart:ui';

abstract class Particle {

  double? posX;
  Offset? offset;
  double? posY;
  //Convert to radian or degrees wrt to reference (0,0) and +,- signs
  double? direction;
  double? speed;
  double? acceleration;

  Particle({this.offset, this.posX, this.posY, this.direction, this.acceleration, this.speed});

  void updatePosition({required double dx, required double dy});

  void updateDirection({required double direction});

}

mixin ParticleMixin on Particle {

}