import 'package:flutter/cupertino.dart';

import '../../../../models/asteroid.dart';
import '../../../../models/weapon_projectile.dart';

class GameState extends ChangeNotifier {

  List<Asteroid> _asteroids = [];
  List<WeaponProjectile> _projectiles = [];

  bool _gameStarted = false;

  startGame() {
    _gameStarted = true;
    notifyListeners();
  }

  List<Asteroid> get asteroids => _asteroids;

  set asteroids(List<Asteroid> asteroids) {
    _asteroids = asteroids;
    notifyListeners();
  }

  List<WeaponProjectile> get projectiles => _projectiles;

  set projectiles(List<WeaponProjectile> projectiles) {
    _projectiles = projectiles;
    notifyListeners();
  }

}