import 'package:agile_poker/data/data_access.dart';
import 'package:agile_poker/data/model/agile_card.dart';
import 'package:sqflite/sqflite.dart';

class AgileCardData {
  static const _table = 'agile_card';
  static const _id = 'id';
  static const _symbol = 'symbol';
  static const _image = 'image';
  final _dataAccess = DataAccess();

  Future<List<AgileCard>> getAgileCards () async {
    final db = await _dataAccess.database;
    await _createTestDataIfEmpty();
    final result = await db.rawQuery('SELECT * from $_table');
    final cards = result.map((item) =>
      AgileCard.asNew(id: item[_id], number: item[_symbol], image: item[_image])
    ).toList();
    return cards;
  }

  Future<AgileCard> addAgileCard (AgileCard card) async {
    final db = await _dataAccess.database;
    final id = await db.rawInsert(
      'INSERT into $_table ($_symbol, $_image) values (?,?)',
      [card.number, card.image]
    );
    return new AgileCard.asNew(id: id, number: card.number, image: card.image);
  }

  Future updateAgileCard (AgileCard card) async {
    final db = await _dataAccess.database;
    return await db.rawUpdate(
      'UPDATE $_table set $_symbol = ?, $_image = ? where $_id == ?',
      [card.number, card.image, card.id]
    );
  }

  Future removeAgileCard (AgileCard card) async {
    final db = await _dataAccess.database;
    return await db.rawDelete('DELETE from $_table WHERE $_id = ?', [card.id]);
  }

  Future _createTestDataIfEmpty () async {
    final db = await _dataAccess.database;
    final result =
      await db.rawQuery('SELECT COUNT(*) FROM sqlite_master WHERE type="table" AND name="$_table"');
    final doesTestDataExist = Sqflite.firstIntValue(result) > 0;
    if (!doesTestDataExist) {
      await _createTable();
      await _createTestData();
    }
  }

  Future _createTable () async {
    final db = await _dataAccess.database;
    return await
      db.execute('CREATE TABLE $_table ($_id INTEGER PRIMARY KEY, $_symbol INT, $_image TEXT)');
  }

  Future _createTestData () async {
    final cards = [
      AgileCard.asNew(id: 0, number: 0, image: 'https://i0.kym-cdn.com/entries/icons/original/000/000/091/TrollFace.jpg'),
      AgileCard.asNew(id: 0, number: 1, image: 'http://i0.kym-cdn.com/entries/icons/mobile/000/002/252/NoMeGusta.jpg'),
      AgileCard.asNew(id: 0, number: 2),
      AgileCard.asNew(id: 0, number: 4),
      AgileCard.asNew(id: 0, number: 8, image: 'https://appstickers-cdn.appadvice.com/1126326196/817857734/8c9ac93facc4d5bc6cee7a0cc7b37013-2.png'),
      AgileCard.asNew(id: 0, number: 16),
      AgileCard.asNew(id: 0, number: 32, image: 'http://i0.kym-cdn.com/entries/icons/mobile/000/002/252/NoMeGusta.jpg'),
      AgileCard.asNew(id: 0, number: 64, image: 'https://appstickers-cdn.appadvice.com/1126326196/817857734/8c9ac93facc4d5bc6cee7a0cc7b37013-2.png'),
    ];
    final data = AgileCardData();
    final pendingAdditions = cards.map((item) async => data.addAgileCard(item));
    return Future.wait(pendingAdditions);
  }
}