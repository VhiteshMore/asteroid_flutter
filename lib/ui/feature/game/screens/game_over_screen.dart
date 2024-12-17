import 'package:flutter/material.dart';
import 'package:asteroid_flutter/index.dart';

class GameOverScreen extends StatefulWidget {

  static String route = '/GameOverScreen';
  final int seconds;

  const GameOverScreen({required this.seconds, super.key});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  AppStrings.gameOver,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 20),
                Text(
                  'You lasted ${getFormattedTime()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(GameScreen.route);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: const Text(
                      AppStrings.tryAgain,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getFormattedTime() {
    String time = '';
    int minutes = widget.seconds ~/ 60;
    int seconds = widget.seconds;
    if (minutes > 0) {
      time = '$minutes ${minutes > 1 ? 'minutes': 'minute'} and ${seconds > 60 ? (minutes > 0 ? seconds - minutes*60 : seconds) : (seconds < 10 ? '0$seconds' : seconds)} seconds';
    } else {
      time = '$seconds seconds';
    }
    return time;
  }

}
