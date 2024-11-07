import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbuz_arm_robotic/core/mqtt/robot.dart';
import 'package:nimbuz_arm_robotic/core/robot_arm/models/robot_event.dart';
import 'package:nimbuz_arm_robotic/features/principal/blocs/principal/principal_bloc.dart';
import 'package:nimbuz_arm_robotic/shared/utils/assets.dart';
import 'package:nimbuz_arm_robotic/shared/utils/utils.dart';
import 'package:nimbuz_arm_robotic/shared/widgets/btn.dart';

class LeftPanelCtrls extends StatelessWidget {
  const LeftPanelCtrls({super.key});

  Future<void> onSendCommand(BuildContext context,
      {required Command command, required int val}) async {
    if (context.mounted) {
      final robotEvent = RobotEvent(command: command, value: val);
      context.read<PrincipalBloc>().add(SendCommandEv(robotEvent));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: BlocBuilder<PrincipalBloc, PrincipalState>(
        buildWhen: (previous, current) => current.status.isNewAddRobot,
        builder: (context, state) {
          // final robotAll = context.read<PrincipalBloc>().robotALL;

          return Padding(
            padding: const EdgeInsets.all(24.0).copyWith(bottom: 8),
            child: LayoutBuilder(
              builder: (context, box) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const _Robots(),
                    SizedBox(
                      height: box.maxHeight * .8,
                      width: box.maxWidth,
                      child: Image.asset(
                        AppAssets.arm,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _Robots extends StatelessWidget {
  const _Robots();

  Future<void> robotToggle(BuildContext context, Robot robot) async {
    if (context.mounted) {
      context.read<PrincipalBloc>().add(EnableRobotEv(robot));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrincipalBloc, PrincipalState>(
      buildWhen: (previous, current) =>
          current.status.isNewAddRobot || current.status.isChangeStatusRobot,
      builder: (context, state) {
        return Column(
          children: [
            Switch(
              // value: true,
              value: false,
              activeColor: Colors.white,
              // activeColor: Colors.red,
              trackOutlineColor: WidgetStatePropertyAll(
                Colors.white.withOpacity(.25),
              ),
              trackOutlineWidth: const WidgetStatePropertyAll(.5),
              // inactiveTrackColor: Colors.white.withOpacity(.25),
              inactiveTrackColor: Colors.white.withOpacity(.25),

              inactiveThumbColor: CColors.black.withOpacity(.25),
              // inactiveThumbColor: Colors.white.withOpacity(.25),
              onChanged: (value) {},
            ),
            VerticalSpace.md,
            ...state.robots.map(
              (e) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: BtnRobot(
                    icon: Icons.precision_manufacturing,
                    label: e.name,
                    status: e.status,
                    enable: e.enable,
                    onTap: () => robotToggle(context, e),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class ToggleRobot extends StatelessWidget {
  const ToggleRobot({
    required this.icon,
    required this.label,
    required this.enable,
    required this.status,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final bool status;
  final bool enable;
  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Switch(
          value: true,
          onChanged: (value) {},
        ),
        // Material(
        //   borderRadius: BorderRadius.circular(30),
        //   color: enable
        //       ? CColors.primaryColor
        //       : CColors.primaryColor.withOpacity(.2),
        //   child: InkWell(
        //     onTap: onTap,
        //     borderRadius: BorderRadius.circular(30),
        //     child: Ink(
        //       width: 80,
        //       height: 40,
        //       child: Center(
        //         child: Icon(
        //           icon,
        //           color: CColors.black,
        //           size: 20,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SizedBox(
        //       width: 70,
        //       child: Text(
        //         label,
        //         maxLines: 2,
        //         overflow: TextOverflow.ellipsis,
        //         softWrap: true,
        //         textAlign: TextAlign.center,
        //         style: const TextStyle(
        //           color: Colors.black,
        //           fontSize: 10,
        //           fontWeight: FontWeight.bold,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //     ),
        //     Container(
        //       width: 7,
        //       height: 7,
        //       margin: const EdgeInsets.only(left: 3),
        //       decoration: BoxDecoration(
        //         color: status ? Colors.green : Colors.red,
        //         borderRadius: BorderRadius.circular(7),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
