import 'package:flutter/material.dart';
import 'package:super_simple_budget/generated/i18n.dart';

class HistoryDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Expanded(
            child: new Divider(
          color: Colors.white,
        )),
        new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(S
              .of(context)
              .history),
        ),
        new Expanded(
            child: new Divider(
          color: Colors.white,
        )),
      ],
    );
  }
}
