import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BankDataBase {
  static BankDataBase? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String bankTable = 'bank_table';
  String colId = 'id';
  String colCardName = 'CardName';
  String colCardNumber = 'CardNumber';
  String colSecurityCode = 'SecurityCode';
  String colValidThrough = 'ValidThrough';

  BankDataBase._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory BankDataBase() {
    _databaseHelper ??= BankDataBase._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    String dbPath = await getDatabasesPath();
    final path = join(dbPath, "BankDB.db");

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $bankTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCardName TEXT, '
        '$colCardNumber TEXT,$colSecurityCode TEXT ,$colValidThrough TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getAccountData() async {
    Database db = await database;
    //	var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(bankTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertAccountData(String cardName, String cardNumber,
      String securityCode, String validThrough) async {
    Database db = await database;
    var result = await db.insert(bankTable, {
      colCardName: cardName,
      colCardNumber: cardNumber,
      colSecurityCode: securityCode,
      colValidThrough: validThrough
    });
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateAccountData(String cardName, String cardNumber,
      String securityCode, String validThrough, int id) async {
    var db = await database;
    var result = await db.update(
        bankTable,
        {
          colCardName: cardName,
          colCardNumber: cardNumber,
          colSecurityCode: securityCode,
          colValidThrough: validThrough
        },
        where: '$colId = ?',
        whereArgs: [id]);
    // var result =  db.rawUpdate(
    //     'UPDATE $noteTable SET $colTitle=$title , $colDescription=$note WHERE $colId=$id');
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteAccountData(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $bankTable WHERE $colId = $id');
    return result;
  }
}
