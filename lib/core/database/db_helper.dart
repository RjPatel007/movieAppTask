import 'package:movie_task_app/core/models/model_movie.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static DBHelper get instance => _instance;

  Database? _db;
  final int _version = 1;
  final String movies = "movies";

  Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}/movies_app.db';
      _db = await openDatabase(path, version: _version,
          onCreate: (db, version) async {
        await db.execute("CREATE TABLE $movies ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title TEXT NOT NULL,"
            "description TEXT NOT NULL,"
            "imagePath TEXT NOT NULL,"
            "isFavourite INTEGER NOT NULL DEFAULT 0"
            ")");
      });
    } catch (e) {
      rethrow;
    }
  }

  ///Category
  Future<List<ModelMovie>> getMovies() async {
    try {
      final movieList = await _db?.query(movies);
      return (movieList ?? []).map((e) => ModelMovie.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addMovies(ModelMovie modelCategory) async {
    try {
      await _db?.insert(movies, modelCategory.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMovie(ModelMovie movie) async {
    try {
      await _db?.update(movies, where: "id=${movie.id}", movie.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteMovie(ModelMovie movie) async {
    try {
      await _db?.delete(movies, where: "id=${movie.id}");
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ModelMovie>> getFavoriteMovies() async {
    try {
      final movieList = await _db?.query(movies, where: "isFavourite=1");
      return (movieList ?? []).map((e) => ModelMovie.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
