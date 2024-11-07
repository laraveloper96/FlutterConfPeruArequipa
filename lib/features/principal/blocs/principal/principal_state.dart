part of 'principal_bloc.dart';

enum PrincipalStatus {
  initial(),
  success,
  failure,
  newAddRobot,
  changeStatusRobot,
  loading,
  loadingImport,
  successImport,
  failureImport,
  closeModal;

  bool get isInitial => this == PrincipalStatus.initial;
  bool get isSuccess => this == PrincipalStatus.success;
  bool get isNewAddRobot => this == PrincipalStatus.newAddRobot;
  bool get isChangeStatusRobot => this == PrincipalStatus.changeStatusRobot;
  bool get isFailure => this == PrincipalStatus.failure;
  bool get isLoading => this == PrincipalStatus.loading;
  bool get isLoadingImport => this == PrincipalStatus.loadingImport;
  bool get isSuccessImport => this == PrincipalStatus.successImport;
  bool get isFailureImport => this == PrincipalStatus.failureImport;
  bool get isCloseModal => this == PrincipalStatus.closeModal;
}

final class PrincipalState extends Equatable {
  const PrincipalState({
    required this.status,
    required this.robots,
    required this.moves,
    required this.message,
  });

  PrincipalState.initial()
      : this(
          status: PrincipalStatus.initial,
          moves: [],
          robots: [],
          message: '',
        );

  final PrincipalStatus status;
  final List<Robot> robots;
  final List<List<RobotEvent>> moves;
  final String message;

  @override
  List<Object> get props => [
        robots,
        moves,
        message,
      ];

  PrincipalState copyWith({
    PrincipalStatus? status,
    List<Robot>? robots,
    List<List<RobotEvent>>? moves,
    String? message,
  }) =>
      PrincipalState(
        status: status ?? this.status,
        robots: robots ?? this.robots,
        moves: moves ?? this.moves,
        message: message ?? this.message,
      );
}

// final class Initial extends PrincipalState {
//   const Initial({
//     required super.robots,
//     required super.moves,
//   });

//   @override
//   List<Object> get props => [
//         robots,
//         moves,
//       ];
// }

// class NewRobot extends PrincipalState {
//   const NewRobot({
//     required super.robots,
//     super.moves,
//   });

//   @override
//   List<Object> get props => [
//         robots,
//         moves,
//       ];
// }

// class ChangedStatusRobot extends PrincipalState {
//   const ChangedStatusRobot({
//     required super.robots,
//     required super.moves,
//     required this.message,
//   });

//   final String message;
//   @override
//   List<Object> get props => [
//         robots,
//         message,
//       ];
// }
