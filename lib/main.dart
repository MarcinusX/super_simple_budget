import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:super_simple_budget/cut_corners_border.dart';
import 'package:super_simple_budget/expense.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Super simple budget',
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pl'),
      ],
      theme: new ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: new CutCornersBorder(),
          ),
          brightness: Brightness.dark,
          primarySwatch: Colors.yellow,
          accentColor: Colors.yellow),
      home: new MyHomePage(title: 'Super prosty budżet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double startBudget = 400.0;

  List<Expense> expenses = [
    new Expense(12.23, new DateTime.now()),
    new Expense(33.22, new DateTime.now()),
    new Expense(65.01, new DateTime.now()),
    new Expense(100.76, new DateTime.now()),
    new Expense(96.54, new DateTime.now()),
    new Expense(43.99, new DateTime.now()),
    new Expense(23.11, new DateTime.now()),
  ];

  double get spent => expenses.fold(0.0, (sum, expense) => sum + expense.value);

  double get leftToSpend => startBudget - spent;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new PopupMenuButton<String>(
            onSelected: (val) {},
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  const PopupMenuItem<String>(
                      value: 'costam',
                      child: const Text('Rozpocznij nowy okres')),
                ],
          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Card(
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
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: "Nowy wydatek",
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new SizedBox(
                        height: 56.0,
                        child: new RaisedButton(
                          padding: new EdgeInsets.all(0.0),
                          child: new Text(
                            "DODAJ",
                            style: Theme
                                .of(context)
                                .textTheme
                                .subhead
                                .copyWith(color: Colors.black),
                          ),
                          onPressed: () {},
                          shape: new BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Card(
                      shape: new BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: new Column(
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                              startBudget.toStringAsFixed(2) + " zł",
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ),
                          new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text("Budżet startowy"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Card(
                      shape: new BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: new Column(
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                              spent.toStringAsFixed(2) + " zł",
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ),
                          new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text("Suma wydatków"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              new Row(
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
              ),
              new Column(
                children: expenses.map((expense) {
                  return new Card(
                    shape: new BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: new ListTile(
                      title: new Text(expense.value.toStringAsFixed(2) + " zł"),
                      trailing: new Text(new DateFormat('EEEE, d MMMM',
                              Localizations.localeOf(context).toString())
                          .format(expense.dateTime)),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
