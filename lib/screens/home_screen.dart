import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction_manager.dart';
import '../widgets/header.dart';
import '../widgets/today_expense_list_view.dart';
import '../widgets/chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weeklyExpenseList = Provider.of<TransactionManager>(context)
        .groupedTransactions
        .sublist(0, 7);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Chart(weeklyExpenseList),
            SizedBox(height: 16),
            Header(
              leftLabel: 'Today\'s Expenses',
              rightLabel:
                  '₹${weeklyExpenseList[0]['spending'].toStringAsFixed(2)}',
            ),
            SizedBox(height: 8),
            TodayExpenseListView(
              list: weeklyExpenseList[0]['expenses'],
            ),
          ],
        ),
      ),
    );
  }
}
