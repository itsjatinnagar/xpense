import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpense/theme.dart';

import '../models/transaction.dart';
import '../models/transaction_manager.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(this.expense, {Key? key}) : super(key: key);

  final Expense expense;

  Future<bool> dismissSnackbar(BuildContext context) async {
    bool isDone = true;
    await ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text('Expense Deleted Successfully!'),
            action:
                SnackBarAction(label: 'Undo', onPressed: () => isDone = false),
            backgroundColor: kSecondaryColor,
            duration: Duration(seconds: 5),
          ),
        )
        .closed;
    return isDone;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kBorderRadius,
      child: Dismissible(
        key: ValueKey(expense.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (_) => dismissSnackbar(context),
        onDismissed: (_) =>
            Provider.of<TransactionManager>(context, listen: false)
                .deleteTransaction(expense),
        background: Container(
          padding: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).errorColor.withOpacity(0.16),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete_forever_rounded,
              size: 30.0,
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: kGreyishColor,
          ),
          child: ListTile(
            title: Text(expense.title),
            trailing: Text('₹${expense.amount.toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}
