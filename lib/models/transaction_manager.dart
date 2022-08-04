import 'package:flutter/material.dart';
import 'package:xpense/databases/expense_db.dart';

import 'transaction.dart';

class TransactionManager extends ChangeNotifier {
  TransactionManager(this._list);

  final List<Expense> _list;

  List<Map<String, dynamic>> get groupedTransactions {
    final DateTime registeredOn = DateTime(2022, 8, 1);
    final DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final temp = DateTimeRange(start: registeredOn, end: today).duration.inDays;
    final int length = temp < 7 ? 7 : temp;

    final List<Map<String, dynamic>> list = [];

    for (var i = 0; i <= length; i++) {
      final date = today.subtract(Duration(days: i));
      final dayExpenses = _list
          .where((element) => date.compareTo(element.dateTime) == 0)
          .toList();
      double daySpending = dayExpenses.fold(
          0.0, (previousValue, element) => previousValue + element.amount);
      list.add(
          {'date': date, 'spending': daySpending, 'expenses': dayExpenses});
    }
    return list;
  }

  void addTransaction(Expense transaction) async {
    transaction = await ExpenseDatabaseManager.instance.insert(transaction);
    if (transaction.transactionType == ExpenseType.expense) {
      _list.add(transaction);
    }

    notifyListeners();
  }
}
