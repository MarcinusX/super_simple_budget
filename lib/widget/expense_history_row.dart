import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_simple_budget/model/currency.dart';
import 'package:super_simple_budget/model/expense.dart';
import 'package:super_simple_budget/widget/edit_expense_dialog.dart';

class ExpenseHistoryRow extends StatelessWidget {
  final Expense expense;
  final Currency currency;
  final Function(Expense) onDismissed;
  final Function(Expense) onUpdated;

  const ExpenseHistoryRow(
      {Key key, this.expense, this.currency, this.onDismissed, this.onUpdated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => onDismissed(expense),
      key: Key(expense.id.toString()),
      child: new Card(
        shape: new BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: new ListTile(
          onTap: () => _onTap(context, expense.value),
          title: new Text(valueWithCurrency(expense.value, currency)),
          trailing: new Text(new DateFormat(
                  'EEEE, d MMMM', Localizations.localeOf(context).toString())
              .format(expense.dateTime)),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, double previousExpense) async {
    double newExpenseValue = await showDialog<double>(
      context: context,
      builder: (context) => new EditExpenseDialog(
        previousExpense: previousExpense,
      ),
    );
    if (newExpenseValue != null) {
      expense.value = newExpenseValue;
      onUpdated(expense);
    }
  }
}
