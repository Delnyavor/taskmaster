import 'package:dartz/dartz.dart' as dartz;
import 'package:taskmaster/features/tasks/data/repositories/task_repository.dart';
// import 'package:taskmaster/features/tasks/domain/repository/task_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

class GetTask {
  final TaskRepositoryImpl repository;

  GetTask(this.repository);

  Future<dartz.Either<Failure, Task?>?>? execute(int id) async {
    return await repository.getTask(id);
  }
}
