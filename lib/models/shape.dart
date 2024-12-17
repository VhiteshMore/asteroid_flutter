import 'dart:ui';

abstract class Shape {

  double left(Offset pos);
  double right(Offset pos);
  double bottom(Offset pos);
  double top(Offset pos);

}

class Circle extends Shape {

  final double radius;

  Circle({required this.radius});

  @override
  double right(Offset pos) {
    return pos.dx + radius;
  }

  @override
  double bottom(Offset pos) {
    return pos.dy + radius;
  }

  @override
  double left(Offset pos) {
    return pos.dx - radius;
  }

  @override
  double top(Offset pos) {
    return pos.dy - radius;
  }

}

// class Rectangle extends Shape {
//
//   final double width;
//   final double height;
//
//   Rectangle({required this.width, required this.height});
//
//   @override
//   double right(Offset pos) {
//     // TODO: implement maxX
//     throw UnimplementedError();
//   }
//
//   @override
//   double bottom(Offset pos) {
//     // TODO: implement maxY
//     throw UnimplementedError();
//   }
//
//   @override
//   double left(Offset pos) {
//     // TODO: implement minX
//     throw UnimplementedError();
//   }
//
//   @override
//   double top(Offset pos) {
//     // TODO: implement minY
//     throw UnimplementedError();
//   }
//
// }
//
// class Square extends Shape {
//
//   final double side;
//
//   Square({required this.side});
//
//   @override
//   double left(Offset pos) {
//     return pos.dx;
//   }
//
//   @override
//   double top(Offset pos) {
//     return pos.dy;
//   }
//
//   @override
//   double right(Offset pos) {
//     return pos.dx + side;
//   }
//
//   @override
//   double bottom(Offset pos) {
//     return pos.dy + side;
//   }
//
// }
//
// class Polygon extends Shape {
//
//   final List<Offset> vertices;
//
//   Polygon({required this.vertices});
//
//   @override
//   double left(Offset pos) {
//     return pos.dx - 5;
//   }
//
//   @override
//   double top(Offset pos) {
//     return pos.dy - 5;
//   }
//
//   @override
//   double right(Offset pos) {
//     return pos.dx + 5;
//   }
//
//   @override
//   double bottom(Offset pos) {
//     return pos.dx + 5;
//   }
//
// }