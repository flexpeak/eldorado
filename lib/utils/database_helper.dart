import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// DatabaseHelper.database

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'tarefas2.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute("CREATE TABLE tarefas(id text primary key, descricao text)");
      },
    );
  }
}
