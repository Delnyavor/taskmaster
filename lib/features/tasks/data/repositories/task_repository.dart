import 'package:taskmaster/core/error/exceptions.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';
import 'package:taskmaster/core/error/failures.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:taskmaster/features/tasks/domain/repository/task_repository.dart';

import '../../../../core/platform/network_info.dart';
import '../data_sources.dart/task_local_data_source.dart';
import '../data_sources.dart/task_remote_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<dartz.Either<Failure, Task>> createTask(Task task) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<dartz.Either<Failure, Task>> deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<dartz.Either<Failure, List<Task>>> getAllTasks() {
    // TODO: implement getAllTasks
    throw UnimplementedError();
  }

  @override
  Future<dartz.Either<Failure, Task?>>? getTask(int id) async {
    if (await networkInfo.isConnected!) {
      try {
        final result = await remoteDataSource.getTask(id);
        await localDataSource.cacheTask(result);
        return dartz.Right(result);
      } on ServerException catch (e) {
        print(e);
        return const dartz.Left(ServerFailure());
      }
    } else {
      try {
        return dartz.Right(await localDataSource.getTask(id));
      } on CacheException catch (e) {
        return dartz.Left(CacheFailure());
      }
    }
  }

  @override
  Future<dartz.Either<Failure, Task>> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
