import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/service/database_service.dart';
import 'package:super_simple_budget/widget/cut_corners_border.dart';
import 'package:super_simple_budget/widget/main_page.dart';

void main() async {
  DatabaseService databaseService = new DatabaseService();
  await databaseService.open();
  runApp(new MyApp(databaseService: databaseService));
}

class MyApp extends StatelessWidget {

  final DatabaseService databaseService;

  const MyApp({Key key, this.databaseService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Super simple budget',
      supportedLocales: [
        const Locale('en', ''),
        const Locale('pl', ''),
      ],
      localizationsDelegates: [
        new GeneratedLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: new ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: new CutCornersBorder(),
          ),
          brightness: Brightness.dark,
          primarySwatch: Colors.yellow,
          accentColor: Colors.yellow),
      home: new MainPage(databaseService: databaseService),
    );
  }

}