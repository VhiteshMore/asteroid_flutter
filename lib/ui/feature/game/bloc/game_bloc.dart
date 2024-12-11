import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/game.dart';
import 'package:asteroid_flutter/models/particle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../models/player.dart';
import '../../../../models/weapon_projectile.dart';
import '../../../../utils/game_ticker.dart';

class GameBloc extends ChangeNotifier {

  final Player player;
  late final GameTicker _gameTicker;
  List<Asteroid> _asteroids = [];
  final GlobalKey gameScreenKey = GlobalKey();

  bool _gameStarted = false;

  GameBloc({required this.player});

  _startTicker() {
    _gameTicker = GameTicker();
    _gameTicker.run((dt, timeCorrection) {
      // debugPrint('_gameTicker Callback: dt: $dt; timeCorrection: $timeCorrection');
      _update();
    },);
  }

  startGame() {
    _gameStarted = true;
    _startTicker();
    notifyListeners();
  }

  _gameOver() {
    _gameTicker.stop();
    notifyListeners();
  }

  void _update() => notifyListeners();

  List<Asteroid> get asteroids => _asteroids;

  set asteroids(List<Asteroid> asteroids) {
    _asteroids = asteroids;
    notifyListeners();
  }

  //Initialize particles
  void initializeParticles() {

  }

  //Update particle(Asteroid & Projectiles) position based on velocity & direction on gameTicker callback
  void updateParticlePosition() {

  }

  //Check if particles have left the gameScreen viewport in all directions and
  // randomly generate new particles based on the limit of asteroids allowed
  void verifyParticleInGamePort() {

  }

  //Detect collision between players and asteroids based on the detection radius
  // around the player.
  void detectPlayerAsteroidCollision() {

  }

  //Detect collision between Asteroids and Projectiles
  void detectAsteroidProjectileCollision() {

  }

}