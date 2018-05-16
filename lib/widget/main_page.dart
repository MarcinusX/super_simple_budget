import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/model/expense.dart';
import 'package:super_simple_budget/service/database_service.dart';
import 'package:super_simple_budget/widget/card_to_spend.dart';
import 'package:super_simple_budget/widget/expense_history_row.dart';
import 'package:super_simple_budget/widget/history_divider.dart';
import 'package:super_simple_budget/widget/input_expense_row.dart';
import 'package:super_simple_budget/widget/minor_value_card.dart';

class MainPage extends StatefulWidget {
  final DatabaseService databaseService;

  MainPage({Key key, this.databaseService}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double startBudget = 400.0;

  List<Expense> expenses = [];

  double get spent => expenses.fold(0.0, (sum, expense) => sum + expense.value);

  double get leftToSpend => startBudget - spent;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _loadExpenses();
  }

  _loadExpenses() {
    widget.databaseService
        .getCurrentExpenses()
        .then((result) =>
        setState(() =>
        expenses =
        result..sort((ex1, ex2) => ex1.dateTime.compareTo(ex2.dateTime))));
  }

  _addExpense(Expense expense) {
    widget.databaseService.addExpense(expense);
    setState(() {
      expenses.insert(0, expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(S
            .of(context)
            .appTitle),
        actions: <Widget>[
          new PopupMenuButton<String>(
            onSelected: (val) {},
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                      value: 'costam',
                  child: new Text(S
                      .of(context)
                      .beginNewCycle)),
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
              new InputExpenseRow(
                onClick: _addExpense,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new MinorValueCard(
                      value: startBudget,
                      label: S
                          .of(context)
                          .startingBudget,
                    ),
                  ),
                  new Expanded(
                    child: new MinorValueCard(
                      value: spent,
                      label: S
                          .of(context)
                          .sumOfExpenses,
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
