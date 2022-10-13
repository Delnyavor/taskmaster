import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required String name,
    required int duration,
    required String description,
    int? id,
    bool? isCompleted,
    bool? isInSession,
  }) : super(
          name: name,
          duration: duration,
          description: description,
          id: id,
          isCompleted: isCompleted,
          isInSession: isInSession,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        name: json['name'],
        duration: (json['duration'] as num).toInt(),
        description: json['description'],
        id: json['id'],
        isCompleted: json['isCompleted'],
        isInSession: json['isInSession']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'duration': duration,
      'description': description,
      'id': id,
      'isCompleted': isCompleted,
      'isInSession': isInSession
    };
  }
}
