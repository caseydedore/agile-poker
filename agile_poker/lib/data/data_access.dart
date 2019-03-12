import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataAccess {
  static Database _data;
  Future<Database> get database async => _data ?? await _createDatabase();

  Future<Database> _createDatabase() async {
    final location = await getDatabasesPath();
    final name = 'agile_poker.db';
    final file = join(location, name);
    final database = await openDatabase(file);
    return database;
  }
}