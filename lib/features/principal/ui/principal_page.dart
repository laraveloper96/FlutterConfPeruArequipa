import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/mqtt_impl.dart';
import 'package:nimbuz_arm_robotic/features/principal/blocs/principal/principal_bloc.dart';
import 'package:nimbuz_arm_robotic/features/principal/blocs/sliders/slider_controls_bloc.dart';
import 'package:nimbuz_arm_robotic/features/principal/ui/principal_view.dart';
import 'package:nimbuz_arm_robotic/shared/nav/nav.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PrincipalBloc(
            mqtt: MqttImpl(),
          )..add(InitEv()),
        ),
        BlocProvider(
          create: (context) => SliderControlsBloc(),
        ),
      ],
      child: BlocListener<PrincipalBloc, PrincipalState>(
        listener: (context, state) {
          if (state.status.isNewAddRobot) {
            Nav.toast(context, 'New Robot Detected');
          }
          if (state.status.isChangeStatusRobot) {
            Nav.toast(context, state.message);
          }
          if (state.status.isSuccessImport) {
            Nav.toast(context, 'Importación Exitosa');
          }
          if (state.status.isFailureImport) {
            Nav.toast(context, 'No se pudo importar movimientos');
          }

          // if (state is Error) {
          //   Nav.toast(context, 'state.message');
          // }
        },
        child: const PrincipalView(),
      ),
    );
  }
}
