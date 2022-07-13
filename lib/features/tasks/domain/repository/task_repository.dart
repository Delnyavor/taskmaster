import 'package:dartz/dartz.dart';
import 'package:taskmaster/core/failures.dart';

abstract class TaskRepository {
  Future<Either<Failure, Task>> getAllTasks(task) {
    return task;
  }

  Future<Either<Failure, Task>> deleteTask(task) {
    return task;
  }
}
