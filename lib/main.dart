import 'package:flutter/material.dart';
import 'package:super_simple_budget/cut_corners_border.dart';
import 'package:super_simple_budget/main_page.dart';

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
      home: new MainPage(),
    );
  }
}