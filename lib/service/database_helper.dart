import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:super_simple_budget/model/expense.dart';

const String tableExpenses = "_expenses";

class DatabaseHelper {
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

  Future<Expense> insertExpense(Expense expense) async {
    expense.id = await db.insert(tableExpenses, expense.toMap());
    return expense;
  }

  Future<List<Expense>> getAllExpenses() async {
    return (await db.query(
      tableExpenses,
      columns: [columnId, columnValue, columnDate],
    ))
        .map((map) => new Expense.fromMap(map))
        .toList();
  }

  Future<int> deleteAllExpense() async {
    return await db.delete(tableExpenses);
  }

  Future close() async => db.close();
}
