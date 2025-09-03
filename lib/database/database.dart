import 'package:note_app_task/modle/node.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  NotesDatabase._init();

  Future<Database> get databasea async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$filePath';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE notes (
      id $idType,
      title $textType,
      description $textType
    )
    ''');
  }

  Future<int> insertNote(Map<String, dynamic> note) async {
    final db = await instance.databasea;
    return await db.insert('notes', note);
  }

  Future<List<Notemdl>> fetchNotes() async {
    final db = await instance.databasea;
    final result = await db.query('notes');
    return result.map((map) => Notemdl.fromMap(map)).toList();
  }

  Future<int> updateNote(Map<String, dynamic> note) async {
    final db = await instance.databasea;
    return await db.update(
      'notes',
      note,
      where: 'id = ?',
      whereArgs: [note['id']],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.databasea;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
