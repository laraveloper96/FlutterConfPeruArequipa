import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbuz_arm_robotic/core/robot_arm/models/robot_event.dart';
import 'package:nimbuz_arm_robotic/features/principal/blocs/principal/principal_bloc.dart';
import 'package:nimbuz_arm_robotic/features/principal/blocs/sliders/slider_controls_bloc.dart';
import 'package:nimbuz_arm_robotic/shared/utils/utils.dart';
import 'package:nimbuz_arm_robotic/shared/widgets/widgets.dart';

class TopPanelCtrls extends StatelessWidget {
  const TopPanelCtrls({super.key});

  Future<void> onSendCommand(BuildContext context,
      {required Command command, required int val}) async {
    if (context.mounted) {
      // final robotEvent = RobotEvent(command, val);
      // context.read<PrincipalBloc>().add(SendCommandEv(robotEvent));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrincipalBloc, PrincipalState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const _Robots(),
            HorizontalSpace.lg,
            BtnIcon(
              icon: Icons.save_outlined,
              label: 'Save',
              onTap: () {
                final moves =
                    context.read<SliderControlsBloc>().state.currentMoves;
                context.read<PrincipalBloc>().add(SaveMovesEv(moves));
              },
            ),
            HorizontalSpace.md,
            BtnIcon(
              icon: Icons.play_arrow,
              label: 'Play',
              onTap: () {
                context.read<PrincipalBloc>().add(const PlayMovesEv());
              },
            ),
            HorizontalSpace.md,
            BtnIcon(
              icon: Icons.restore_outlined,
              label: 'Reset',
              onTap: () {
                context.read<PrincipalBloc>().add(const ResetMovesEv());
              },
            ),
            HorizontalSpace.md,
            BtnIcon(
              icon: Icons.ios_share,
              label: 'Export',
              onTap: () =>
                  context.read<PrincipalBloc>().add(const ExportMovesEv()),
            ),
            HorizontalSpace.md,
            BtnIcon(
              icon: Icons.file_download_outlined,
              label: 'Import ',
              onTap: () =>
                  context.read<PrincipalBloc>().add(const ImportMovesEv()),
            ),
          ],
        );
      },
    );
  }
}
