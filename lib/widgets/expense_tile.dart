import 'package:flutter/material.dart';
import 'package:xpense/theme.dart';

import '../models/transaction.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(this.expense, {Key? key}) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: kGreyishColor,
      ),
      child: ListTile(
        title: Text(expense.title),
        trailing: Text('₹${expense.amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
