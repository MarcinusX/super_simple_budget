import 'package:flutter/material.dart';

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
          child: new Text("Historia"),
        ),
        new Expanded(
            child: new Divider(
          color: Colors.white,
        )),
      ],
    );
  }
}
