import 'package:asteroid_flutter/ui/feature/game/screens/game_screen.dart';
import 'package:asteroid_flutter/ui/feature/game/screens/intro_screen.dart';
import 'package:flutter/material.dart';

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
      // onGenerateRoute: ((settings) {
      //   if (settings.name == OtpScreen.route) {
      //     final args = settings.arguments as Map;
      //     return MaterialPageRoute(
      //       builder: (context) =>
      //           OtpScreen(mobileNumber: args[Args.argMobileNumber], country: args[Args.argSelectedCountry],),
      //     );
      //   } else if (settings.name == PersonalDetailScreen.route) {
      //     final args = settings.arguments as Map;
      //     return MaterialPageRoute(
      //       builder: (context) =>
      //           PersonalDetailScreen(isRegistration: args[Args.argIsRegistration]),
      //     );
      //   }
      // }),
    );
  }
}
