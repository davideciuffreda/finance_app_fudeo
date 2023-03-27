import 'package:finance_app_fudeo/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  final Database database;

  DatabaseRepository(this.database);

  static Future<DatabaseRepository> newConnection() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path.join(databasesPath, "expense_tracker.db");
    final database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      db.execute("""
      CREATE TABLE expenses(
        uuid TEXT PRIMARY KEY,
        value REAL NOT NULL,
        description TEXT,
        createdOn INTEGER NOT NULL
      );
      """);
    });
    return DatabaseRepository(database);
  }

  Future<List<Expense>> allExpenses() async {
    final records = await database.query("expenses");
    return records.map((record) => Expense.fromMap(record)).toList();
  }

  void createExpense(Expense expense) {
    database.insert("expenses", expense.toMap());
  }

  void updateExpense(Expense expense) {
    database.update(
      "expenses",
      expense.toMap(),
      where: "uuid = ?",
      whereArgs: [expense.uuid],
    );
  }

  void deleteExpense(Expense expense) {
    database.delete(
      "expenses",
      where: "uuid = ?",
      whereArgs: [expense.uuid],
    );
  }
}
