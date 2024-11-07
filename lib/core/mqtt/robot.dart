import 'package:equatable/equatable.dart';

class Robot extends Equatable {
  const Robot({
    required this.mac,
    required this.clientID,
    required this.name,
    required this.status,
    required this.enable,
  });

  factory Robot.fromJson(Map<String, dynamic> json) {
    return Robot(
        mac: json['id'] as String,
        name: json['client_name'] as String,
        clientID: json['client_id'] as String,
        status: json['status'] as bool,
        enable: false);
  }

  Robot copyWith({bool? enable, bool? status}) {
    return Robot(
      mac: mac,
      clientID: clientID,
      name: name,
      status: status ?? this.status,
      enable: enable ?? this.enable,
    );
  }

  static Robot all() => const Robot(
        mac: '00:00:00:00',
        clientID: 'all',
        name: 'All',
        status: false,
        enable: false,
      );

  final String mac;
  final String name;
  final String clientID;
  final bool status;
  final bool enable;

  @override
  List<Object> get props => [mac, name, clientID, status, enable];
}
