import 'package:agile_poker/data/data_access.dart';
import 'package:agile_poker/data/model/agile_card.dart';
import 'package:sqflite/sqflite.dart';

class AgileCardData {
  static const _table = 'agile_card';
  static const _id = 'id';
  static const _number = 'number';
  final _dataAccess = DataAccess();

  Future<List<AgileCard>> getAgileCards () async {
    final db = await _dataAccess.database;
    await _createTestDataIfEmpty();
    final result = await db.rawQuery('SELECT * from $_table');
    final cards = result.map((item) {
      return AgileCard(item[_id], item[_number]);
    }).toList();
    return cards;
  }

  Future addAgileCard (AgileCard card) async {
    final db = await _dataAccess.database;
    return await db.rawInsert('INSERT into $_table ($_number) values (?)', [card.number]);
  }

  Future updateAgileCard (AgileCard card) async {
    final db = await _dataAccess.database;
    return await db.rawUpdate('UPDATE $_table set $_number = ? where $_id == ?', [card.number, card.id]);
  }

  Future removeAgileCard (AgileCard card) async {
    final db = await _dataAccess.database;
    return await db.rawDelete('DELETE from $_table WHERE $_id = ?', [0]);
  }

  Future _createTestDataIfEmpty () async {
    final db = await _dataAccess.database;
    final result =
      await
        db.rawQuery('SELECT COUNT(*) FROM sqlite_master WHERE type="table" AND name="$_table"');
    final doesTestDataExist = Sqflite.firstIntValue(result) > 0;
    if (!doesTestDataExist) {
      await _createTable();
      await _createTestData();
    }
  }

  Future _createTable () async {
    final db = await _dataAccess.database;
    return await
      db.execute('CREATE TABLE $_table ($_id INTEGER PRIMARY KEY, $_number INT)');
  }

  Future _createTestData () async {
    final cards = [
      AgileCard(0, 0),
      AgileCard(0, 1),
      AgileCard(0, 2),
      AgileCard(0, 4),
      AgileCard(0, 8),
      AgileCard(0, 16),
      AgileCard(0, 32),
      AgileCard(0, 64),
    ];
    final data = AgileCardData();
    final pendingAdditions = cards.map((item) async => data.addAgileCard(item));
    return Future.wait(pendingAdditions);
  }
}