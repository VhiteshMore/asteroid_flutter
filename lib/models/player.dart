import 'package:asteroid_flutter/models/particle.dart';
import 'package:asteroid_flutter/models/weapon_projectile.dart';

class Player extends Particle {

  final double height;
  final double width;

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
  double? acceleration;

  double score;

  List<WeaponProjectile> projectiles;

  Player({
    required this.height,
    required this.width,
    this.posX = 0,
    this.posY = 0,
    this.speed = 0,
    this.direction = 0,
    this.acceleration = 0,
    this.score = 0,
    List<WeaponProjectile>? projectiles,
  })  : projectiles = projectiles ?? [],
        super(
          acceleration: 0,
          posX: posX,
          posY: posY,
          direction: direction,
          speed: speed,
        );

  //change or update direction
  // @override
  // void updateDirection({required double direction}) {
  //   // TODO: implement updateDirection
  // }

  //move or update
  // @override
  // void updatePosition({required double dx, required double dy}) {
  //   // TODO: implement updatePosition
  // }

}