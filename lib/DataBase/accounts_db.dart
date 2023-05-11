import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AccountsDataBase {
  static AccountsDataBase? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String accountsTable = 'accounts_table';
  String colId = 'id';
  String colPlatformName = 'Platform_Name';
  String colFullName = 'Full_Name';
  String colEmail = 'Email';
  String colPassword = 'Password';

  AccountsDataBase._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory AccountsDataBase() {
    _databaseHelper ??= AccountsDataBase._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    String dbPath = await getDatabasesPath();
    final path = join(dbPath, "AccountsDB.db");

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $accountsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colPlatformName TEXT, '
        '$colFullName TEXT,$colEmail TEXT ,$colPassword TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getAccountsData() async {
    Database db = await database;
    //	var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(accountsTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertAccountData(String platformName, String fullName,
      String email, String password) async {
    Database db = await database;
    var result = await db.insert(accountsTable, {
      colPlatformName: platformName,
      colFullName: fullName,
      colEmail: email,
      colPassword: password
    });
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateAccountsData(String platformName, String fullName,
      String email, String password, int id) async {
    var db = await database;
    var result = await db.update(
        accountsTable,
        {
          colPlatformName: platformName,
          colFullName: fullName,
          colEmail: email,
          colPassword: password
        },
        where: '$colId = ?',
        whereArgs: [id]);
    // var result =  db.rawUpdate(
    //     'UPDATE $noteTable SET $colTitle=$title , $colDescription=$note WHERE $colId=$id');
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteAccountsData(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $accountsTable WHERE $colId = $id');
    return result;
  }
}
