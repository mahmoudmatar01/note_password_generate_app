import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AccountsDataBase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dataPath = await getDatabasesPath();
    String path = join(dataPath, 'AccountsDataDB.db');
    Database accountsDataDb =
        await openDatabase(path, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {}
  _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE 'ACCOUNTS DATA'("ID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"PLATFORM NAME" TEXT NOT NULL. "FULL NAME" TEXT NOT NULL,"EMAIL" TEXT NOT NULL ,"PASSWORD" TEXT NOT NULL) ''');
  }

  readData() async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query("ACCOUNTS DATA'");
    return response;
  }

  deleteData(String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete("ACCOUNTS DATA'", where: myWhere);
    return response;
  }

  updateData(Map<String, dynamic> value, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update("ACCOUNTS DATA'", value, where: myWhere);
    return response;
  }

  insertData(Map<String, dynamic> value) async {
    Database? myDb = await db;
    int response = await myDb!.insert("ACCOUNTS DATA'", value);
    return response;
  }

  _deleteDataBase() async {
    String dataPath = await getDatabasesPath();
    String path = join(dataPath, 'NotesDB.db');
    await deleteDatabase(path);
  }
}
