import 'package:flutter/material.dart';
import 'package:xpense/models/transaction.dart';

import 'expense_tile.dart';

class TodayExpenseListView extends StatelessWidget {
  final List<Transaction> list;

  const TodayExpenseListView({required this.list, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: list.isEmpty
          ? Center(
              child: Image.asset('assets/images/empty.png'),
            )
          : ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) => ExpenseTile(),
              separatorBuilder: (context, index) => SizedBox(height: 6),
            ),
    );
  }
}
