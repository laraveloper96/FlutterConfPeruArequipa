part of 'principal_bloc.dart';

sealed class PrincipalEvent extends Equatable {
  const PrincipalEvent();

  @override
  List<Object> get props => [];
}

final class InitEv extends PrincipalEvent {}

class AddRobotEv extends PrincipalEvent {
  const AddRobotEv(this.robot);

  final Robot robot;

  @override
  List<Object> get props => [robot];
}

class EnableRobotEv extends PrincipalEvent {
  const EnableRobotEv(this.robot);

  final Robot robot;

  @override
  List<Object> get props => [robot];
}

class SendCommandEv extends PrincipalEvent {
  const SendCommandEv(this.robotEvent);

  final RobotEvent robotEvent;

  @override
  List<Object> get props => [robotEvent];
}

class SaveMovesEv extends PrincipalEvent {
  const SaveMovesEv(this.robotEvents);

  final List<RobotEvent> robotEvents;

  @override
  List<Object> get props => [robotEvents];
}

class PlayMovesEv extends PrincipalEvent {
  const PlayMovesEv();

  @override
  List<Object> get props => [];
}

class ExportMovesEv extends PrincipalEvent {
  const ExportMovesEv();

  @override
  List<Object> get props => [];
}

class ImportMovesEv extends PrincipalEvent {
  const ImportMovesEv();

  @override
  List<Object> get props => [];
}

class ResetMovesEv extends PrincipalEvent {
  const ResetMovesEv();

  @override
  List<Object> get props => [];
}
