import 'package:asteroid_flutter/models/asteroid.dart';
import 'package:asteroid_flutter/models/shape.dart';
import 'package:flutter/material.dart';

import '../../models/weapon_projectile.dart';

class ParticlePainter extends CustomPainter {

  List<Asteroid> asteroid = [];
  List<WeaponProjectile> projectiles = [];

  ParticlePainter({required this.asteroid, required this.projectiles});

  @override
  void paint(Canvas canvas, Size size) {
    for (int index = 0; index < asteroid.length; index++) {
      canvas.drawCircle(
        Offset(asteroid[index].posX!, asteroid[index].posY!),
        (asteroid[index].shape as Circle).radius,
        Paint()..color = asteroid[index].color,
      );
    }
    for (int index = 0; index < projectiles.length; index++) {
      canvas.drawCircle(
        Offset(projectiles[index].posX!, projectiles[index].posY!),
        5,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}