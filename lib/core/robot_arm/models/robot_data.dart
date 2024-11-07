import 'package:nimbuz_arm_robotic/core/robot_arm/models/robot_event.dart';

class RobotData {
  RobotData({
    required this.clientId,
    required this.steps,
  });
  final String clientId;
  final List<List<RobotEvent>> steps;

  factory RobotData.fromJson(Map<String, dynamic> json) {
    return RobotData(
      clientId: json['client_id'],
      steps: (json['steps'] as List)
          .map((step) => (step['moves'] as List)
              .map((move) => RobotEvent.fromJson(move))
              .toList())
          .toList(),
    );
  }
}
