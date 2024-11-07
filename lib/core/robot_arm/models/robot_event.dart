import 'package:equatable/equatable.dart';

enum Command {
  none('n'),
  gripper('g'),
  wristPitch('p'),
  wristRoll('o'),
  elbow('e'),
  shoulder('s'),
  waist('w'),
  stop('t'),
  save('s'),
  play('p'),
  reset('r');

  const Command(this.val);

  final String val;

  static Command getCommand(String part) => switch (part) {
        ('gripper') => Command.gripper,
        ('wristPitch') => Command.wristPitch,
        ('wristRoll') => Command.wristRoll,
        ('elbow') => Command.elbow,
        ('shoulder') => Command.shoulder,
        ('waist') => Command.waist,
        ('play') => Command.play,
        ('save') => Command.save,
        ('stop') => Command.stop,
        ('reset') => Command.reset,
        (_) => Command.none,
      };
}

class RobotEvent extends Equatable {
  const RobotEvent({
    required this.command,
    required this.value,
  });

  final Command command;
  final int value;

  factory RobotEvent.fromJson(Map<String, dynamic> json) {
    return RobotEvent(
      command: Command.getCommand(json['command']),
      value: json['value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'command': command.name,
      'value': value,
    };
  }

  @override
  List<Object> get props => [
        command,
        value,
      ];
}
