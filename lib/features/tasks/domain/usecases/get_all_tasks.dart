import 'package:dartz/dartz.dart' as dartz;
import 'package:taskmaster/features/tasks/domain/repository/task_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

class GetAllTasks {
  final TaskRepository repository;

  GetAllTasks(this.repository);

  Future<dartz.Either<Failure, List<Task?>?>?>? execute() async {
    return await repository.getAllTasks();
  }
}
