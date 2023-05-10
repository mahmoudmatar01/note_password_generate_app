import 'package:path/path.dart';
//
// class NotesDataBase {
//   static final NotesDataBase instance = NotesDataBase._init();
//   NotesDataBase._init();
//   Database? notesDb;
//
//   //check method
//   Future<Database> get database async {
//     if (notesDb != null) return notesDb!;
//
//     notesDb = await _initDB();
//     return notesDb!;
//   }
//
//   //initial method
//   Future<Database> _initDB() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, "NotesDB.db");
//
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }
//
//   //create method
//   Future _createDB(Database db, int version) async {
//     await db.execute('''
// create table "Notes" (
//   "id" INTEGER PRIMARY KEY AUTOINCREMENT ,
//   "noteTitle" TEXT ,
//    "noteBody" TEXT ,
//   )
// ''');
//   }
//
//   Future<void> insert({required String title, required String noteBody}) async {
//     try {
//       final db = await database;
//       db.insert("Notes", {"noteTitle": title, "noteBody": noteBody});
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   Future<List<Map>> getAllTodos() async {
//     final db = await instance.database;
//     final result = await db.query("Notes");
//     return result;
//   }
//
//   Future<void> delete(int id, String myWhere) async {
//     try {
//       final db = await instance.database;
//       await db.delete(
//         "Notes",
//         where: myWhere,
//         whereArgs: [id],
//       );
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//
//     // Future<List<Map<String, Object?>>> readData() async {
//     //   List<Map<String, Object?>> response = await notesDb!.query("Notes");
//     //   return response;
//     // }
//
//     // Future<int> deleteData(String? myWhere) async {
//     //   Database? db = await noteDataBase;
//     //   int response = await db!.delete("NOTES", where: myWhere);
//     //   return response;
//     // }
//     //
//     // Future<int> updateData(Map<String, Object?> value, String? myWhere) async {
//     //   Database? db = await noteDataBase;
//     //   int response = await db!.update("NOTES", value, where: myWhere);
//     //   return response;
//     // }
//
//     // Future<int> insertData(Map<String, Object?> value) async {
//     //   Database? db = await noteDataBase;
//     //   int response = await db!.insert("NOTES", value);
//     //   return response;
//     // }
//
//     _deleteDataBase() async {
//       String dataPath = await getDatabasesPath();
//       String path = join(dataPath, 'NotesDB.db');
//       await deleteDatabase(path);
//     }
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'dart:async';

class NotesDataBase {
  static NotesDataBase? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';

  NotesDataBase._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory NotesDataBase() {
    _databaseHelper ??= NotesDataBase._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    String dbPath = await getDatabasesPath();
    final path = join(dbPath, "NotesDB.db");

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await database;
    //	var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(String title, String note) async {
    Database db = await database;
    var result =
        await db.insert(noteTable, {"title": title, "description": note});
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(String title, String note, int id) async {
    var db = await database;
    var result = await db.update(
        noteTable, {"title": title, "description": note},
        where: '$colId = ?', whereArgs: [id]);
    // var result =  db.rawUpdate(
    //     'UPDATE $noteTable SET $colTitle=$title , $colDescription=$note WHERE $colId=$id');
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }
}
