import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modele/redacteur.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  factory DatabaseManager() => _instance;
  DatabaseManager._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'redacteur.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE redacteurs(id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, prenom TEXT, email TEXT)',
        );
      },
    );
  }

  Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await database;
    final result = await db.query('redacteurs');
    return result.map((json) => Redacteur.withId(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
    )).toList();
  }

  Future<void> insertRedacteur(Redacteur redacteur) async {
    final db = await database;
    await db.insert('redacteurs', redacteur.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateRedacteur(Redacteur redacteur) async {
    final db = await database;
    await db.update('redacteurs', redacteur.toMap(), where: 'id = ?', whereArgs: [redacteur.id]);
  }

  Future<void> deleteRedacteur(int id) async {
    final db = await database;
    await db.delete('redacteurs', where: 'id = ?', whereArgs: [id]);
  }
}
