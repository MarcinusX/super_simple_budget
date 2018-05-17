import 'package:flutter/material.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/model/expense.dart';

class InputExpenseRow extends StatefulWidget {
  final Function(Expense) onClick;

  const InputExpenseRow({Key key, this.onClick}) : super(key: key);

  @override
  _InputExpenseRowState createState() => new _InputExpenseRowState();
}

class _InputExpenseRowState extends State<InputExpenseRow> {
  TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = new TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

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
                controller: _inputController,
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
                  onPressed: () {
                    try {
                      double value = double.parse(_inputController.value.text);
                      DateTime dateTime = new DateTime.now();
                      widget.onClick(new Expense(value, dateTime));
                      _inputController.clear();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    } catch (FormatException) {}
                  },
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
