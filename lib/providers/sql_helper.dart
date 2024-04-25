import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do/models/category_model.dart';

class SQLProvider extends ChangeNotifier {
  late Database database;
  int loggedUserId = 0;

  SQLProvider() {
    initDatabase();
    createCategoryTable();
    createToDoTable();
    insertDefaultCategories();
  }

  Future<void> showAllTables() async {
    final db = await openDatabase('toktok.db');
    final tables =
        await db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
    print(tables);
  }

  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "toktok.db");

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY,
            uname TEXT,
            password TEXT
          )
      ''');
    });
  }

  // Future<void> createUserTable() async{
  //   final db  = await openDatabase('toktok.db');
  //   await db.execute('''
  //         CREATE TABLE users(
  //           id INTEGER PRIMARY KEY,
  //           uname TEXT,
  //           password TEXT
  //         )
  //     ''');
  // }

  Future<void> createToDoTable() async {
    final db = await openDatabase('toktok.db');
    await db.execute('''
          CREATE TABLE todorecord(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            date_time DATETIME, 
            priority TEXT,  
            categoryId INTEGER,  
            user_id INTEGER,
            FOREIGN KEY (user_id) REFERENCES users(id)
          )
      ''');
    print("created");
  }

  Future<void> createCategoryTable() async {
    final db = await openDatabase('toktok.db');
    await db.execute('''
        CREATE TABLE category(
          id INTEGER PRIMARY KEY,
          name TEXT,
          iconPath TEXT,
          color TEXT,
          user_id INTEGER,
          FOREIGN KEY (user_id) REFERENCES users(id)
        )
        ''');
    print("created category table");
  }

  //this is for register user
  Future<void> insertValueAtDatabase(
      {required String tableName,
      required String uname,
      required String password}) async {
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
  Future<bool> loginUser(
      {required String uname, required String password}) async {
    List<Map<String, dynamic>> result = await database.rawQuery(
        'SELECT * FROM users WHERE uname = ? AND password = ?',
        [uname, password]);
    if (result.isNotEmpty) {
      loggedUserId = result.first['id'];
      insertDefaultCategories();
      return true;
    }
    return false;
  }

  //this part is for todorecord
  Future<void> insertTodoRecord({
    required String title,
    required String description,
    required DateTime dateTime,
    required String priority,
    required int categoryId,
  }) async {
    await database.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO todorecord(title, description, date_time, priority, categoryId, user_id) VALUES(?, ?, ?, ?, ?, ?)',
          [
            title,
            description,
            dateTime.toIso8601String(),
            priority,
            categoryId,
            loggedUserId
          ]);
      print('Todo record inserted with ID: $id');
    });
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getAllTodoRecords() async {
    return await database.query(
      'todorecord',
      where: 'user_id = ?',
      whereArgs: [loggedUserId],
    );
  }

  Future<List<Category>> getAllCategoryRecords() async {
    List<Map<String, dynamic>> categoryMaps = await database.query(
      'category',
      where: 'user_id = ?',
      whereArgs: [loggedUserId],
    );
    print(categoryMaps);
    return categoryMaps.map((map) => Category.fromMap(map)).toList();
  }

  Future<Map<String, dynamic>> getCategoryDetailsRecords(int categoryId) async {
    List<Map<String, dynamic>> categoryMaps = await database
        .query('category', where: 'id = ?', whereArgs: [categoryId]);
    if (categoryMaps.isNotEmpty) {
      return categoryMaps.first;
    } else {
      return {};
    }
  }

  //this part for category
  Future<void> insertCategory(
      {required String name,
      required String iconPath,
      required Color color}) async {
    String colorHex = color.value.toRadixString(16).padLeft(8, '0');
    await database.transaction((txn) async {
      int id = await txn.rawInsert(
        'INSERT INTO category(name,iconPath,color,user_id) VALUES(?,?,?,?)',
        [name, iconPath, colorHex, loggedUserId],
      );
      print('Category inserted with ID: $id');
    });
    notifyListeners();
  }

  Future<void> insertDefaultCategories() async {
    List<Map<String, dynamic>> defaultCategories = [
      {
        'name': 'Grocery',
        'iconPath': 'assets/images/bread 1.png',
        'color': Color(0xFFCCFF80).value.toRadixString(16).padLeft(8, '0'),
      },
      // {
      //   'name': 'Work',
      //   'iconPath': 'Sport',
      //   'color': Colors.FF9680.value.toRadixString(16).padLeft(8, '0'),
      // },
      {
        'name': 'Sport',
        'iconPath': 'assets/images/sport 1.png',
        'color': Color(0xFF80FFFF).value.toRadixString(16).padLeft(8, '0'),
      },
      {
        'name': 'Design',
        'iconPath': 'assets/images/design (1) 1.png',
        'color': Color(0xFF80FFD9).value.toRadixString(16).padLeft(8, '0'),
      },
      {
        'name': 'University',
        'iconPath': 'assets/images/mortarboard 1.png',
        'color': Color(0xFF809CFF).value.toRadixString(16).padLeft(8, '0'),
      },
      {
        'name': 'Social',
        'iconPath': 'assets/images/megaphone 1.png',
        'color': Color(0xFFFF80EB).value.toRadixString(16).padLeft(8, '0'),
      },
      {
        'name': 'Music',
        'iconPath': 'assets/images/music (1) 1.png',
        'color': Color(0xFFFC80FF).value.toRadixString(16).padLeft(8, '0'),
      },
      {
        'name': 'Health',
        'iconPath': 'assets/images/heartbeat 1.png',
        'color': Color(0xFF80FFA3).value.toRadixString(16).padLeft(8, '0'),
      },
      {
        'name': 'Movie',
        'iconPath': 'assets/images/video-camera 1.png',
        'color': Color(0xFF80D1FF).value.toRadixString(16).padLeft(8, '0'),
      },
      {
        'name': 'Home',
        'iconPath': 'assets/images/home (2) 1.png',
        'color': Color(0xFFFFCC80).value.toRadixString(16).padLeft(8, '0'),
      },
      {
        'name': 'Create New',
        'iconPath': 'assets/images/add 1.png',
        'color': Color(0xFF80FFD1).value.toRadixString(16).padLeft(8, '0'),
      },
    ];

    await database.transaction((txn) async {
      for (var category in defaultCategories) {
        // Check if the category already exists for the logged user
        List<Map<String, dynamic>> existingCategories = await txn.query(
          'category',
          where: 'name = ? AND user_id = ?',
          whereArgs: [category['name'], loggedUserId],
        );

        if (existingCategories.isEmpty) {
          int id = await txn.rawInsert(
            'INSERT INTO category(name, iconPath, color,user_id) VALUES(?, ?, ?, ?)',
            [
              category['name'],
              category['iconPath'],
              category['color'],
              loggedUserId
            ],
          );
          print('Category inserted with ID: $id');
        }
      }
    });
    notifyListeners();
  }


  //delete
  Future<void> deleteTodoRecord(int id) async {
    await database.rawDelete('DELETE FROM todorecord WHERE id = ?', [id]);
    notifyListeners();
  }

  Future<void> updateTodoRecord({
    required int id,
    required String title,
    required String description,
    required DateTime dateTime,
    required String priority,
    required int categoryId,
  }) async {
    await database.transaction((txn) async {
      await txn.rawUpdate(
        'UPDATE todorecord SET title = ?, description = ?, date_time = ?, priority = ?, categoryId = ? WHERE id = ? AND user_id = ?',
        [
          title,
          description,
          dateTime.toIso8601String(),
          priority,
          categoryId,
          id,
          loggedUserId
        ],
      );
      print('Todo record updated with ID: $id');
    });
    notifyListeners();
  }


}
