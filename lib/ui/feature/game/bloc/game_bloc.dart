import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/game.dart';
import 'package:asteroid_flutter/models/particle.dart';
import 'package:asteroid_flutter/ui/feature/game/bloc/game_state.dart';
import 'package:flutter/scheduler.dart';

import '../../../../models/player.dart';
import '../../../../models/weapon_projectile.dart';

class GameBloc extends TickerProvider {

  final Player player;
  late final GameState _gameState;

  GameBloc({required this.player}) {
    initialize();
  }

  initialize () {
    _gameState = GameState();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    // TODO: implement createTicker
    throw UnimplementedError();
  }

}