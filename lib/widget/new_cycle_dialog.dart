import 'package:flutter/material.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/widget/cut_corners_border.dart';

class NewCycleDialog extends StatefulWidget {
  @override
  _NewCycleDialogState createState() => new _NewCycleDialogState();
}

class _NewCycleDialogState extends State<NewCycleDialog> {
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
      title: new Text(S.of(context).beginNewCycle),
      content: new TextField(
        cursorColor: Colors.yellow,
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          labelText: S.of(context).budget,
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
