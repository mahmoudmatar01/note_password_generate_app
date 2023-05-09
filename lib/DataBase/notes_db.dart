import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDataBase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future initialDb() async {
    String dataPath = await getDatabasesPath();
    String path = join(dataPath, 'NotesDB.db');
    Database? notesDb =
        await openDatabase(path, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return notesDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {}
  _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE "NOTES"("ID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"TITLE" TEXT NOT NULL ,"NOTE" TEXT NOT NULL) ''');
  }

  readData() async {
    Database? myDb = await db;
    List<Map<String, Object?>> response = await myDb!.query("Notes");
    return response;
  }

  deleteData(String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete("NOTES", where: myWhere);
    return response;
  }

  updateData(Map<String, Object?> value, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update("NOTES", value, where: myWhere);
    return response;
  }

  insertData(Map<String, Object?> value) async {
    Database? myDb = await db;
    int response = await myDb!.insert("NOTES", value);
    return response;
  }

  _deleteDataBase() async {
    String dataPath = await getDatabasesPath();
    String path = join(dataPath, 'NotesDB.db');
    await deleteDatabase(path);
  }
}
