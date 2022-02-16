import 'dart:async';
import 'dart:io';

import 'package:flutter_hava_durumu/model/city.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  final String _cityTablo = 'citys';
  final String _columnID = 'id';
  final String _columnCityName = 'cityName';

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'city.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_cityTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnCityName TEXT)");
  }

  Future<List<City>> getCitys() async {
    Database db = await instance.database;
    var citys = await db.query(_cityTablo, orderBy: '$_columnID DESC');
    List<City> cityList =
        citys.isNotEmpty ? citys.map((e) => City.fromMap(e)).toList() : [];
    return cityList;
  }

  Future<int> add(City city) async {
    Database db = await instance.database;
    return await db.insert(_cityTablo, city.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(_cityTablo, where: 'id = ?', whereArgs: [id]);
  }
}
