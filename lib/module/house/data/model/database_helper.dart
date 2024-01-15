// helpers/database_helper.dart
import 'package:paperweft/module/house/data/model/article_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE articles(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT
      )
    ''');
  }

  Future<List<Article>> getArticles() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('articles');
    return List.generate(maps.length, (i) {
      return Article.fromMap(maps[i]);
    });
  }

  Future<void> insertArticle(Article article) async {
    final Database db = await database;
    await db.insert('articles', article.toMap());
  }

  Future<void> updateArticle(Article article) async {
    final Database db = await database;
    await db.update('articles', article.toMap(),
        where: 'id = ?', whereArgs: [article.id]);
  }

  Future<void> deleteArticle(int id) async {
    final Database db = await database;
    await db.delete('articles', where: 'id = ?', whereArgs: [id]);
  }
}
