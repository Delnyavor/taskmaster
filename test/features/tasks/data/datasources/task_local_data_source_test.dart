import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taskmaster/features/tasks/data/data_sources.dart/task_local_data_source_impl.dart';
import 'package:taskmaster/features/tasks/data/database/database_helper.dart';
import 'package:taskmaster/features/tasks/data/models/task_model.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDBHelper extends Mock implements DBHelper {}

void main() {
  MockDBHelper dbHelper = MockDBHelper();
  TaskLocalDataSourceImpl localDataSourceImpl =
      TaskLocalDataSourceImpl(helper: dbHelper);

  const int id = 1;

  const taskModel =
      TaskModel(name: 'name', duration: 55, description: "description");

  const Task task = taskModel;

  final json = readFixture('task.json');

  test('should return data when task has been written to database successfully',
      () async {
    when(dbHelper.insert(task as TaskModel))
        .thenAnswer((realInvocation) async => taskModel);

    final result = await localDataSourceImpl.cacheTask(task);

    verify(dbHelper.insert(task));
    expect(taskModel, result);
  });
}
