import 'package:asteroid_flutter/models/player.dart';
import 'package:asteroid_flutter/ui/feature/game/bloc/game_bloc.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {

  static String route = '/GameScreen';

  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {

  final ValueNotifier<Offset> _offsetNotifier = ValueNotifier(Offset.zero);

  late final GameBloc gameBloc;

  @override
  void initState() {
    super.initState();
    gameBloc = GameBloc(player: Player(height: 50, width: 50,));
    gameBloc.startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.none,
            onHover: (event) {
              _offsetNotifier.value = event.position;
            },
          ),
          //Asteroid Custom Painter Layer
          ValueListenableBuilder(
            valueListenable: _offsetNotifier,
            builder: (context, value, child) {
              return Positioned(
                  left: value.dx,
                  top: value.dy,
                  child: Container(
                    height: 21,
                    width: 21,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint('Pew pew');
                      },
                    ),
                  ),
              );
            },
          ),
        ],
      ),
    );
  }

}
