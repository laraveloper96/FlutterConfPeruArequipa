// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

// import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart' hide Topic;
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/mqtt.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/options.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/robot.dart';

class MqttImpl implements Mqtt {
  MqttServerClient? _client;

  StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>?
      messagesSubscription;

  final _sCtrl = StreamController<Robot>();
  final _builder = MqttClientPayloadBuilder();

  @override
  bool get isConnect =>
      _client!.connectionStatus?.state == MqttConnectionState.connected;
  @override
  Future<bool> connect(Options options) async {
    try {
      print('[MQTT client] MQTT start....');
      _client ??= MqttServerClient.withPort(
          options.host, options.clientId, options.port);

      _client!.keepAlivePeriod = 30;
      _client!.logging(on: false);
      _client!.setProtocolV311();
      _client!.keepAlivePeriod = 20;
      _client!.connectTimeoutPeriod = 2000;

      final connMess = MqttConnectMessage()
          .withClientIdentifier(options.clientId)
          .withWillTopic('willtopic')
          .withWillMessage('Will message')
          .startClean()
          .withWillQos(MqttQos.atMostOnce);

      print('[MQTT client] MQTT client connecting....');

      _client!.connectionMessage = connMess;

      await _client!.connect();
      print('[MQTT client] MQTT client connected');

      final result =
          _client!.connectionStatus?.state == MqttConnectionState.connected;
      return result;
    } catch (e) {
      print(e);
      _client!.disconnect();
      print('[MQTT client] MQTT client disconnected');
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    if (_client != null) {
      _client?.disconnect();
    }
    _dispose();
    print('[MQTT client] MQTT client disconnected');
  }

  @override
  Future<int> sendMessage({
    required Topic topic,
    required String clientId,
    required String command,
    required int value,
  }) async {
    if (_client == null) throw Exception('[Error]: Required connect first');

    if (_client!.connectionStatus == null) {
      throw Exception('[Error]: Error connect not found');
    }

    if (_client!.connectionStatus!.state != MqttConnectionState.connected) {
      throw Exception('[Error]: fail can not send message');
    }

    print('[MQTT client] MQTT client sending message');

    final valMap = <String, dynamic>{
      'client_id': clientId,
      'command': command,
      'value': value,
    };

    _builder
      ..clear()
      ..addString(jsonEncode(valMap));

    final result = _client!.publishMessage(
      topic.url,
      MqttQos.atLeastOnce,
      // MqttQos.exactlyOnce,
      _builder.payload!,
    );

    print('[MQTT client] MQTT client sended message $result $value');
    return result;
  }

  @override
  Future<void> subscribeTopic(
    Topic topic,
  ) async {
    if (_client == null) throw Exception('[Error]: Required connect first');

    print('[MQTT client] MQTT client subcribing topic...');

    _client!.subscribe(topic.url, MqttQos.atLeastOnce);

    print('[MQTT client] MQTT client subcribed topic');
    messagesSubscription = _client!.updates
        ?.listen((List<MqttReceivedMessage<MqttMessage?>> event) {
      if (event.isNotEmpty) {
        final mqttMessage = event.first;
        final recMess = mqttMessage.payload as MqttPublishMessage;
        final message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('[MQTT client] MQTT message: topic is <${mqttMessage.topic}>, '
            'payload is <-- $message -->');

        final data = jsonDecode(message) as Map<String, dynamic>;

        _sCtrl.add(Robot.fromJson(data));
      }
    });
  }

  @override
  Stream<Robot> onMessages() {
    return _sCtrl.stream;
  }

  @override
  Future<void> unsubscribe(Topic topic) async {
    if (_client == null) throw Exception('[Error]: Required connect first');

    _client!.unsubscribe(topic.url);
    print('[MQTT client] MQTT unsubscribe');
    _dispose();
  }

  void _dispose() {
    messagesSubscription?.cancel();
    print('[MQTT client] MQTT dispose');
  }

  /// The pre auto re connect callback
  @override
  Future<void> onAutoReconnect() async {
    print('[MQTT client] MQTT Client auto reconnection sequence will start');
  }

  /// The post auto re connect callback
  @override
  Future<void> onAutoReconnected() async {
    print('[MQTT client] MQTT Client auto reconnection sequence has completed');
  }
}
