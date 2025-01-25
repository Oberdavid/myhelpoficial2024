import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

typedef PhoneShakeCallback = void Function();

class Shake {
  // Singleton
  static final Shake _instance = Shake._internal();
  Shake._internal();
  factory Shake() => _instance;

  bool _isPaused = false;

  int _lastResumedTimeStamp = 0;

  PhoneShakeCallback? _onShake;

  // Reducir el umbral de detección para mayor sensibilidad
  final double _shakeThresholdGravity =
      1.5 * 1.6; // Ajustado para mayor sensibilidad
  // Mínimo de sacudidas necesarias dentro del tiempo permitido
  final int _minimumShakeCount = 3;
  // Reducir el tiempo mínimo entre sacudidas para mayor sensibilidad
  final int _shakeSlopTimeMS = 500; // Ajustado para mayor sensibilidad

  int _mShakeTimestamp = DateTime.now().millisecondsSinceEpoch;

  int _mShakeCount = 0;

  StreamSubscription? _streamSubscription;
  // Tiempo total permitido para detectar las sacudidas
  final int _totalTimeForShakes = 4000;

  int _startTime = 0;

  void startListening(PhoneShakeCallback shakeCallback) {
    _onShake = shakeCallback;
    _streamSubscription = accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        if (_isPaused) return;

        if (_lastResumedTimeStamp + 500 >
            DateTime.now().millisecondsSinceEpoch) {
          return;
        }

        var now = DateTime.now().millisecondsSinceEpoch;

        if (_startTime != 0 && (now - _startTime > _totalTimeForShakes)) {
          _mShakeCount = 0;
          _startTime = 0;
        }

        double x = event.x;
        double y = event.y;
        double z = event.z;

        double gX = x / 9.80665;
        double gY = y / 9.80665;
        double gZ = z / 9.80665;

        // gForce will be close to 1 when there is no movement.
        double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

        if (gForce > _shakeThresholdGravity) {
          // Ignorar sacudidas demasiado cercanas en el tiempo
          if (_mShakeTimestamp + _shakeSlopTimeMS > now) {
            return;
          }

          _mShakeTimestamp = now;
          if (_mShakeCount == 0) {
            _startTime = now;
          }

          _mShakeCount++;

          if (_mShakeCount >= _minimumShakeCount) {
            Vibration.vibrate(duration: 500);
            _onShake?.call();
            _mShakeCount = 0;
            _startTime = 0;
          } else {
            Vibration.vibrate(duration: 100);
          }
        }
      },
    );
  }

  void pauseListening() {
    _isPaused = true;
    _mShakeCount = 0;
    _streamSubscription?.pause();
  }

  void resumeListening() {
    _isPaused = false;
    _mShakeCount = 0;
    _lastResumedTimeStamp = DateTime.now().millisecondsSinceEpoch;
    _streamSubscription?.resume();
  }

  void stopListening() {
    _isPaused = false;
    _streamSubscription?.cancel();
  }

  bool get isPaused => _isPaused;
  bool get isListening => _isPaused;
}
