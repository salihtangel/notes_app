import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';

class NotesDatabase {
  static final _name = "NotesDatabase.db";
  static final _version = 1;

  late Database database;
  static final tableName = 'notes';

  Future<void> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    // databaseFactory'yi burada tanımlayın
    databaseFactory = databaseFactoryFfi;

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _name);

    database = await openDatabase(path, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''CREATE TABLE $tableName (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              content TEXT,
              noteColor TEXT
          )'''
      );
    });
  }

  Future<int> insertNote(Note note) async {
    return await database.insert(
      tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateNote(Note note) async {
    return await database.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    return await database.query(tableName);
  }

  Future<Map<String, dynamic>?> getNotes(int id) async {
    var result = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.length > 0) {
      return result.first;
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  closeDatabase() async {
    await database.close();
  }
}
