final class Env {
  Env._privateConstructor({
    required this.ws,
    required this.port,
  });

  final String ws;
  final int port;

  static Env? _instance;

  static Env get instance {
    if (_instance != null) return _instance!;
    _instance = Env._privateConstructor(
      ws: const String.fromEnvironment('WS'),
      port: const int.fromEnvironment('PORT'),
    );
    return _instance!;
  }
}
