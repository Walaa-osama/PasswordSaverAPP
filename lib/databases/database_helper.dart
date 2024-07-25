import 'package:sqflite/sqflite.dart' as sql; //alias, sql.func()
import 'package:path/path.dart' as path;

// DbHelper db = DbHelper();

class DbHelper {
  static Future<sql.Database> getDatabase() async {
    final dbPath =
        await sql.getDatabasesPath(); // Get a location using getDatabasesPath
    String p = path.join(dbPath, 'users-data.db');
    // print(p);
    return sql.openDatabase(p,
        onCreate: (db, version) => db.execute(
            // When creating the db, create the table
            'CREATE TABLE Users (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)'),
        version: 1);
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
  }

  static Future<int> addToDb(String tableName, data) async {
    //returns id
    final db = await getDatabase();

    return db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<dynamic>> getData(String tableName) async {
    final db = await getDatabase();
    return db.query(tableName);
  }
}
