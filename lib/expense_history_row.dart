import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_simple_budget/expense.dart';

class ExpenseHistoryRow extends StatelessWidget {
  final Expense expense;

  const ExpenseHistoryRow({Key key, this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: new ListTile(
        title: new Text(expense.value.toStringAsFixed(2) + " zł"),
        trailing: new Text(new DateFormat(
                'EEEE, d MMMM', Localizations.localeOf(context).toString())
            .format(expense.dateTime)),
      ),
    );
  }
}
