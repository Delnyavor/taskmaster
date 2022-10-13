import 'package:sqflite/sqflite.dart';
import 'package:taskmaster/features/tasks/data/data_sources.dart/task_local_data_source.dart';
import 'package:taskmaster/features/tasks/data/database/database_helper.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';
import 'package:taskmaster/features/tasks/data/models/task_model.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final DBHelper helper;

  TaskLocalDataSourceImpl({required this.helper});

  @override
  Future<TaskModel?>? cacheTask(Task? task) async {
    try {
      return await helper.insert(task as TaskModel);
    } on DatabaseException {
      return null;
    }
  }

  @override
  Future<bool?>? deleteCachedTask(int id) {
    // TODO: implement deleteCachedTask
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> getAllTasks() {
    // TODO: implement getAllTasks
    throw UnimplementedError();
  }

  @override
  Future<TaskModel?>? getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<void> syncDatabase() {
    // TODO: implement syncDatabase
    throw UnimplementedError();
  }

  @override
  Future<TaskModel> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
