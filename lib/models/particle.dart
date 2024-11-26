abstract class Particle {

  double? posX;
  double? posY;
  //Convert to radian or degrees wrt to reference (0,0) and +,- signs
  double? direction;
  double? speed;
  double? acceleration;

  void updatePosition();

  void updateDirection();

}