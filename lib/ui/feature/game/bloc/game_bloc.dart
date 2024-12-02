import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/game.dart';
import 'package:asteroid_flutter/models/particle.dart';
import 'package:flutter/scheduler.dart';

import '../../../../models/player.dart';
import '../../../../models/weapon_projectile.dart';

class GameBloc extends TickerProvider {

  List<Asteroid> _asteroids = [];
  List<WeaponProjectile> _projectiles = [];
  final Player player;

  GameBloc({required this.player});

  @override
  Ticker createTicker(TickerCallback onTick) {
    // TODO: implement createTicker
    throw UnimplementedError();
  }

}