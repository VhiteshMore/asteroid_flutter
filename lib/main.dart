import 'package:flutter/material.dart';
import 'package:asteroid_flutter/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const IntroScreen(),
        GameScreen.route: (context) => const GameScreen(),
      },
      onGenerateRoute: ((settings) {
        if (settings.name == GameOverScreen.route) {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
            builder: (context) =>
                GameOverScreen(seconds: args['seconds'],),
          );
        }
      }),
    );
  }
}
