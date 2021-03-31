import 'dart:async';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String _dbName = "Medical.db";

  // DataBase Of Medicines
  final String infoTable = "Info";
  final String ID = "ID";
  final String Name = "Name";
  final String Phone = "Phone";
  final String Loaction = "Loaction";
  final String Email = "Email";

  static DataBaseHelper _dataBaseHelper;

  static Database _database;

  DataBaseHelper._createInstance();

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDataBase();
    return _database;
  }

  _initiateDataBase() async {
    var databasesPath = await getDatabasesPath();
    var path = databasesPath + _dbName;

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $infoTable (
        $ID Integer Primary Key Autoincrement,
        $Name TEXT,
        $Phone TEXT,
        $Loaction TEXT,
        $Email TEXT
        )
        ''');
  }

  Future<int> insertIntoInfo(Map<String, dynamic> row) async {
    Database db = await this.database;
    return await db.insert(infoTable, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    // Database db = await this.database;
    // int index = row["$columIndex"];
    // return await db
    //     .update(_tableName, row, where: '$columIndex = ?', whereArgs: [index]);
  }

  FutureOr<List<Map<String, dynamic>>> GetAllInfo() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list = await db.query(infoTable);
    return list;
  }

  Future<int> delete(int id) async {
    Database db = await this.database;
    return db.delete(infoTable);
  }
}
