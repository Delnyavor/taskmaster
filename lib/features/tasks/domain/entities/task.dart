import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String name;
  final Duration duration;
  final String description;
  final bool? isCompleted;
  final bool? isInSession;

  const Task({
    required this.name,
    required this.duration,
    required this.description,
    this.isCompleted,
    this.isInSession,
  });

  @override
  List<Object?> get props => [name, duration, description];
}
