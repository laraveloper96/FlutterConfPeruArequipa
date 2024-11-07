import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nimbuz_arm_robotic/core/robot_arm/models/robot_event.dart';

part 'slider_controls_event.dart';
part 'slider_controls_state.dart';

typedef SliderControlsEmitter = Emitter<SliderControlsState>;

class SliderControlsBloc
    extends Bloc<SliderControlsEvent, SliderControlsState> {
  SliderControlsBloc() : super(const SliderControlsState.initial()) {
    // on<InitEv>(_onInitEv);
    on<SendValueEv>(_onSendValueEv);
  }

  // Future<void> _onInitEv(InitEv ev, SliderControlsEmitter emit) async {}

  Future<void> _onSendValueEv(
      SendValueEv ev, SliderControlsEmitter emit) async {
    final _ = switch (ev.robotEvent.command) {
      (Command.gripper) => emit(
          state.copyWith(gripperValue: ev.robotEvent),
        ),
      (Command.wristPitch) => emit(
          state.copyWith(wristPitchValue: ev.robotEvent),
        ),
      (Command.wristRoll) => emit(
          state.copyWith(wristRollValue: ev.robotEvent),
        ),
      (Command.elbow) => emit(
          state.copyWith(elbowValue: ev.robotEvent),
        ),
      (Command.shoulder) => emit(
          state.copyWith(shoulderValue: ev.robotEvent),
        ),
      (Command.waist) => emit(
          state.copyWith(waistValue: ev.robotEvent),
        ),
      (_) => '',
    };
  }
}
