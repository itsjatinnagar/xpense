import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction.dart';
import '../models/transaction_manager.dart';
import 'add_transaction_screen.dart';
import '../widgets/today_expense_list_view.dart';
import '../widgets/chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  List<Map<String, dynamic>> groupedExpenses(List<Expense> expenses) {
    final List<Map<String, dynamic>> list = [];

    final firstDate =
        DateTime(2022, 7, 22); //SharedPreferences registeredOn datetime
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final days = DateTimeRange(start: firstDate, end: today).duration.inDays;
    final length = days < 7 ? 7 : days;

    for (var i = 0; i <= length; i++) {
      final date = today.subtract(Duration(days: i));
      final dayExpenses = <Expense>[];
      double daySpending = 0.0;
      for (var element in expenses) {
        if (date.compareTo(element.dateTime) == 0) {
          dayExpenses.add(element);
          daySpending += element.amount;
        }
      }

      list.add({
        'date': date,
        'spending': daySpending,
        'expenses': dayExpenses,
      });
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final groupedExpenseList =
        groupedExpenses(Provider.of<TransactionManager>(context).transactions);
    print(groupedExpenseList);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Chart(groupedExpenseList.sublist(0, 7)),
            SizedBox(height: 16),
            header(groupedExpenseList[0]['spending']),
            SizedBox(height: 8),
            TodayExpenseListView(
              list: groupedExpenseList[0]['expenses'],
            ),
          ],
        ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget header(double spending) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Today\'s Expenses'),
          Text('₹${spending.toStringAsFixed(2)}'),
        ],
      );
}
