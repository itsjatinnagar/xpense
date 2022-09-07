import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xpense/models/transaction_manager.dart';

import '../xpense_app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future<void> initialize(BuildContext context) async {
    String? registerDate;
    final manager = Provider.of<TransactionManager>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    registerDate = prefs.getString('registeredOn');

    if (registerDate == null) {
      prefs.setString('registeredOn', DateTime.now().toIso8601String());
    }
    await manager.fetchTransactions();
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize(context),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return XpenseApp();
        } else if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text(
                snapshot.error.toString(),
              ),
            ),
          );
        } else {
          return splashLoader();
        }
      },
    );
  }

  Scaffold splashLoader() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
