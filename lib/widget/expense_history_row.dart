import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_simple_budget/model/currency.dart';
import 'package:super_simple_budget/model/expense.dart';

class ExpenseHistoryRow extends StatelessWidget {
  final Expense expense;
  final Currency currency;

  const ExpenseHistoryRow({Key key, this.expense, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: new ListTile(
        title: new Text(valueWithCurrency(expense.value, currency)),
        trailing: new Text(new DateFormat(
                'EEEE, d MMMM', Localizations.localeOf(context).toString())
            .format(expense.dateTime)),
      ),
    );
  }
}
