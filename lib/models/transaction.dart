enum TransactionType {
  expense,
  income,
}

class Transaction {
  int? id;
  final String title;
  final TransactionType transactionType;
  final double amount;
  final DateTime dateTime;

  Transaction({
    this.id,
    required this.amount,
    required this.dateTime,
    required this.title,
    required this.transactionType,
  });
}
