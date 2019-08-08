import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_simple_budget/model/currency.dart';
import 'package:super_simple_budget/model/edit_expense_response.dart';
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
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: ListTile(
          onTap: () => _onTap(context, expense),
          title: Text(valueWithCurrency(expense.value, currency)),
          subtitle: expense.comment != null && expense.comment.isNotEmpty
              ? Text(expense.comment)
              : null,
          trailing: Text(DateFormat(
                  'EEEE, d MMMM', Localizations.localeOf(context).toString())
              .format(expense.dateTime),),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, Expense expense) async {
    EditExpenseResponse editExpenseResponse =
        await showDialog<EditExpenseResponse>(
      context: context,
      builder: (context) => EditExpenseDialog(expense: expense),
    );
    if (editExpenseResponse != null) {
      expense.comment = editExpenseResponse.comment;
      expense.value = editExpenseResponse.value;
      onUpdated(expense);
    }
  }
}
