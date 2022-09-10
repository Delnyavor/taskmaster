import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:taskmaster/features/tasks/data/models/task_model.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const taskModel =
      TaskModel(name: 'name', duration: 55, description: "description");

  test('should be a subclass of Task Entity', () {
    expect(taskModel, isA<Task>());
  });

  group('fromJson', () {
    test('should return valid model when duration is an integer', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('task.json'));

      final result = TaskModel.fromJson(jsonMap);

      expect(result, taskModel);
    });

    test('should return valid model when duration is a double', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('task_double.json'));

      final result = TaskModel.fromJson(jsonMap);

      expect(result, taskModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = taskModel.toJson();
      final expectedResult = {
        "name": "name",
        "duration": 55,
        "description": "description"
      };
      expect(result, expectedResult);
    });
  });
}
