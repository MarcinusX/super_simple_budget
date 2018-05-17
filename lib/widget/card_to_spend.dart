import 'package:flutter/material.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/model/currency.dart';

class CardToSpend extends StatelessWidget {
  final double leftToSpend;
  final Currency currency;

  const CardToSpend({Key key, this.leftToSpend, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Text(
                valueWithCurrency(leftToSpend, currency),
                style: Theme.of(context).textTheme.display3,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(S
                  .of(context)
                  .leftToSpend),
            ),
          ],
        ),
      ),
    );
  }
}
