import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:super_simple_budget/model/expense.dart';
import 'package:super_simple_budget/service/expense_provider.dart';

class DatabaseService {
  static const String _databaseName = "super_simple_budget.db";
  ExpenseProvider expenseProvider = new ExpenseProvider();

  Future open() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return expenseProvider.open(path);
  }

  Future<List<Expense>> getCurrentExpenses() async {
    return expenseProvider.getAll();
  }

  Future<Expense> addExpense(Expense expense) {
    return expenseProvider.insert(expense);
  }

  Future close() async {
    return expenseProvider.close();
  }
}
