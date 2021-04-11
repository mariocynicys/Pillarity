import 'dart:async';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String _dbName = "Medical.db";

  // DataBase Of Medicines
  final String infoTable = "Info";
  final String UID = "UID";
  final String Name = "Name";
  final String Age = "Age";
  final String BloodType = "BloodType";
  final String Gender = "Gender";
  final String Phone = "Phone";
  final String Location = "Location";
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
        $UID TEXT,
        $Name TEXT,
        $Age TEXT,
        $BloodType TEXT,
        $Gender TEXT,
        $Phone TEXT,
        $Location TEXT,
        $Email TEXT
        )
        ''');
  }

  Future<int> insertIntoInfo(Map<String, dynamic> row) async {
    Database db = await this.database;
    return await db.insert(infoTable, row);
  }

  FutureOr<List<Map<String, dynamic>>> getInfo() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list = await db.query(infoTable);
    return list;
  }

  Future<int> deleteInfoTable() async {
    Database db = await this.database;
    return db.delete(infoTable);
  }
}
