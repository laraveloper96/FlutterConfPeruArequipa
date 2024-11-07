class Options {
  Options({
    required this.host,
    required this.port,
    required this.clientId,
  });

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      host: json['host'] as String,
      port: json['port'] as int,
      clientId: json['clientId'] as String,
    );
  }
  final String host;
  final int port;
  final String clientId;

  Options copyWith({
    String? host,
    int? port,
    String? clientId,
  }) {
    return Options(
      host: host ?? this.host,
      port: port ?? this.port,
      clientId: clientId ?? this.clientId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'port': port,
      'clientId': clientId,
    };
  }
}
