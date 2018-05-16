import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:super_simple_budget/card_to_spend.dart';
import 'package:super_simple_budget/expense.dart';
import 'package:super_simple_budget/expense_history_row.dart';
import 'package:super_simple_budget/history_divider.dart';
import 'package:super_simple_budget/input_expense_row.dart';
import 'package:super_simple_budget/minor_value_card.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double startBudget = 400.0;

  List<Expense> expenses = [
    new Expense(12.23, new DateTime.now()),
    new Expense(33.22, new DateTime.now()),
    new Expense(65.01, new DateTime.now()),
    new Expense(100.76, new DateTime.now()),
    new Expense(96.54, new DateTime.now()),
    new Expense(43.99, new DateTime.now()),
    new Expense(23.11, new DateTime.now()),
  ];

  double get spent => expenses.fold(0.0, (sum, expense) => sum + expense.value);

  double get leftToSpend => startBudget - spent;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Super prosty budżet"),
        actions: <Widget>[
          new PopupMenuButton<String>(
            onSelected: (val) {},
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  const PopupMenuItem<String>(
                      value: 'costam',
                      child: const Text('Rozpocznij nowy okres')),
                ],
          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new CardToSpend(
                leftToSpend: leftToSpend,
              ),
              new InputExpenseRow(),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new MinorValueCard(
                      value: startBudget,
                      label: "Budżet startowy",
                    ),
                  ),
                  new Expanded(
                    child: new MinorValueCard(
                      value: spent,
                      label: "Suma wydatków",
                    ),
                  ),
                ],
              ),
              new HistoryDivider(),
              new Column(
                children: expenses
                    .map((expense) => new ExpenseHistoryRow(expense: expense))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
