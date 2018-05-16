import 'package:flutter/material.dart';

class CardToSpend extends StatelessWidget {
  final double leftToSpend;

  const CardToSpend({Key key, this.leftToSpend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Text(
                leftToSpend.toStringAsFixed(2) + " zł",
                style: Theme.of(context).textTheme.display3,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text("Zostało do wydania"),
            ),
          ],
        ),
      ),
    );
  }
}
