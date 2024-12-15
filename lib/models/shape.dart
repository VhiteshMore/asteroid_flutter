import 'dart:ui';

abstract class Shape {

  double minX(Offset pos);
  double maxX(Offset pos);
  double minY(Offset pos);
  double maxY(Offset pos);

}

class Circle extends Shape {

  final double radius;

  Circle({required this.radius});

  @override
  double maxX(Offset pos) {
    return pos.dx + radius * 2;
  }

  @override
  double maxY(Offset pos) {
    return pos.dy + radius * 2;
  }

  @override
  double minX(Offset pos) {
    return pos.dx;
  }

  @override
  double minY(Offset pos) {
    return pos.dy;
  }

}

class Rectangle extends Shape {

  final double width;
  final double height;

  Rectangle({required this.width, required this.height});

  @override
  double maxX(Offset pos) {
    // TODO: implement maxX
    throw UnimplementedError();
  }

  @override
  double maxY(Offset pos) {
    // TODO: implement maxY
    throw UnimplementedError();
  }

  @override
  double minX(Offset pos) {
    // TODO: implement minX
    throw UnimplementedError();
  }

  @override
  double minY(Offset pos) {
    // TODO: implement minY
    throw UnimplementedError();
  }

}

class Square extends Shape {

  final double side;

  Square({required this.side});

  @override
  double maxX(Offset pos) {
    // TODO: implement maxX
    throw UnimplementedError();
  }

  @override
  double maxY(Offset pos) {
    // TODO: implement maxY
    throw UnimplementedError();
  }

  @override
  double minX(Offset pos) {
    // TODO: implement minX
    throw UnimplementedError();
  }

  @override
  double minY(Offset pos) {
    // TODO: implement minY
    throw UnimplementedError();
  }

}

class Polygon extends Shape {

  final List<Offset> vertices;

  Polygon({required this.vertices});

  @override
  double maxX(Offset pos) {
    // TODO: implement maxX
    throw UnimplementedError();
  }

  @override
  double maxY(Offset pos) {
    // TODO: implement maxY
    throw UnimplementedError();
  }

  @override
  double minX(Offset pos) {
    // TODO: implement minX
    throw UnimplementedError();
  }

  @override
  double minY(Offset pos) {
    // TODO: implement minY
    throw UnimplementedError();
  }

}