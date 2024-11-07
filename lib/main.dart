import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nimbuz_arm_robotic/app/app.dart';
import 'package:nimbuz_arm_robotic/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);
  bootstrap(() => const App());
}
