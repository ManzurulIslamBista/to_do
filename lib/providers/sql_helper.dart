import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLProvider extends ChangeNotifier {
  late Database database; // Declaring database globally

  SQLProvider(){
    initDatabase();
  }

  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "uptodo");

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE users(id INTEGER PRIMARY KEY, uname TEXT, password TEXT)');
        });
  }


  //this is for register user
  Future<void> insertValueAtDatabase(
      {required String tableName, required String uname, required String password}) async {
    print("Register clicked");
    await database.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO $tableName(uname, password) VALUES(?, ?)',
          [uname, password]);
      print('inserted: $uname');
    });
    notifyListeners();
  }


  //this part is for login user
  Future<bool> loginUser({required String uname, required String password}) async {
    List<Map<String, dynamic>> result = await database.rawQuery(
        'SELECT * FROM users WHERE uname = ? AND password = ?',
        [uname, password]);
    return result.isNotEmpty; // If result is not empty, login is successful
  }
}
