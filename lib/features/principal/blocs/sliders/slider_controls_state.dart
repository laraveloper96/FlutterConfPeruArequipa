part of 'slider_controls_bloc.dart';

enum SliderControlStatus {
  initial,
  add,
  reset,
  remove;

  bool get isInitial => this == SliderControlStatus.initial;
  bool get isAdd => this == SliderControlStatus.add;
  bool get isRemove => this == SliderControlStatus.remove;
  bool get isReset => this == SliderControlStatus.reset;
}

final class SliderControlsState extends Equatable {
  const SliderControlsState({
    required this.status,
    required this.gripperValue,
    required this.wristPitchValue,
    required this.wristRollValue,
    required this.elbowValue,
    required this.shoulderValue,
    required this.waistValue,
  });

  const SliderControlsState.initial()
      : this(
          status: SliderControlStatus.initial,
          gripperValue: const RobotEvent(command: Command.gripper, value: 90),
          wristPitchValue:
              const RobotEvent(command: Command.wristPitch, value: 90),
          wristRollValue:
              const RobotEvent(command: Command.wristRoll, value: 90),
          elbowValue: const RobotEvent(command: Command.elbow, value: 90),
          shoulderValue: const RobotEvent(command: Command.shoulder, value: 90),
          waistValue: const RobotEvent(command: Command.waist, value: 90),
        );

  final SliderControlStatus status;
  final RobotEvent gripperValue;
  final RobotEvent wristPitchValue;
  final RobotEvent wristRollValue;
  final RobotEvent elbowValue;
  final RobotEvent shoulderValue;
  final RobotEvent waistValue;

  @override
  List<Object> get props => [
        gripperValue,
        wristPitchValue,
        wristRollValue,
        elbowValue,
        shoulderValue,
        waistValue,
      ];

  List<RobotEvent> get currentMoves => [
        gripperValue,
        wristPitchValue,
        wristRollValue,
        elbowValue,
        shoulderValue,
        waistValue,
      ];

  SliderControlsState copyWith({
    SliderControlStatus? status,
    RobotEvent? gripperValue,
    RobotEvent? wristPitchValue,
    RobotEvent? wristRollValue,
    RobotEvent? elbowValue,
    RobotEvent? shoulderValue,
    RobotEvent? waistValue,
  }) =>
      SliderControlsState(
        status: status ?? this.status,
        gripperValue: gripperValue ?? this.gripperValue,
        wristPitchValue: wristPitchValue ?? this.wristPitchValue,
        wristRollValue: wristRollValue ?? this.wristRollValue,
        elbowValue: elbowValue ?? this.elbowValue,
        shoulderValue: shoulderValue ?? this.shoulderValue,
        waistValue: waistValue ?? this.waistValue,
      );
}
