import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/player.dart';

class Game {

  List<Asteroid> asteroids = [];
  final Player player;

  Game({
    required this.player,
    List<Asteroid>? asteroids,
  }) : asteroids = asteroids ?? [];

  void start () {}



}