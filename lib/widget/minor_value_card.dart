import 'package:flutter/material.dart';

class MinorValueCard extends StatelessWidget {
  final double value;
  final String label;

  const MinorValueCard({Key key, this.value, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              value.toStringAsFixed(2) + " zł",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(label),
          ),
        ],
      ),
    );
  }
}
