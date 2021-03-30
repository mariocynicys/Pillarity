import 'dart:async';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String _dbName = "Medical.db";

  // DataBase Of Medicines
  final String medicinesTable = "Medicines";
  final String medicineID = "ID";
  final String medicineName = "Name";


  // DataBase Of Search History
  final String SearchHistoryTable = "SearchHistory";
  final String SearchHistoryText = "Search";

  // DataBase Of Messages
  final String MessagesTable  = "SearchHistory";
  final String OtherUserID = "UserID";
  final String PostID = "PostID";

  static DataBaseHelper _dataBaseHelper;

  static Database _database;

  DataBaseHelper._createInstance();

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
        CREATE TABLE $medicinesTable (
        $medicineID INTEGER PRIMARY KEY AUTOINCREMENT,
        $medicineName TEXT,
        ''');

    await db.execute('''
        CREATE TABLE $SearchHistoryTable (
        $SearchHistoryText TEXT,
        ''');

    await db.execute('''
        CREATE TABLE $MessagesTable (
        $OtherUserID TEXT,
        $PostID TEXT,
        ''');



  }


  Future<int> insertIntoHistory(Map<String, dynamic> row) async {
    Database db = await this.database;
    return await db.insert(medicinesTable, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    // Database db = await this.database;
    // int index = row["$columIndex"];
    // return await db
    //     .update(_tableName, row, where: '$columIndex = ?', whereArgs: [index]);
  }

  FutureOr<List<Map<String, dynamic>>> GetAllMedicne() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list = await db.query(medicinesTable);

    return list;
  }
}