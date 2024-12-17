import 'dart:math';
import 'dart:ui';

class PlayerTrajectory {

  final List<Offset> _path = [];
  List<Offset> get path => _path;

  void addOffset(Offset position) {
    if (_path.length >= 20) {
      _path.removeAt(0);
    }
    _path.add(position);
  }

  void clearTrajectory() {
    _path.clear();
  }

  Offset get trajectoryDirectionOffset {
    if (_path.isEmpty) {
      return Offset.zero;
    }

    final first = _path.first;
    final last = _path.last;

    final avgDx = last.dx - first.dx;
    final avgDy = last.dy - first.dy;

    return Offset(avgDx, avgDy);
  }

  double get playerDirection => atan2(trajectoryDirectionOffset.dy, trajectoryDirectionOffset.dx);

}