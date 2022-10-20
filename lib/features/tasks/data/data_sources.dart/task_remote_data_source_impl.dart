import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:taskmaster/core/error/exceptions.dart';
import 'dart:convert';
import 'package:taskmaster/features/tasks/data/data_sources.dart/task_remote_data_source.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';

import '../models/task_model.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final http.Client httpClient;

  TaskRemoteDataSourceImpl({required this.httpClient});
  @override
  Future<Task?>? createTask(Task task) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<bool?>? deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task?>?>? getAllTasks() {
    // TODO: implement getAllTasks
    throw UnimplementedError();
  }

  @override
  Future<Task?>? getTask(int id) async {
    try {
      http.Response response = await httpClient.get(
          Uri.parse('www.example.com/$id'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return TaskModel.fromJson(data);
      } else {
        throw ServerException();
      }
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<Task?>? updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
