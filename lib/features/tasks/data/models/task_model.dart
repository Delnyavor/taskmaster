import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel(
      {required String name,
      required int duration,
      required String description})
      : super(name: name, duration: duration, description: description);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        name: json['name'],
        duration: (json['duration'] as num).toInt(),
        description: json['description']);
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'duration': duration, 'description': description};
  }
}
