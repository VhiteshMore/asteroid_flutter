import 'package:asteroid_flutter/models/player.dart';
import 'package:asteroid_flutter/models/shape.dart';
import 'package:asteroid_flutter/ui/feature/game/bloc/game_bloc.dart';
import 'package:asteroid_flutter/ui/feature/game/screens/game_over_screen.dart';
import 'package:asteroid_flutter/ui/widgets/pointer_widget.dart';
import 'package:flutter/material.dart';

import '../../../painters/particle_painter.dart';

class GameScreen extends StatefulWidget {

  static String route = '/GameScreen';

  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {

  late final GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();
    _gameBloc = GameBloc(
      player: Player(height: 50, width: 50, shape: Square(side: 5)),
      gameOver: () {
        Navigator.of(context).pushReplacementNamed(GameOverScreen.route, arguments: {'seconds': _gameBloc.getTime});
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _gameBloc.startGame();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.none,
          onHover: (event) {
            _gameBloc.updatePlayerPosition(pos: event.position);
          },
          child: AnimatedBuilder(
            animation: _gameBloc,
            builder: (context, child) {
              return Stack(
                fit: StackFit.passthrough,
                children: [
                  //Asteroid Custom Painter Layer
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white)
                    ),
                    child: CustomPaint(
                      key: _gameBloc.gameScreenKey,
                      painter: ParticlePainter(
                        asteroid: _gameBloc.asteroids,
                        projectiles: _gameBloc.weaponProjectiles,
                      ),
                    ),
                  ),
                  Positioned(
                    left: _gameBloc.playerPosX(),
                    top: _gameBloc.playerPosY(),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _gameBloc.addProjectile();
                      },
                      child: PointerWidget(
                        angle: _gameBloc.pointerAngle,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Timer: ${getFormattedTime()}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        decoration: null,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String getFormattedTime() {
    String time = '';
    int minutes = _gameBloc.getTime ~/ 60;
    int seconds = _gameBloc.getTime;
    time = '${minutes > 0 ? minutes : 0 }:${seconds > 60 ? (minutes > 0 ? seconds - minutes*60 : seconds) : (seconds < 10 ? '0$seconds' : seconds)}';
    return time;
  }

  @override
  void dispose() {
    _gameBloc.dispose();
    super.dispose();
  }

}
