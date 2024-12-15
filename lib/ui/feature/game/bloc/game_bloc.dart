import 'dart:math' as math;

import 'package:asteroid_flutter/models/index.dart';
import 'package:asteroid_flutter/utils/index.dart';
import 'package:flutter/material.dart';

import '../../../../utils/player_trajectory.dart';

class GameBloc extends ChangeNotifier {

  final Player _player;
  late final GameTicker _gameTicker;
  List<Asteroid> _asteroids = [];
  final GlobalKey gameScreenKey = GlobalKey();
  double _initialFrameOffsetLimit = 0;
  int _minAsteroidCount = 10;
  final PlayerTrajectory _playerTrajectory = PlayerTrajectory();

  bool _gameStarted = false;

  GameBloc({
    required Player player,
  }) : _player = player;

  double playerPosX() => _player.posX!;
  double playerPosY() => _player.posY!;

  List<Asteroid> get asteroids => _asteroids;

  List<WeaponProjectile> get weaponProjectiles => _player.projectiles;

  double get pointerAngle {
    double angle = _playerTrajectory.playerDirection;
    _player.direction = angle;
    return angle;
  }

  //Start Game
  startGame() {
    assert(gameScreenKey.currentContext != null, 'Please attach the gameScreenKey to your GameWidget where asteroids and projectiles will be displayed');
    RenderBox gameBox = gameScreenKey.currentContext!.findRenderObject() as RenderBox;
    _gameStarted = true;
    _startTicker(gameBox);
    _initializeParticles(asteroidCount: _minAsteroidCount, gameBox: gameBox);
    _update();
  }

  //Pause the game
  pause() {
    _gameTicker.pause();
  }

  //Resume the game
  resume() {
    _gameTicker.resume();
  }

  //End the game
  _gameOver() {
    _gameTicker.stop();
    _update();
  }

  _startTicker(RenderBox gameBox) {
    _gameTicker = GameTicker();
    _gameTicker.run(
          (deltaTime, timeCorrection) {
        // debugPrint('_gameTicker Callback: dt: $dt; timeCorrection: $timeCorrection');
        _updateParticlePosition(deltaTime);
        _verifyParticleInGamePort(gameBox);
        _detectPlayerAsteroidCollision();
        _detectAsteroidProjectileCollision();
        _update();
      },
    );
  }

  //Initialize particles
  void _initializeParticles({int? asteroidCount, RenderBox? gameBox}) {
    final Size screenSize = gameBox!.size;
    // debugPrint("screenSize(${screenSize.width}, ${screenSize.height})");
    Offset center = Offset(
        // gameBox.localToGlobal(Offset.zero).dx -
            gameBox.size.width / 2,
        // gameBox.localToGlobal(Offset.zero).dy -
            gameBox.size.height / 2);
    debugPrint("center: $center");
    _asteroids.addAll(GameUtils.generateAsteroids(
        height: screenSize.height,
        width: screenSize.width,
        center: center,
        speed: 100,
        initialFrameOffsetLimit: _initialFrameOffsetLimit,
        maxLimit: asteroidCount ??10,
        minLimit: asteroidCount ?? 10,
    ));
  }

  //Update particle(Asteroid & Projectiles) position based on velocity & direction on gameTicker callback
  void _updateParticlePosition(double deltaTime) {
    for (int i = 0; i < _asteroids.length; i++) {
      double dx = _asteroids[i].posX! +
          (_asteroids[i].speed! * math.cos(_asteroids[i].direction!)) * deltaTime;
      double dy = _asteroids[i].posY! +
          (_asteroids[i].speed! * math.sin(_asteroids[i].direction!)) * deltaTime;
      _asteroids[i].posX = dx;
      _asteroids[i].posY = dy;
    }
    for (int i = 0; i < _player.projectiles.length; i++) {
      double dx = _player.projectiles[i].posX! +
          (_player.projectiles[i].speed! * math.cos(_player.projectiles[i].direction!)) * deltaTime;
      double dy = _player.projectiles[i].posY! +
          (_player.projectiles[i].speed! * math.sin(_player.projectiles[i].direction!)) * deltaTime;
      _player.projectiles[i].posX = dx;
      _player.projectiles[i].posY = dy;
    }
  }

  //Check if particles have left the gameScreen viewport in all directions and
  // randomly generate new particles based on the limit of asteroids allowed
  void _verifyParticleInGamePort(RenderBox gameBox) {
    final Size gameScreenSize = gameBox!.size;
    final gameOffset = gameBox.localToGlobal(Offset.zero);
    int removedAsteroidCount = _minAsteroidCount - _asteroids.length;
    debugPrint("currentAsteroidCount: ${_asteroids.length}");
    //Add new Asteroids
    if (removedAsteroidCount > 0) {
      _initializeParticles(gameBox: gameBox, asteroidCount: removedAsteroidCount);
    }
    for (int i = 0; i < _asteroids.length; i++) {
      if (!(((_asteroids[i].posX! < gameOffset.dx + gameScreenSize.width + _initialFrameOffsetLimit) &&
          (_asteroids[i].posX! > gameOffset.dx - _initialFrameOffsetLimit)) ||
          ((_asteroids[i].posY! < gameOffset.dy + gameScreenSize.height + _initialFrameOffsetLimit) &&
              (_asteroids[i].posY! > gameOffset.dy - _initialFrameOffsetLimit)))) {
        _asteroids.remove(_asteroids[i]);
        debugPrint("currentAsteroidCount: ${_asteroids.length}");
      }
    }
    for (int i = 0; i < _player.projectiles.length; i++) {
      if (!((_player.projectiles[i].posX! < gameOffset.dx + gameScreenSize.width) ||
          (_player.projectiles[i].posX! > gameOffset.dx) ||
          (_player.projectiles[i].posY! < gameOffset.dy + gameScreenSize.height) ||
              (_player.projectiles[i].posY! > gameOffset.dy))) {
        _player.projectiles.remove(_player.projectiles[i]);
      }
    }
  }

  //Detect collision between players and asteroids based on the detection radius
  // around the player.
  void _detectPlayerAsteroidCollision() {

  }

  //Detect collision between Asteroids and Projectiles
  void _detectAsteroidProjectileCollision() {

  }

  //Add projectile based on player's position & direction
  void addProjectile() {
    _player.projectiles.add(WeaponProjectile(
      posX: _player.posX,
      posY: _player.posX,
      direction: _player.direction,
      speed: 100,
    ));
  }

  //Update Player position every time
  void updatePlayerPosition({required Offset pos}) {
    _player.posX = pos.dx;
    _player.posY = pos.dy;
    _playerTrajectory.addOffset(pos);
  }

  void _update() => notifyListeners();

}