import 'package:asteroid_flutter/models/player.dart';
import 'package:asteroid_flutter/ui/feature/game/bloc/game_bloc.dart';
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
    _gameBloc = GameBloc(player: Player(height: 50, width: 50,));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _gameBloc.startGame();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Listener(
        onPointerHover: (event) {
          _gameBloc.updatePlayerPosition(pos: event.position);
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.none,
          // onHover: (event) {
          //   _gameBloc.updatePlayerPosition(pos: event.position);
          // },
          child: AnimatedBuilder(
            animation: _gameBloc,
            builder: (context, child) {
              return Stack(
                fit: StackFit.expand,
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
                      onTap: () {
                        _gameBloc.addProjectile();
                        debugPrint('Pew pew');
                      },
                      child: PointerWidget(
                        angle: _gameBloc.pointerAngle,
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

}
