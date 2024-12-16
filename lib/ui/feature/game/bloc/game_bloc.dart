import 'dart:math' as math;

import 'package:asteroid_flutter/models/index.dart';
import 'package:asteroid_flutter/utils/index.dart';
import 'package:flutter/material.dart';

import '../../../../models/shape.dart';
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
  void startGame() {
    assert(gameScreenKey.currentContext != null,
        'Please attach the gameScreenKey to your GameWidget where asteroids and projectiles will be displayed');
    RenderBox gameBox = gameScreenKey.currentContext!.findRenderObject() as RenderBox;
    _gameStarted = true;
    _startTicker(gameBox);
    _initializeParticles(asteroidCount: _minAsteroidCount, gameBox: gameBox);
    _update();
  }

  //Pause the game
  void pause() {
    _gameTicker.pause();
  }

  //Resume the game
  void resume() {
    _gameTicker.resume();
  }

  //End the game
  void _gameOver() {
    _gameTicker.stop();
    _update();
  }

  void _startTicker(RenderBox gameBox) {
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
    Offset center = Offset(gameBox.size.width / 2, gameBox.size.height / 2);
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
    for (int i = 0; i < weaponProjectiles.length; i++) {
      double dx = weaponProjectiles[i].posX! +
          (weaponProjectiles[i].speed! * math.cos(weaponProjectiles[i].direction!)) * deltaTime;
      double dy = weaponProjectiles[i].posY! +
          (weaponProjectiles[i].speed! * math.sin(weaponProjectiles[i].direction!)) * deltaTime;
      weaponProjectiles[i].posX = dx;
      weaponProjectiles[i].posY = dy;
    }
  }

  //Check if particles have left the gameScreen viewport in all directions and
  // randomly generate new particles based on the limit of asteroids allowed
  void _verifyParticleInGamePort(RenderBox gameBox) {
    final Size gameScreenSize = gameBox!.size;
    final gameOffset = gameBox.localToGlobal(Offset.zero);
    int removedAsteroidCount = _minAsteroidCount - _asteroids.length;
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
    // _asteroids.sort((a, b) => a.shape.left(Offset(a.posX!, a.posY!)).compareTo(b.shape.left(Offset(b.posX!, b.posY!))));
    for (int i = 0; i < _asteroids.length; i++) {
      final asteroid1 = _asteroids[i];

      // if (_player.shape.left(Offset(_player.posX!, _player.posY!)) >
      //     asteroid1.shape.right(Offset(asteroid1.posX!, asteroid1.posY!))) break;
      //intersection
      if (GameUtils.intersects(_player, asteroid1)) {
        _gameOver();
      }
    }

  }

  //Detect collision between Asteroids and Projectiles
  void _detectAsteroidProjectileCollision() {
    //Sorting
    List<EdgeSort<Particle>> objects = [];
    for (int i = 0; i < (_asteroids.length); i++) {
      objects.addAll([
        EdgeSort(object: _asteroids[i], x: _asteroids[i].shape.left(Offset(_asteroids[i].posX!, _asteroids[i].posY!)), isLeft: true),
        EdgeSort(object: _asteroids[i], x: _asteroids[i].shape.right(Offset(_asteroids[i].posX!, _asteroids[i].posY!)), isLeft: false),
      ]);
    }
    for (int i = 0; i < (weaponProjectiles.length); i++) {
      objects.addAll([
        EdgeSort(object: weaponProjectiles[i], x: weaponProjectiles[i].shape!.left(Offset(weaponProjectiles[i].posX!, weaponProjectiles[i].posY!)), isLeft: true),
        EdgeSort(object: weaponProjectiles[i], x: weaponProjectiles[i].shape!.right(Offset(weaponProjectiles[i].posX!, weaponProjectiles[i].posY!)), isLeft: false),
      ]);
    }
    objects.sort((a, b) => a.x.compareTo(b.x));

    Set<EdgeSort<Particle>> touching = {};

    for (var object in objects) {
      if (object.isLeft) {
        for (var other in touching) {
          if (object.object is Asteroid && other.object is WeaponProjectile) {
            if (GameUtils.intersects(object.object, other.object)) {
              _asteroids.remove(object.object);
              _player.projectiles.remove(other.object);
            }
          }
        }
        touching.add(object);
      } else {
        touching.removeWhere((e) => e.object == object.object,);
      }
    }

    for (int i = 0; i < objects.length; i++) {
      //Sweep and prune based on runtime types of List<EdgeSort<Particle>> EdgeSort > object {Asteroid or WeaponProjectile}
      final asteroid1 = objects[i];

      for (int j = 0; j < objects.length; j ++) {

      }
    }
  }

  //Add projectile based on player's position & direction
  void addProjectile() {
    debugPrint("_player posX:${_player.posX}, posY: ${_player.posY}");
    _player.projectiles.add(WeaponProjectile(
      posX: playerPosX(),
      posY: playerPosY(),
      direction: _player.direction,
      speed: 100,
      shape: Circle(radius: 5),
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