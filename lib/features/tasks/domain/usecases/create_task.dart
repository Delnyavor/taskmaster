import 'package:dartz/dartz.dart' as dartz;
import 'package:taskmaster/features/tasks/domain/repository/task_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<dartz.Either<Failure, Task>> execute(Task task) async {
    return await repository.createTask(task);
  }
}
