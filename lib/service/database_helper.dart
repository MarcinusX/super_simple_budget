import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:super_simple_budget/model/expense.dart';

const String tableExpenses = "_expenses";

class DatabaseHelper {
  Database db;

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreateDatabase,
      onUpgrade: _onUpgradeDatabase,
    );
  }

  void _onCreateDatabase(Database db, int version) async {
    await db.execute('''
create table $tableExpenses ( 
  $columnId integer primary key autoincrement, 
  $columnValue real not null,
  $columnDate integer not null,
  $columnComment text)
''');
  }

  void _onUpgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(
        "alter table $tableExpenses add column $columnComment text;",
      );
    }
  }

  Future<Expense> insertExpense(Expense expense) async {
    expense.id = await db.insert(tableExpenses, expense.toMap());
    return expense;
  }

  Future<Expense> updateExpense(Expense expense) async {
    await db.update(
      tableExpenses,
      expense.toMap(),
      where: '$columnId = ?',
      whereArgs: [expense.id],
    );
    return expense;
  }

  Future<List<Expense>> getAllExpenses() async {
    return (await db.query(
      tableExpenses,
      columns: [columnId, columnValue, columnDate, columnComment],
    ))
        .map((map) => new Expense.fromMap(map))
        .toList();
  }

  Future<int> deleteExpense(Expense expense) {
    return db.delete(tableExpenses, where: '$columnId = ${expense.id}');
  }

  Future<int> deleteAllExpense() async {
    return await db.delete(tableExpenses);
  }

  Future close() async => db.close();
}
