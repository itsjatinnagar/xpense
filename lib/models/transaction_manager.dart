import 'package:flutter/foundation.dart';
import 'package:xpense/databases/expense_db.dart';

import 'transaction.dart';

class TransactionManager extends ChangeNotifier {
  TransactionManager(this._list);

  final List<Expense> _list;

  List<Expense> get transactions => List.unmodifiable(_list);

  void addTransaction(Expense transaction) async {
    transaction = await ExpenseDatabaseManager.instance.insert(transaction);
    if (transaction.transactionType == ExpenseType.expense) {
      _list.add(transaction);
    }

    notifyListeners();
  }
}
