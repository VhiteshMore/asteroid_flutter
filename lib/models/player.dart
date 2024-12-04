import 'package:asteroid_flutter/models/particle.dart';
import 'package:asteroid_flutter/models/weapon_projectile.dart';

class Player implements Particle {

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

  List<WeaponProjectile> projectiles;

  Player({
    required this.height,
    required this.width,
    this.posX = 0,
    this.posY = 0,
    this.direction = 0,
    this.speed = 0,
    this.acceleration = 0,
    this.score = 0,
    List<WeaponProjectile>? projectiles,
  }) : projectiles = projectiles ?? [];

  //move or update
  @override
  void updatePosition() {}

  //change or update direction
  @override
  void updateDirection() {}

  @override
  set acceleration(double? _acceleration) {
    acceleration = _acceleration;
  }

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

  set score(double? _score) {
    score = _score;
  }

}