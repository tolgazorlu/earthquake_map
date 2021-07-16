import 'package:earthquake_map/core/models/earthquakeModel.dart';

import 'package:sqflite/sqflite.dart';

class SQliteService {
  String _databaseName = "depremDB";
  String tableName = "depremler";
  int _version = 1;
  Database database;

  String _columnID = "id";
  String _columnTitle = "title";
  String _columnDescription = "description";
  String _columnLink = "link";
  String _columnPubDate = "pubdate";

  Future<void> open() async {
    database = await openDatabase(_databaseName, version: _version,
        onCreate: (db, version) {
      db.execute('''CREATE TABLE $tableName (
            $_columnID Integer PRIMARY KEY AUTOINCREMENT,
            $_columnTitle VARCHAR(250),
            $_columnDescription VARCHAR(250),
            $_columnLink VARCHAR(25),
            $_columnPubDate VARCHAR(250))''');
    });
  }

  Future<List<EQModel>> getList() async {
    if (database == null) await open();
    List<Map> value = [];
    try {
      value = await database.query(tableName);
    } catch (e) {
      print("HATA" + e.toString());
    }
    return value.map((e) => EQModel.fromJson(e)).toList();
  }

  Future<int> insertItem(EQModel model) async {
    if (database == null) await open();
    final value = await database.insert(
      tableName,
      model.toJson(),
    );

    return value;
  }

  Future<bool> deleteItem(int id) async {
    if (database == null) await open();
    final value =
        database.delete(tableName, where: '$_columnID = ?', whereArgs: [id]);
    return value != null;
  }
}
