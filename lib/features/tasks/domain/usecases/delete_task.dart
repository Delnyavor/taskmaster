import 'package:dartz/dartz.dart' as dartz;
import 'package:taskmaster/features/tasks/domain/repository/task_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<dartz.Either<Failure, bool?>?>? execute(int id) async {
    return await repository.deleteTask(id);
  }
}
