import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/model/currency.dart';
import 'package:super_simple_budget/model/expense.dart';
import 'package:super_simple_budget/service/storage_service.dart';
import 'package:super_simple_budget/widget/card_to_spend.dart';
import 'package:super_simple_budget/widget/change_budget_dialog.dart';
import 'package:super_simple_budget/widget/expense_history_row.dart';
import 'package:super_simple_budget/widget/history_divider.dart';
import 'package:super_simple_budget/widget/input_expense_row.dart';
import 'package:super_simple_budget/widget/minor_value_card.dart';
import 'package:super_simple_budget/widget/new_cycle_dialog.dart';

class MainPage extends StatefulWidget {
  final StorageService storageService;

  MainPage({Key key, this.storageService}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double startBudget = 0.0;
  List<Expense> expenses = [];
  Currency currency;

  double get spent => expenses.fold(0.0, (sum, expense) => sum + expense.value);

  double get leftToSpend => startBudget - spent;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _loadExpenses();
    this.currency = widget.storageService.getCurrency();
    this.startBudget = widget.storageService.getStartingBudget() ?? 0.0;
  }

  _loadExpenses() {
    widget.storageService.getCurrentExpenses().then((result) =>
        setState(() =>
        expenses = result
          ..sort((ex1, ex2) => ex1.dateTime.compareTo(ex2.dateTime))));
  }

  _addExpense(Expense expense) {
    widget.storageService.addExpense(expense);
    setState(() {
      expenses.insert(0, expense);
    });
  }

  _openCurrencyDialog() async {
    Currency currency = await showDialog(
        context: context,
        builder: (context) {
          return new SimpleDialog(
            title: new Text(S
                .of(context)
                .chooseCurrency),
            children: Currency.currencies
                .map(
                  (currency) =>
              new SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(currency),
                child: new ListTile(
                  selected: currency == this.currency,
                  title: new Text(currency.getName(context)),
                ),
              ),
            )
                .toList(),
          );
        });
    if (currency != null) {
      widget.storageService.saveCurrency(currency);
      setState(() {
        this.currency = currency;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        key: new Key("app_bar"),
        centerTitle: true,
        title: new Text(S
            .of(context)
            .appTitle),
        actions: <Widget>[
          new PopupMenuButton<String>(
            onSelected: (val) {
              switch (val) {
                case 'CURRENCY':
                  _openCurrencyDialog();
                  break;
                case 'NEW_CYCLE':
                  _openNewCycleDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                value: 'NEW_CYCLE',
                child: new Text(S
                    .of(context)
                    .beginNewCycle),
              ),
              new PopupMenuItem<String>(
                value: 'CURRENCY',
                child: new Text(S
                    .of(context)
                    .changeCurrency),
              ),
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
                currency: currency,
              ),
              new InputExpenseRow(
                onClick: _addExpense,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap: _openChangeBudgetDialog,
                      child: new MinorValueCard(
                        value: startBudget,
                        label: S
                            .of(context)
                            .startingBudget,
                        currency: currency,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new MinorValueCard(
                      value: spent,
                      label: S
                          .of(context)
                          .sumOfExpenses,
                      currency: currency,
                    ),
                  ),
                ],
              ),
              new HistoryDivider(),
              new Column(
                children: expenses
                    .map((expense) =>
                new ExpenseHistoryRow(
                  expense: expense,
                  currency: currency,
                ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openChangeBudgetDialog() async {
    double newBudget = await showDialog<double>(
      context: context,
      builder: (context) => new ChangeBudgetDialog(previousBudget: startBudget),
    );
    if (newBudget != null) {
      await widget.storageService.saveStartingBudget(newBudget, reset: false);
      setState(() {
        this.startBudget = newBudget;
      });
    }
  }

  void _openNewCycleDialog({bool reset = true}) async {
    double newBudget = await showDialog<double>(
      context: context,
      builder: (context) => new NewCycleDialog(),
    );
    if (newBudget != null) {
      await widget.storageService.saveStartingBudget(newBudget, reset: true);
      setState(() {
        this.startBudget = newBudget;
        if (reset) {
          this.expenses = [];
        }
      });
    }
  }
}
