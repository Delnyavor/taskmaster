import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

import 'package:flutter/widgets.dart';

import '../../domain/entities/task.dart';
import '../models/task_model.dart';

class DBHelper {
  static const _databaseName = "tasks_database.db";
  static const _databaseVersion = 1;
  static const _tableName = 'tasks';
  static const _columnId = 'id';
  static const _columnName = 'name';
  static const _columnDescription = 'description';
  static const _columnDuration = 'duration';

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: _onCreate,
      version: _databaseVersion,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Database is created, create the _table
    await db.execute(
        "CREATE _TABLE $_tableName ($_columnId INTEGER PRIMARY KEY, $_columnName TEXT, $_columnDescription TEXT, $_columnDuration INTEGER)");
  }

  Future<TaskModel?>? insert(TaskModel task) async {
    int result = await _database!.insert(_tableName, task.toJson());
    if (result == 1) {
      return task;
    }
    return null;
  }

  Future<TaskModel?> getTask(int id) async {
    List<Map> maps = await _database!.query(_tableName,
        columns: [_columnId, _columnName, _columnDescription, _columnDuration],
        where: '$_columnId = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TaskModel.fromJson(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await _database!
        .delete(_tableName, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future<TaskModel?> update(TaskModel task) async {
    int result = await _database!.update(_tableName, task.toJson(),
        where: '$_columnId = ?', whereArgs: [task.id]);

    if (result == 1) {
      return task;
    }
    return null;
  }

  Future close() async => _database!.close();

  Future show_tables(Database db) async {
    List<Map<String, dynamic>> _tables =
        await db.rawQuery('''SELECT name FROM sqlite_master
      WHERE type = '_table'
      ''');

    for (var _table in _tables) {
      // print(_table);
    }
  }
}
