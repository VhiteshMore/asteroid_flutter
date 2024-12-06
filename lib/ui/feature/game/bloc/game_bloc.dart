import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/game.dart';
import 'package:asteroid_flutter/models/particle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../../../../models/player.dart';
import '../../../../models/weapon_projectile.dart';
import '../../../../utils/game_ticker.dart';

class GameBloc extends ChangeNotifier {

  final Player player;
  late final GameTicker _gameTicker;
  List<Asteroid> _asteroids = [];

  bool _gameStarted = false;

  GameBloc({required this.player});

  _startTicker() {
    _gameTicker = GameTicker();
    _gameTicker.run((dt, timeCorrection) {
      // debugPrint('_gameTicker Callback: dt: $dt; timeCorrection: $timeCorrection');
    },);
  }

  startGame() {
    _gameStarted = true;
    _startTicker();
    notifyListeners();
  }



  List<Asteroid> get asteroids => _asteroids;

  set asteroids(List<Asteroid> asteroids) {
    _asteroids = asteroids;
    notifyListeners();
  }

}