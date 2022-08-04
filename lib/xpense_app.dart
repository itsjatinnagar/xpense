import 'package:flutter/material.dart';
import 'package:xpense/screens/all_transactions.dart';
import 'package:xpense/screens/home_screen.dart';

import 'screens/add_transaction_screen.dart';

class XpenseApp extends StatefulWidget {
  const XpenseApp({Key? key}) : super(key: key);

  @override
  State<XpenseApp> createState() => _XpenseAppState();
}

class _XpenseAppState extends State<XpenseApp> {
  final List<Widget> screens = [
    HomeScreen(),
    AllTransactionScreen(),
  ];
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: screenIndex,
        elevation: 1,
        onTap: (value) => setState(() => screenIndex = value),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Expenses',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddTransactionScreen(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
