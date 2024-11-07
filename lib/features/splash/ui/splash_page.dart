import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbuz_arm_robotic/features/principal/ui/principal_page.dart';
import 'package:nimbuz_arm_robotic/features/splash/bloc/splash_bloc.dart';
import 'package:nimbuz_arm_robotic/features/splash/ui/splash_view.dart';
import 'package:nimbuz_arm_robotic/shared/nav/nav.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc()..add(LoadAppEv()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            Nav.root(context, const PrincipalPage());
          }
        },
        child: const SplashView(),
      ),
    );
  }
}
