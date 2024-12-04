import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/player.dart';
import 'package:asteroid_flutter/models/weapon_projectile.dart';

class Game {

  List<Asteroid> asteroids = [];
  List<WeaponProjectile> projectiles = [];
  final Player player;

  Game({
    required this.player,
    List<Asteroid>? asteroids,
    List<WeaponProjectile>? projectiles,
  }) : asteroids = asteroids ?? [],
      projectiles = projectiles ?? []
  ;

}