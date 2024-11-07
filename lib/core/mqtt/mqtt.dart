import 'package:nimbuz_arm_robotic/core/mqtt/mqtt.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/options.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/robot.dart';

export 'types.dart';

abstract class Mqtt {
  Future<bool> connect(Options options);
  bool get isConnect;
  Future<void> disconnect();

  Future<void> sendMessage({
    required Topic topic,
    required String clientId,
    required String command,
    required int value,
  });

  Future<void> subscribeTopic(
    Topic topic,
  );

  Future<void> unsubscribe(
    Topic topic,
  );

  Stream<Robot> onMessages();
  Future<void> onAutoReconnect();
  Future<void> onAutoReconnected();
}
