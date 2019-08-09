import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_simple_budget/model/currency.dart';

class MinorValueCard extends StatelessWidget {
  final double value;
  final String label;
  final Currency currency;

  const MinorValueCard({Key key, this.value, this.label, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    valueWithCurrency(value, currency),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
