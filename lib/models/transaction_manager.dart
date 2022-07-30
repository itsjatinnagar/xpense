import 'package:flutter/foundation.dart';

import 'transaction.dart';

class TransactionManager extends ChangeNotifier {
  TransactionManager(this._list);

  final List<Expense> _list;

  List<Expense> get transactions => List.unmodifiable(_list);

  void addTransaction(Expense transaction) {
    // Database Insert
    _list.add(transaction);

    notifyListeners();
  }
}
