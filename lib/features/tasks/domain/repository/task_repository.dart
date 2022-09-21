import 'package:dartz/dartz.dart' as dartz;
import 'package:taskmaster/core/error/failures.dart';

import '../entities/task.dart';

abstract class TaskRepository {
  Future<dartz.Either<Failure, List<Task?>?>>? getAllTasks();
  Future<dartz.Either<Failure, Task?>>? createTask(Task task);
  Future<dartz.Either<Failure, Task?>>? getTask(int id);
  Future<dartz.Either<Failure, Task?>>? updateTask(Task task);
  Future<dartz.Either<Failure, bool?>>? deleteTask(int id);
}
