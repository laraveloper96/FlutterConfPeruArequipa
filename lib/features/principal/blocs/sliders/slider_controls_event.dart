part of 'slider_controls_bloc.dart';

sealed class SliderControlsEvent extends Equatable {
  const SliderControlsEvent();

  @override
  List<Object> get props => [];
}

// final class InitEv extends SliderControlsEvent {}

class SendValueEv extends SliderControlsEvent {
  const SendValueEv(this.robotEvent);

  final RobotEvent robotEvent;

  @override
  List<Object> get props => [robotEvent];
}
