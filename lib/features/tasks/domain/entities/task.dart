import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String name;
  final int duration;
  final String description;
  final int? id;
  final bool? isCompleted;
  final bool? isInSession;

  const Task({
    required this.name,
    required this.duration,
    required this.description,
    this.id,
    this.isCompleted,
    this.isInSession,
  });

  @override
  List<Object?> get props => [name, duration, description, id];
}
