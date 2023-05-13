import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RegisterDataBase {
  static RegisterDataBase? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String registerTable = 'register_Table';
  String colId = 'id';
  String coFirstName = "FirstName";
  String colLastName = "LastName";
  String colEmail = 'Email';
  String colPassword = 'Password';

  RegisterDataBase._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory RegisterDataBase() {
    _databaseHelper ??= RegisterDataBase._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    String dbPath = await getDatabasesPath();
    final path = join(dbPath, "RegisterDB.db");

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $registerTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colEmail TEXT, '
        '$colPassword TEXT ,$coFirstName TEXT ,$colLastName TEXT)');
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertAccountData(
      String email, String password, String firstName, String lastName) async {
    Database db = await database;
    var result = await db.insert(registerTable, {
      colEmail: email,
      colPassword: password,
      coFirstName: firstName,
      colLastName: lastName
    });
    return result;
  }

// Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getAccountData(
      String email, String password) async {
    Database db = await database;
    var result = await db
        .rawQuery('SELECT * FROM $registerTable WHERE $colEmail = ?', [email]);
    return result;
  }
}
