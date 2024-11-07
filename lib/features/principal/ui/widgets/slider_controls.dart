import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimbuz_arm_robotic/core/robot_arm/models/robot_event.dart';
import 'package:nimbuz_arm_robotic/core/utils/debouncer.dart';
import 'package:nimbuz_arm_robotic/features/principal/blocs/principal/principal_bloc.dart';
import 'package:nimbuz_arm_robotic/features/principal/blocs/sliders/slider_controls_bloc.dart';
import 'package:nimbuz_arm_robotic/features/principal/ui/widgets/widgets.dart';
import 'package:nimbuz_arm_robotic/shared/utils/utils.dart';
import 'package:nimbuz_arm_robotic/shared/widgets/widgets.dart';

class SliderCtrls extends StatelessWidget {
  const SliderCtrls({
    super.key,
    required this.debouncer,
  });

  final Debouncer debouncer;

  Future<void> onSendCommand(BuildContext context,
      {required Command command,
      required double val,
      double maxVal = 180}) async {
    if (context.mounted) {
      late int newVal;
      newVal = mapValue(val, 0, 1, 0, maxVal);
      final robotEvent = RobotEvent(command: command, value: newVal);
      context.read<SliderControlsBloc>().add(SendValueEv(robotEvent));
      debouncer.run(
        () {
          context.read<PrincipalBloc>().add(SendCommandEv(robotEvent));
        },
      );
    }
  }

  int mapValue(double value, double fromSource, double toSource,
      double fromTarget, double toTarget) {
    return ((value - fromSource) /
                (toSource - fromSource) *
                (toTarget - fromTarget) +
            fromTarget)
        .round();
  }

  double mapAngleToValue({
    required int angle,
    int maxValue = 180,
  }) {
    // Asegúrate de que el ángulo esté dentro del rango esperado (0-180)
    if (angle < 0 || angle > maxValue) {
      throw RangeError('Angle must be between 0 and $maxValue');
    }

    // Mapea el ángulo al rango 0-1
    double mappedValue = angle / maxValue;
    return mappedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: BlocBuilder<SliderControlsBloc, SliderControlsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VerticalSpace.lg,
                const TopPanelCtrls(),
                VerticalSpace.xl,
                VerticalSpace.md,
                _SliderRobot(
                  text: 'Gripper',
                  unit: '°',
                  val: mapAngleToValue(
                      angle: state.gripperValue.value, maxValue: 90),
                  max: 90,
                  onChanged: (val) {
                    onSendCommand(context,
                        command: Command.gripper, val: val, maxVal: 90);
                  },
                ),
                _SliderRobot(
                  text: 'Wrist Pitch',
                  unit: '°',
                  val: mapAngleToValue(angle: state.wristPitchValue.value),
                  onChanged: (val) {
                    onSendCommand(
                      context,
                      command: Command.wristPitch,
                      val: val,
                    );
                  },
                ),
                _SliderRobot(
                  text: 'Wrist Roll',
                  unit: '°',
                  val: mapAngleToValue(angle: state.wristRollValue.value),
                  onChanged: (val) {
                    onSendCommand(
                      context,
                      command: Command.wristRoll,
                      val: val,
                    );
                  },
                ),
                _SliderRobot(
                  text: 'Elbow',
                  unit: '°',
                  val: mapAngleToValue(angle: state.elbowValue.value),
                  onChanged: (val) {
                    onSendCommand(
                      context,
                      command: Command.elbow,
                      val: val,
                    );
                  },
                ),
                _SliderRobot(
                  text: 'Shoulder',
                  unit: '°',
                  val: mapAngleToValue(angle: state.shoulderValue.value),
                  onChanged: (val) {
                    onSendCommand(
                      context,
                      command: Command.shoulder,
                      val: val,
                    );
                  },
                ),
                _SliderRobot(
                  text: 'Waist',
                  unit: '°',
                  val: mapAngleToValue(angle: state.waistValue.value),
                  onChanged: (val) {
                    onSendCommand(
                      context,
                      command: Command.waist,
                      val: val,
                    );
                  },
                ),
                // _SliderRobot(
                //   text: 'Speed',
                //   unit: 'ms',
                //   min: 100,
                //   max: 2000,
                //   onChanged: (val) {
                //     // onSendCommand(
                //     //   context,
                //     //   command: Command.speed,
                //     //   val: val,
                //     // );
                //   },
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SliderRobot extends StatelessWidget {
  const _SliderRobot({
    this.onChanged,
    required this.val,
    required this.text,
    required this.unit,
    this.max = 180,
    this.min = 0,
  });
  final void Function(double)? onChanged;
  final String text;
  final String unit;
  final double min;
  final double val;
  final double max;

//   @override
//   State<_SliderRobot> createState() => _SliderRobotState();
// }

// class _SliderRobotState extends State<_SliderRobot> {
//   // double valDefault = 0.0;
//   int valLabel = 0;

  @override
  Widget build(BuildContext context) {
    final newVal = double.tryParse(
          val.toStringAsFixed(2),
        ) ??
        0.0;
    final valDisplay = mapValue(newVal, 0.0, 1.0, min, max);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _BtnIcon(
                icon: Icons.remove,
                onTap: val == 0.0
                    ? null
                    : () {
                        onChanged?.call(val == 0.0 ? val : val - .01);
                      },
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    trackShape: const RectangularSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbColor: Colors.white,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    overlayColor: CColors.secondaryColor.withOpacity(.25),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 15.0),
                  ),
                  child:
                      // CupertinoSlider().
                      Slider(
                    value: val,
                    inactiveColor: Colors.white.withOpacity(.35),
                    // activeColor: Colors.white,
                    onChanged: (val) {
                      onChanged?.call(val);
                    },
                  ),
                ),
              ),
              _BtnIcon(
                icon: Icons.add,

                // icon: Icons.arrow_forward_ios,
                onTap: newVal == 1.0
                    ? null
                    : () {
                        onChanged?.call(newVal == 1.0 || newVal == 0.99
                            ? 1.0
                            : newVal + .01);
                      },
              ),
              HorizontalSpace.xxl,
              Label(
                '$valDisplay $unit',
                type: LabelType.title,
                textAlign: TextAlign.end,
                color: CColors.black,
              ),
              HorizontalSpace.lg,
            ],
          ),
        ],
      ),
    );
  }

  int mapValue(double value, double fromSource, double toSource,
      double fromTarget, double toTarget) {
    return ((value - fromSource) /
                (toSource - fromSource) *
                (toTarget - fromTarget) +
            fromTarget)
        .round();
  }
}

class _BtnIcon extends StatelessWidget {
  const _BtnIcon({
    required this.icon,
    this.onTap,
  });

  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(8),
          color: Colors.white.withOpacity(.25),
          border: Border.all(
            color: Colors.white,
            width: 0.4,
          ),
        ),
        // decoration: const BoxDecoration(
        //   shape: BoxShape.circle,
        // ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 16,
          color: CColors.black,
          //  onTap == null ? Colors.white.withOpacity(.2) : null,
        ),
      ),
    );
  }
}
