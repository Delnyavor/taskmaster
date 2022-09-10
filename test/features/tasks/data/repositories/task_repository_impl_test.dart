import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmaster/core/error/exceptions.dart';
import 'package:taskmaster/core/error/failures.dart';
import 'package:taskmaster/core/platform/network_info.dart';
import 'package:taskmaster/features/tasks/data/data_sources.dart/task_local_data_source.dart';
import 'package:taskmaster/features/tasks/data/data_sources.dart/task_remote_data_source.dart';
import 'package:taskmaster/features/tasks/data/models/task_model.dart';
import 'package:taskmaster/features/tasks/data/repositories/task_repository.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';

class MockRemoteDataSource extends Mock implements TaskRemoteDataSource {}

class MockLocalDataSource extends Mock implements TaskLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource = MockRemoteDataSource();
  late MockLocalDataSource mockLocalDataSource = MockLocalDataSource();
  late MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  late TaskRepositoryImpl repository = TaskRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  const int id = 1;

  const taskModel =
      TaskModel(name: 'name', duration: 55, description: "description");

  const Task task = taskModel;

  setUp(() {});

  void runTestsOnline(Function body) {
    group('Device is Online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('Device is Offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('get task', () {
    test('check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getTask(id);

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getTask(id))
            .thenAnswer((_) async => taskModel);

        final result = await repository.getTask(id);

        verify(mockRemoteDataSource.getTask(id));
        expect(result, equals(const dartz.Right(task)));
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getTask(id))
            .thenAnswer((realInvocation) async => taskModel);

        await repository.getTask(id);
        verify(mockRemoteDataSource.getTask(id));

        verify(mockLocalDataSource.cacheTask(task));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getTask(id)).thenThrow(ServerException());

        final result = await repository.getTask(id);

        verify(mockRemoteDataSource.getTask(id));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, const dartz.Left(ServerFailure()));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(mockLocalDataSource.getTask(id))
            .thenAnswer((_) async => taskModel);

        final result = await repository.getTask(id);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getTask(id));
        expect(result, equals(const dartz.Right(taskModel)));
      });

      test('should return Cache Failure when no cache data is present',
          () async {
        when(mockLocalDataSource.getTask(id)).thenThrow(CacheException());

        final result = await repository.getTask(id);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getTask(id));
        expect(result, equals(const dartz.Left(CacheFailure())));
      });
    });
  });
}
