import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  //Make the class a singleton to ensure only one instance appwide
  // How is the singleton used??
  DatabaseHelper._instance(); // Is the constructor

  static final tasksTable = 'tasks_table';
  static final colId = 'id';
  static final colTitle = 'title';
  static final colDescription = 'description';

  // Step 1: Get the db | Only make db if there is none
  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  // Step 2: Initializes the db and where the db will be stored on the phone
  Future<Database> _initDb() async {
    //Step 2a: Get directory path
    Directory dir = await getApplicationDocumentsDirectory();
    //Step 2b: Create the db in the path above
    String path = dir.path + 'todo_notepad.db';

    // Step 2c: Open the database for writing into it
    // Version: is for keeping track of our db changes as the app's complexity increases
    // onCreate: After creating the db, we need to create a table into it for storing data
    final todoNotepadDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoNotepadDb;
  }

  //Step 3: Open and create table columns needed for step 2 above
  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tasksTable(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT,
        $colDescription TEXT)
        ''');
  }

  // Insert task into db
  Future<int> insertTask(Map<String, dynamic> row) async {
    Database db = await this.db;
    final int result = await db.insert(tasksTable, row);
    return result; // returns inserted id
  }

  //Return all tasks from the db
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await this.db;
    return await db.query(tasksTable); // returns the list of tasks in the table
  }

  // update task into db
  Future<int> updateTask(Map<String, dynamic> row) async {
    Database db = await this.db;
    int id = row['colId'];
    final int result =
        await db.update(tasksTable, row, where: '$colId=?', whereArgs: [id]);
    return result; //return the rows affected
  }

  // delete task into db
  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result =
        await db.delete(tasksTable, where: '$colId=?', whereArgs: [id]);
    return result; //return the rows affected
  }
}
