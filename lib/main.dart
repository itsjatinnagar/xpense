import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xpense/databases/expense_db.dart';
import 'package:xpense/xpense_app.dart';

import 'models/transaction.dart';
import 'models/transaction_manager.dart';
import 'theme.dart';

Future<List<Expense>> initialize(WidgetsBinding widgetsBinding) async {
  widgetsBinding.deferFirstFrame();

  String? registerDate;
  List<Expense> dbRecords;
  final prefs = await SharedPreferences.getInstance();
  registerDate = prefs.getString('registeredOn');

  if (registerDate == null) {
    prefs.setString('registeredOn', DateTime.now().toIso8601String());
    dbRecords = [];
  } else {
    dbRecords = await ExpenseDatabaseManager.instance.readAllExpenses();
  }
  await Future.delayed(Duration(milliseconds: 3000));

  widgetsBinding.allowFirstFrame();
  return dbRecords;
}

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  final data = await initialize(WidgetsFlutterBinding.ensureInitialized());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(data));
}

class MyApp extends StatelessWidget {
  const MyApp(this.initialData, {Key? key}) : super(key: key);

  final List<Expense> initialData;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionManager(initialData),
      child: MaterialApp(
        title: 'Xpense',
        theme: kThemeData,
        home: XpenseApp(),
      ),
    );
  }
}
