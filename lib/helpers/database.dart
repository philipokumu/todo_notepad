import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_notepad/models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  //Make the class a singleton to ensure only one instance appwide
  DatabaseHelper._instance();

  String tasksTable = 'tasks_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colStatus = 'Status';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_notepad.db';
    final todoNotepadDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoNotepadDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tasksTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT $colDescription TEXT $colStatus INTEGER)');
  }

  //Query function, for interacting with db
  Future<List<Map<String, dynamic>>> getTaskMapList() async {
     Database db = await this.db;
     final List<Map<String, dynamic>>> result = db.query(tasksTable);
    return result;
  }

// Retrieve from db
  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap)) {
      taskList.add(Task.fromMap(taskMap));
    }

    return taskList;
  }

// Insert into db
  Future <int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(tasksTable,task.toMap());
    return result;
  }

//Update db
  Future <int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(tasksTable,task.toMap(),where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

// Delete from db
  Future <int> deleteTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(tasksTable,task.toMap(),where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }
}
