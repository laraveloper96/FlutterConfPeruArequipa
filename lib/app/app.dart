import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/mqtt.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/mqtt_impl.dart';
import 'package:nimbuz_arm_robotic/core/utils/debouncer.dart';
import 'package:nimbuz_arm_robotic/features/splash/ui/splash_page.dart';
import 'package:nimbuz_arm_robotic/shared/utils/utils.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider<IA>(
        //   create: (context) => IAimpl(),
        // ),
        RepositoryProvider<Mqtt>(
          create: (context) => MqttImpl(),
        ),
        RepositoryProvider<Debouncer>(
          create: (context) => Debouncer(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: CFonts.heebo,
          colorScheme: ColorScheme.fromSwatch(
            backgroundColor: const Color.fromARGB(255, 234, 236, 238),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
