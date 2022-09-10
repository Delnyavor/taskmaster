import '../../domain/entities/task.dart';

abstract class TaskRemoteDataSource {
  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<List<Task?>?>? getAllTasks();

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<Task?>? createTask(Task task);

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<Task?>? getTask(int id);

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<Task?>? updateTask(Task task);

  ///Calls the [EndPoint endpoint]
  ///
  ///Throws a [ServerException] for all error codes
  Future<Task?>? deleteTask(int id);
}
