import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutterweather/models/default_cities.dart';
import 'package:flutterweather/models/user_config.dart';
import 'package:flutterweather/utils/const.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvier {
  DBProvier._();

  static final DBProvier db = DBProvier._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "localDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE UserConfig("
          "key TEXT PRIMARY KEY,"
          "value VARCHAR(255),"
          "lastChange TEXT"
          ")");
    });
  }

  addOrUpdateDefaultCities(DefaultCities defCities) async {
    final db = await database;

    var userConf = UserConfig(
        key: DB_DEFAULT_CITIES_KEY,
        value: json.encode(defCities.toJson()),
        lastChange: DateTime.now());

    var obj = await db.query('UserConfig',
        where: 'key = ?', whereArgs: [DB_DEFAULT_CITIES_KEY]);
    Future<int> res;
    if (obj.isEmpty) 
     res = db.insert('UserConfig', userConf.toJson());
     else
     res =db.update('UserConfig', userConf.toJson());
    return res;
  }

  Future<DefaultCities> getDefaultCities() async {
    final db = await database;
    var res = await db.query('UserConfig',
        where: 'key = ?', whereArgs: [DB_DEFAULT_CITIES_KEY]);
    if (res.isEmpty) return null;
    var usrConf = UserConfig.fromJson(res.first);
    var defCities = DefaultCities().fromJson(jsonDecode(usrConf.value));
    return defCities;
  }
}
