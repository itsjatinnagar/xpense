import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'expense_tile.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView(this.expenses, {Key? key}) : super(key: key);

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => ExpenseTile(expenses[index]),
      separatorBuilder: (context, index) => SizedBox(height: 6),
      itemCount: expenses.length,
    );
  }
}
