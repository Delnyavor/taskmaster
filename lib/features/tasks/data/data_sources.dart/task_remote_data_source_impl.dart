import 'package:taskmaster/features/tasks/data/data_sources.dart/task_remote_data_source.dart';
import 'package:taskmaster/features/tasks/domain/entities/task.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
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
  Future<Task?>? getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<Task?>? updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
