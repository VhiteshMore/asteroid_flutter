import 'package:asteroid_flutter/models/particle.dart';
import 'package:asteroid_flutter/models/shape.dart';
import 'package:asteroid_flutter/models/projectile.dart';

class Player extends Particle {

  final double height;
  final double width;

  @override
  double? posX;
  @override
  double? posY;
  //Convert to radian or degrees wrt to reference (0,0) and +,- signs
  @override
  double? direction;
  @override
  double? speed;
  @override
  double? acceleration;
  @override
  final Shape shape;

  double score;

  List<Projectile> projectiles;

  Player({
    required this.height,
    required this.width,
    this.posX = 0,
    this.posY = 0,
    this.speed = 0,
    this.direction = 0,
    this.acceleration = 0,
    required this.shape,
    this.score = 0,
    List<Projectile>? projectiles,
  })  : projectiles = projectiles ?? [],
        super(
          acceleration: 0,
          posX: posX,
          posY: posY,
          direction: direction,
          speed: speed,
          shape: shape,
        );

  //change or update direction
  // @override
  // void updateDirection({required double direction}) {
  //   // TODO: implement updateDirection
  // }

  //move or update
  // @override
  // void updatePosition({required double dx, required double dy}) {
  //   // TODO: implement updatePosition
  // }

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;

    return other is Player &&
        other.shape == shape &&
        other.height == height &&
        other.width == width &&
        other.posX == posX &&
        other.posY == posY &&
        other.speed == speed &&
        other.direction == direction &&
        other.acceleration == acceleration &&
        other.score == score;
  }

  @override
  int get hashCode =>
      shape.hashCode ^
      height.hashCode ^
      width.hashCode ^
      posX.hashCode ^
      posY.hashCode ^
      speed.hashCode ^
      direction.hashCode ^
      acceleration.hashCode ^
      score.hashCode;

  @override
  String toString() {
    return '''Player -> posX: $posX; posY: $posY''';
  }

}