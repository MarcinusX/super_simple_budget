import 'package:flutter/material.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/widget/cut_corners_border.dart';

class EditExpenseDialog extends StatefulWidget {
  final double previousExpense;

  const EditExpenseDialog({Key key, @required this.previousExpense})
      : super(key: key);

  @override
  _EditExpenseDialogState createState() => new _EditExpenseDialogState();
}

class _EditExpenseDialogState extends State<EditExpenseDialog> {
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
      title: new Text(S.of(context).editExpense),
      content: new TextField(
        cursorColor: Colors.yellow,
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          labelText: S.of(context).expense,
          hintText: widget.previousExpense?.toStringAsFixed(2) ?? '',
          border:
              CutCornersBorder(borderSide: BorderSide(color: Colors.yellow)),
        ),
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
