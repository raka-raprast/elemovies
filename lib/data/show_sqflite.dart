// ignore_for_file: prefer_const_declarations, depend_on_referenced_packages

import 'dart:developer';

import 'package:emovied/models/saved_show.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SavedShowsDatabase {
  static final SavedShowsDatabase instance = SavedShowsDatabase._init();
  static Database? _database;

  SavedShowsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pictogram.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final textType = 'TEXT';
    await db.execute('''
CREATE TABLE $tableSavedShows (
  ${SavedShowsFields.id} $idType,
  ${SavedShowsFields.backdropPath} $textType,
  ${SavedShowsFields.originalLanguage} $textType,
  ${SavedShowsFields.originalTitle} $textType,
  ${SavedShowsFields.title} $textType,
  ${SavedShowsFields.overview} $textType,
  ${SavedShowsFields.posterPath} $textType,
  ${SavedShowsFields.mediaType} $textType,
  ${SavedShowsFields.releaseDate} $textType,
  ${SavedShowsFields.firstAirDate} $textType,
  ${SavedShowsFields.voteCount} $textType,
  ${SavedShowsFields.voteAverage} $textType,
  ${SavedShowsFields.popularity} $textType,
  ${SavedShowsFields.originalName} $textType,
  ${SavedShowsFields.name} $textType
  )
''');
  }

  Future<SavedShows> create(SavedShows savedShows) async {
    final db = await instance.database;

    final id = await db.insert(tableSavedShows, savedShows.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    log(id.toString());
    return savedShows;
  }

  Future<SavedShows> readSavedShows(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSavedShows,
      columns: SavedShowsFields.values,
      where: '${SavedShowsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SavedShows.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<WatchListWithID> readSavedShowsID() async {
    final db = await instance.database;
    final orderBy = '${SavedShowsFields.title} ASC';
    final result = await db.query(tableSavedShows, orderBy: orderBy);
    var shows = result.map((json) => SavedShows.fromJson(json)).toList();
    var ids = result.map((json) => SavedShows.fromJson(json).id!).toList();
    return WatchListWithID(shows: shows, registeredID: ids);
  }

  Future<List<SavedShows>> readAllSavedShows() async {
    final db = await instance.database;
    final orderBy = '${SavedShowsFields.title} ASC';
    final result = await db.query(tableSavedShows, orderBy: orderBy);
    return result.map((json) => SavedShows.fromJson(json)).toList();
  }

  Future<int> update(SavedShows savedShows) async {
    final db = await instance.database;

    return db.update(tableSavedShows, savedShows.toJson(), where: '${SavedShowsFields.id} = ?', whereArgs: [savedShows.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(tableSavedShows, where: '${SavedShowsFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

class WatchListWithID {
  final List<SavedShows> shows;
  final List<int> registeredID;

  WatchListWithID({required this.shows, required this.registeredID});
}
