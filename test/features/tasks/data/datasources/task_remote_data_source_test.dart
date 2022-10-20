import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:taskmaster/core/error/exceptions.dart';
import 'package:taskmaster/features/tasks/data/data_sources.dart/task_remote_data_source_impl.dart';
import 'package:taskmaster/features/tasks/data/models/task_model.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const int id = 1;
  final jsonString = readFixture('task.json');
  final taskModel = TaskModel.fromJson(jsonDecode(jsonString));
  final Task task = taskModel;

  late MockClient mockHttpClient;

  late TaskRemoteDataSourceImpl remoteDataSourceImpl;

  void setMockClient(
      {String? value, int? statusCode, Map<String, String>? headers}) {
    mockHttpClient = MockClient(
      (http.Request request) async {
        return http.Response(
          value ?? jsonString,
          statusCode ?? 200,
          headers: headers ?? {'Content-Type': 'application/json'},
        );
      },
    );
    remoteDataSourceImpl = TaskRemoteDataSourceImpl(httpClient: mockHttpClient);
  }

  setUp(() {
    setMockClient();
  });

  group('get task', () {
    test('''should perform a GET request on a url with id being the endpoint
        and with application/json header''', () async {
      await remoteDataSourceImpl.getTask(id);
    });

    test('should return task when response code is 200', () async {
      final result = await remoteDataSourceImpl.getTask(id);

      expect(result, equals(taskModel));
    });

    test('should throw a server exception when the response code is not 200',
        () async {
      setMockClient(value: 'Something whent wrong', statusCode: 404);
      final call = remoteDataSourceImpl.getTask;

      expect(() => call(id), throwsA(isA<ServerException>()));
    });
  });
}
