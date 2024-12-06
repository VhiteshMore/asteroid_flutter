import 'dart:math';

import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/particle.dart';
import 'package:flutter/material.dart';

class GameUtils {

  static List<Particle> generateAsteroids({int minLimit = 10, int maxLimit = 10, AsteroidShape shape = AsteroidShape.circle,}) {
    final rng = Random();
    List<Particle> particles = [];
    for (int i = 0; i < maxLimit; i++) {
      particles.add(Asteroid(
        color: Colors.primaries[rng.nextInt(Colors.primaries.length)],
        shape: shape,
        speed: 10,
      ));
    }
    return particles;
  }

  static double randomSign() {
    var rng = Random();
    return rng.nextBool() ? 1 : -1;
  }

}