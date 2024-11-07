import 'dart:async';

class Debouncer {
  Timer? _timer;
  final Duration delay;

  Debouncer({this.delay = const Duration(milliseconds: 75)});

  void run(Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}
