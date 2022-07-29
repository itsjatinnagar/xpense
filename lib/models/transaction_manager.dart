import 'package:flutter/foundation.dart';

import 'transaction.dart';

class TransactionManager extends ChangeNotifier {
  TransactionManager(this._list);

  final List<Transaction> _list;

  List<Transaction> get transactions => List.unmodifiable(_list);

  void addTransaction(Transaction transaction) {
    // Database Insert
    _list.add(transaction);

    notifyListeners();
  }
}
