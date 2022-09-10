import 'package:taskmaster/features/tasks/data/models/task_model.dart';

import '../../domain/entities/task.dart';

abstract class TaskLocalDataSource {
  ///gets the cached [TaskModel] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<List<TaskModel>> getAllTasks();

  ///saves the [TaskModel] onto the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<TaskModel?>? cacheTask(Task? task);

  ///gets the cached [TaskModel] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<TaskModel?>? getTask(int id);

  ///modifies the cached [TaskModel] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<TaskModel> updateTask(Task task);

  ///deletes the cached [TaskModel] saved on the local device
  ///
  ///Throws [CacheException] if not data is present
  Future<TaskModel> deleteCachedTask(int id);
}
