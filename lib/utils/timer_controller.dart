import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerController extends ChangeNotifier {
  final int durationMinutes;
  late Duration _remaining;
  Duration get remaining => _remaining;

  bool _isCountingDown = false;
  bool get isCountingDown => _isCountingDown;

  bool _isPaused = false;
  bool get isPaused => _isPaused;

  DateTime? _endTime;
  Timer? _timer;

  VoidCallback? onCountdownComplete;

  TimerController({required this.durationMinutes}) {
    _remaining = Duration(minutes: durationMinutes);
  }

  void start() {
    if (_isCountingDown) return;

    _isCountingDown = true;
    _isPaused = false;
    _endTime = DateTime.now().add(_remaining);
    _tick();
    notifyListeners();
  }

  void pause() {
    if (!_isCountingDown || _isPaused) return;
    _isPaused = true;
    _timer?.cancel();
    notifyListeners();
  }

  void resume() {
    if (!_isPaused) return;
    _isPaused = false;
    _endTime = DateTime.now().add(_remaining);
    _tick();
    notifyListeners();
  }

  void _tick() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isPaused || _endTime == null) {
        timer.cancel();
        return;
      }

      final diff = _endTime!.difference(DateTime.now());

      if (diff.isNegative) {
        _remaining = Duration.zero;
        _isCountingDown = false;
        _isPaused = false;
        timer.cancel();
        notifyListeners();
        if (onCountdownComplete != null) onCountdownComplete!();
      } else {
        _remaining = diff;
        notifyListeners();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
