const String expenseTableName = 'expenses';

class ExpenseFields {
  static const String idField = '_id';
  static const String titleField = 'title';
  static const String typeField = 'type';
  static const String amountField = 'amount';
  static const String dateField = 'date';

  static const List<String> columns = [
    idField,
    titleField,
    typeField,
    amountField,
    dateField
  ];
}

enum ExpenseType {
  expense,
  income,
}

class Expense {
  int? id;
  final String title;
  final ExpenseType transactionType;
  final double amount;
  final DateTime dateTime;

  Expense({
    this.id,
    required this.amount,
    required this.dateTime,
    required this.title,
    required this.transactionType,
  });

  Map<String, dynamic> toMap() => {
        ExpenseFields.idField: id,
        ExpenseFields.titleField: title,
        ExpenseFields.typeField:
            transactionType == ExpenseType.expense ? 'expense' : 'income',
        ExpenseFields.amountField: amount,
        ExpenseFields.dateField: dateTime.toIso8601String(),
      };

  static Expense fromMap(Map<String, dynamic> map) => Expense(
        id: map[ExpenseFields.idField],
        amount: map[ExpenseFields.amountField],
        dateTime: DateTime.parse(map[ExpenseFields.dateField]),
        title: map[ExpenseFields.titleField],
        transactionType: map[ExpenseFields.typeField] == 'expense'
            ? ExpenseType.expense
            : ExpenseType.income,
      );

  Expense copy(
          {int? id,
          String? title,
          ExpenseType? transactionType,
          double? amount,
          DateTime? dateTime}) =>
      Expense(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        dateTime: dateTime ?? this.dateTime,
        title: title ?? this.title,
        transactionType: transactionType ?? this.transactionType,
      );
}
