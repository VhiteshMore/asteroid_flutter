import 'package:flutter/scheduler.dart';

/// Callback that provides deltaTime dt (in seconds) and time correction factor.
typedef GameTickerCallback = void Function(double dt, double timeCorrection);

/// Runner provides a simple game loop, that updates the Engine on every frame.
class GameTicker {
  double _correction = 1.0;
  Ticker? _ticker;
  GameTickerCallback? _dtCallback;

  // Maintain previous duration to calculate the next deltaTime.
  Duration _previousTime = Duration.zero;

  // Maintain previous deltaTime (in seconds) to calculate next time correction.
  // Initially, assumed that we are ticking at 60 frames per second.
  double _prevDeltaTime = 1000 / 60;


  /// Creates a gameloop that provides callback to help continously [tick] the Engine.
  void run(GameTickerCallback dtCallback) {
    _dtCallback = dtCallback;
    _ticker?.dispose();
    _ticker = Ticker(_tick);
    _ticker!.start();
  }

  /// Calculates time delta and correction factor from current time.
  void _tick(Duration currentTime) {
    final diff = _previousTime == Duration.zero ? Duration.zero : currentTime - _previousTime;
    _previousTime = currentTime;

    // New delta time in seconds.
    final deltaTime = diff.inMicroseconds / Duration.microsecondsPerSecond;

    // Calculate time correction.
    _correction = deltaTime / _prevDeltaTime;
    _prevDeltaTime = deltaTime;
    _dtCallback?.call(deltaTime, _correction);
  }

  void pause() {
    _ticker?.muted = true;
    _previousTime = Duration.zero;
  }

  void resume() {
    _ticker?.muted = false;
  }

  /// Stops the runner, and reset all values.
  void stop() {
    _ticker?.stop();
    _ticker?.dispose();
    _correction = 1.0;
    _previousTime = Duration.zero;
    _prevDeltaTime = 1000 / 60;
    _ticker = null;
    _dtCallback = null;
  }
}
