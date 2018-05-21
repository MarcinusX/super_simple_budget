import 'package:flutter/material.dart';
import 'package:super_simple_budget/generated/i18n.dart';

class ChangeBudgetDialog extends StatefulWidget {
  final double previousBudget;

  const ChangeBudgetDialog({Key key, this.previousBudget}) : super(key: key);

  @override
  _ChangeBudgetDialogState createState() => new _ChangeBudgetDialogState();
}

class _ChangeBudgetDialogState extends State<ChangeBudgetDialog> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text(S.of(context).changeBudget),
      content: new TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
            labelText: S.of(context).budget,
            hintText: widget.previousBudget?.toStringAsFixed(2) ?? ''),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: new Text(S.of(context).cancel.toUpperCase()),
        ),
        new FlatButton(
          onPressed: () =>
              Navigator.of(context).pop(double.parse(_controller.value.text)),
          child: new Text(S.of(context).confirm.toUpperCase()),
        ),
      ],
    );
  }
}
