import 'package:flutter/material.dart';
import 'package:super_simple_budget/generated/i18n.dart';

class InputExpenseRow extends StatefulWidget {
  @override
  _InputExpenseRowState createState() => new _InputExpenseRowState();
}

class _InputExpenseRowState extends State<InputExpenseRow> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: S
                      .of(context)
                      .newExpense,
                ),
              ),
            ),
          ),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new SizedBox(
                height: 56.0,
                child: new RaisedButton(
                  padding: new EdgeInsets.all(0.0),
                  child: new Text(
                    S
                        .of(context)
                        .add
                        .toUpperCase(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.black),
                  ),
                  onPressed: () {},
                  shape: new BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
