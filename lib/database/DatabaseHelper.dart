import 'dart:io';

import 'package:flitter_design/model/Book_model.dart';
import 'package:flitter_design/model/Information_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  String DATABASENAME = "Data.db";
  String Book_Table = "Book_Table";
  String Information_Table = "Information_Table";
  String book_name = "book_name";
  String book_id = "book_id";
  String CASH_ID = "id";
  String cash = "cash";
  String ISCASH_IN = "isCash_In";
  String date = "date";
  String time = "time";
  String payment_category = "category";
  String payment_Mode = "mode";

  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = documentsDirectory.path + "/$DATABASENAME";
    print("master          $path");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $Book_Table ("
          "$book_id INTEGER PRIMARY KEY,"
          "$book_name TEXT"
          ");");

      await db.execute("CREATE TABLE $Information_Table ("
          "$CASH_ID INTEGER PRIMARY KEY,"
          "$book_id INTEGER,"
          "$cash DOUBLE,"
          "$ISCASH_IN BOOLEAN,"
          "$date DATETIME,"
          "$payment_category TEXT,"
          "$payment_Mode TEXT"
          ");");
      print("CREATE TABLE $Book_Table ("
          "$book_id INTEGER PRIMARY KEY,"
          "$book_name TEXT,"
          ");");
    });
  }

  Future<int> insertBook(Book_model model) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into $Book_Table ($book_name)"
        " VALUES (?)",
        [model.name]);
    return raw;
  }

  insertInfo(Information_model model) async {
    final db = await database;
    print('${model.date.toString()}');
    var raw = await db.rawInsert(
        "INSERT Into $Information_Table ($book_id,$cash,$ISCASH_IN,$date,$payment_category,$payment_Mode)"
        " VALUES (?,?,?,?,?,?)",
        [
          model.book_id,
          model.cash,
          model.isCash_In,
          '${model.date.toString()}',
          model.category,
          model.mode
        ]);
    return raw;
  }

  Future<List<Information_model>> getAllBokkEntriesByBookId() async {
    final db = await database;
    var res = await db.query(Information_Table);
    List<Information_model> list = res.isNotEmpty
        ? res.map((c) => Information_model.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<List<Book_model>> getAllBooks() async {
    final db = await database;
    var res = await db.query(Book_Table);
    List<Book_model> list =
        res.isNotEmpty ? res.map((c) => Book_model.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Information_model>> getAllBookEntriesById(int id) async {
    final db = await database;
    var res = await db.query(Information_Table,
        where: "$book_id == ?", whereArgs: [id.toString()]);
    List<Information_model> list = res.isNotEmpty
        ? res.map((c) => Information_model.fromJson(c)).toList()
        : [];
    return list;
  }
}
