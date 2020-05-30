import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // making it a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static final _dbName = 'Data.db';
  static final _dbVersion = 1;
  static final _tableName = 'Lists';
  static final _tablePerson = 'Person';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnlandmark = 'landmark';
  static final columnface = 'face';
  static final columnemail = 'email';
  static final columnlistid = 'list_ID';

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL )
      ''');

    db.execute('''
    CREATE TABLE $_tablePerson (
    $columnId INTEGER PRIMARY KEY,
    $columnName TEXT NOT NULL,
    $columnface TEXT,
    $columnlandmark  TEXT,
    $columnlistid  INTEGER,
    FOREIGN KEY ($columnlistid) REFERENCES $_tableName($columnId)
    )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  /*
    db.execute('''
    CREATE TABLE $group (
    $columnId INTEGER PRIMARY KEY,
    $columnName TEXT NOT NULL,
    $columnface Text,
    $columnlandmark
    )
    ''');//TODO: landmark type ???
    //array [1..132] {dx : float , dy: float}
    * */
// Lists table function
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return db.update(_tableName, row, where: '$columnId = ? ', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return db.delete(_tableName, where: '$columnId = ? ', whereArgs: [id]);
  }

  // Person table function
  Future<List<Map<String, dynamic>>> PqueryAll() async {
    Database db = await instance.database;
    return await db.query(_tablePerson);
  }

  Future<List<Map<String, dynamic>>> PGqueryAll(int list_id) async {
    Database db = await instance.database;
    return await db
        .query(_tablePerson, where: '$columnlistid = ?', whereArgs: [list_id]);
  }
  Future<int> Pinsert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tablePerson, row);
  }

  Future<int> Pupdate(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return db.update(_tablePerson, row, where: '$columnId = ? ', whereArgs: [id]);
  }

  Future<int> Pdelete(int id) async {
    Database db = await instance.database;
    return db.delete(_tablePerson, where: '$columnId = ? ', whereArgs: [id]);
  }
}
