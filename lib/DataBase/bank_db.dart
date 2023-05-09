import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BankDataBase {
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
    String path = join(dataPath, 'BankDataDB.db');
    Database? bankDataDb =
        await openDatabase(path, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return bankDataDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {}
  _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE "Banks DATA"("ID" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "CARD NAME" TEXT NOT NULL,"CARD NUMBER" TEXT NOT NULL ,"SECURITY CODE" TEXT NOT NULL ,"VALID THROUGH" TEXT NOT NULL) ''');
  }

  readData() async {
    Database? myDb = await db;
    List<Map<String, Object?>> response = await myDb!.query("Banks DATA");
    return response;
  }

  deleteData(String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete("Banks DATA", where: myWhere);
    return response;
  }

  updateData(Map<String, dynamic> value, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update("Banks DATA", value, where: myWhere);
    return response;
  }

  insertData(Map<String, dynamic> value) async {
    Database? myDb = await db;
    int response = await myDb!.insert("Banks DATA", value);
    return response;
  }

  _deleteDataBase() async {
    String dataPath = await getDatabasesPath();
    String path = join(dataPath, 'NotesDB.db');
    await deleteDatabase(path);
  }
}
