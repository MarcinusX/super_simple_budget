import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:super_simple_budget/generated/i18n.dart';
import 'package:super_simple_budget/service/storage_service.dart';
import 'package:super_simple_budget/widget/cut_corners_border.dart';
import 'package:super_simple_budget/widget/main_page.dart';

void main() async {

  // Suggested by flutter: 
  //    If you're running an application and need to access the binary messenger before `runApp()` has been called 
  //    (for example, during plugin initialization), then you need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()` first.
  WidgetsFlutterBinding.ensureInitialized();
  
  StorageService storageService = new StorageService();
  await storageService.open();
  runApp(new MyApp(databaseService: storageService));
}

class MyApp extends StatelessWidget {
  final StorageService databaseService;

  const MyApp({Key key, this.databaseService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
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
        accentColor: Colors.yellow,
        errorColor: Color.fromRGBO(255, 153, 153, 1),
      ),
      home: new MainPage(storageService: databaseService),
    );
  }
}
