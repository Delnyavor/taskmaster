import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String name;
  final Duration duration;
  final String description;

  const Task(
      {required this.name, required this.duration, required this.description});

  @override
  List<Object?> get props => [name, duration, description];
}
