import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:super_simple_budget/model/expense.dart';

const String tableExpenses = "_expenses";

class ExpenseProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableExpenses ( 
  $columnId integer primary key autoincrement, 
  $columnValue real not null,
  $columnDate integer not null)
''');
    });
  }

  Future<Expense> insert(Expense expense) async {
    expense.id = await db.insert(tableExpenses, expense.toMap());
    return expense;
  }

  Future<List<Expense>> getAll() async {
    return (await db.query(
      tableExpenses,
      columns: [columnId, columnValue, columnDate],
    ))
        .map((map) => new Expense.fromMap(map))
        .toList();
  }

  Future<Expense> getExpense(int id) async {
    List<Map> maps = await db.query(tableExpenses,
        columns: [columnId, columnValue, columnDate],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Expense.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableExpenses, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(Expense expense) async {
    return await db.update(tableExpenses, expense.toMap(),
        where: "$columnId = ?", whereArgs: [expense.id]);
  }

  Future close() async => db.close();
}
