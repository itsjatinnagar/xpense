import 'package:flutter/material.dart';

import '../models/transaction.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(this.expense, {Key? key}) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFF2EDF3),
      ),
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text(expense.dateTime.toString()),
        trailing: Text('₹${expense.amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
