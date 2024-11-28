import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {

  final ValueNotifier<Offset> _offsetNotifier = ValueNotifier(Offset.zero);

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
            onHover: (event) {
              _offsetNotifier.value = event.position;
            },
          ),
          ValueListenableBuilder(
            valueListenable: _offsetNotifier, builder: (context, value, child) {
            return Positioned(
                left: value.dx,
                top: value.dy,
                child: Container(
                    height: 21, width: 21, color: Colors.white,));
          },),

        ],
      ),
    );
  }

}
