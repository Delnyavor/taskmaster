import 'package:taskmaster/core/error/exceptions.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';
import 'package:taskmaster/core/error/failures.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:taskmaster/features/tasks/domain/repository/task_repository.dart';

import '../../../../core/network/network_info.dart';
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
  Future<dartz.Either<Failure, Task?>>? createTask(Task task) async {
    if (await networkInfo.isConnected!) {
      try {
        final localResult = await localDataSource.cacheTask(task);

        await remoteDataSource.createTask(localResult as Task);
        return dartz.Right(localResult);
      } on ServerException catch (_) {
        return const dartz.Left(ServerFailure());
      } on CacheException catch (_) {
        return const dartz.Left(CacheFailure());
      }
    } else {
      try {
        final localResult = await localDataSource.cacheTask(task);
        return dartz.Right(localResult);
      } on CacheException catch (_) {
        return const dartz.Left(CacheFailure());
      }
    }
  }

  @override
  Future<dartz.Either<Failure, List<Task?>?>>? getAllTasks() async {
    if (await networkInfo.isConnected!) {
      try {
        final result = await remoteDataSource.getAllTasks();

        //TODO: spawn isolatess to cache individual data
        // await localDataSource.cacheTask(result);

        return dartz.Right(result);
      } on ServerException catch (_) {
        return const dartz.Left(ServerFailure());
      }
    } else {
      try {
        return dartz.Right(await localDataSource.getAllTasks());
      } on CacheException catch (_) {
        return const dartz.Left(CacheFailure());
      }
    }
  }

  @override
  Future<dartz.Either<Failure, Task?>>? getTask(int id) async {
    if (await networkInfo.isConnected!) {
      try {
        final result = await remoteDataSource.getTask(id);
        await localDataSource.cacheTask(result);
        return dartz.Right(result);
      } on ServerException catch (_) {
        return const dartz.Left(ServerFailure());
      }
    } else {
      try {
        return dartz.Right(await localDataSource.getTask(id));
      } on CacheException catch (_) {
        return const dartz.Left(CacheFailure());
      }
    }
  }

  @override
  Future<dartz.Either<Failure, Task?>>? updateTask(Task task) async {
    if (await networkInfo.isConnected!) {
      try {
        final result = await remoteDataSource.updateTask(task);
        await localDataSource.updateTask(task);
        return dartz.Right(result);
      } on ServerException catch (_) {
        return const dartz.Left(ServerFailure());
      } on CacheException catch (_) {
        return const dartz.Left(CacheFailure());
      }
    } else {
      try {
        final localResult = await localDataSource.cacheTask(task);
        return dartz.Right(localResult);
      } on CacheException catch (_) {
        return const dartz.Left(CacheFailure());
      }
    }
  }

  @override
  Future<dartz.Either<Failure, bool?>>? deleteTask(int id) async {
    if (await networkInfo.isConnected!) {
      try {
        //TODO: what should the deletion success payload be?
        await remoteDataSource.deleteTask(id);
        final remoteCheck = await remoteDataSource.getTask(id);

        await localDataSource.deleteCachedTask(id);
        final localCheck = await localDataSource.getTask(id);

        return dartz.Right(remoteCheck == null && localCheck == null);
      } on ServerException {
        return const dartz.Left(ServerFailure());
      } on CacheException {
        return const dartz.Left(CacheFailure());
      }
    } else {
      return const dartz.Left(
          ServerFailure(message: "Could not connect to the internet"));
    }
  }
}
