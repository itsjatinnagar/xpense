import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/transaction_manager.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionManager([]),
      child: MaterialApp(
        title: 'Xpense',
        home: HomeScreen(),
      ),
    );
  }
}
