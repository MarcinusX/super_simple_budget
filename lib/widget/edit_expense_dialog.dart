import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/model/edit_expense_response.dart';
import 'package:super_simple_budget/model/expense.dart';
import 'package:super_simple_budget/widget/cut_corners_border.dart';

class EditExpenseDialog extends StatefulWidget {
  final Expense expense;
  final Function(Expense) onDelete;

  const EditExpenseDialog(
      {Key key, @required this.expense, @required this.onDelete})
      : super(key: key);

  @override
  _EditExpenseDialogState createState() => _EditExpenseDialogState();
}

class _EditExpenseDialogState extends State<EditExpenseDialog> {
  TextEditingController _expenseController;
  TextEditingController _commentController;
  bool _isExpenseValueValid = true;

  @override
  void initState() {
    super.initState();
    _expenseController = TextEditingController(
      text: widget.expense.value.toStringAsFixed(2),
    );
    _commentController = TextEditingController(
      text: widget.expense.comment,
    );
  }

  @override
  void dispose() {
    _expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(left: 24, top: 12, right: 8),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(S.of(context).editExpense),
          RawMaterialButton(
            onPressed: () {
              widget.onDelete(widget.expense);
              Navigator.of(context).pop();
            },
            child: Icon(Icons.delete),
            shape: CircleBorder(),
            padding: EdgeInsets.all(12),
            constraints: const BoxConstraints(minWidth: 0),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                cursorColor: Colors.yellow,
                controller: _expenseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: S.of(context).expense,
                  errorText: _isExpenseValueValid
                      ? null
                      : S.of(context).expenseIsRequired,
                  border: CutCornersBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                cursorColor: Colors.yellow,
                maxLength: 30,
                controller: _commentController,
                decoration: InputDecoration(
                  counterText: '',
                  labelText: S.of(context).comment,
                  border: CutCornersBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).cancel.toUpperCase()),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              _isExpenseValueValid = _expenseController.text.trim().isNotEmpty;
            });
            if (_isExpenseValueValid) {
              Navigator.of(context).pop(
                EditExpenseResponse(
                  double.parse(_expenseController.value.text),
                  _commentController.value.text,
                ),
              );
            }
          },
          child: Text(S.of(context).confirm.toUpperCase()),
        ),
      ],
    );
  }
}
