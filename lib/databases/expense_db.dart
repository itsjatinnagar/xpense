import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/transaction.dart';

class ExpenseDatabaseManager {
  static final ExpenseDatabaseManager instance = ExpenseDatabaseManager._init();
  ExpenseDatabaseManager._init();

  static Database? _database;

  Future<Database> get database async =>
      _database ?? await _initDB('xpense.db');

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getExternalStorageDirectory();
    final path = join(dbPath!.path, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String textType = 'TEXT NOT NULL';
    const String realType = 'REAL NOT NULL';

    await db.execute(
      'CREATE TABLE $expenseTableName'
      '('
      '${ExpenseFields.idField} $idType,'
      '${ExpenseFields.titleField} $textType,'
      '${ExpenseFields.typeField} $textType,'
      '${ExpenseFields.dateField} $textType,'
      '${ExpenseFields.amountField} $realType'
      ')',
    );
  }

  Future<Expense> insert(Expense expense) async {
    final db = await instance.database;

    final id = await db.insert(expenseTableName, expense.toMap());

    return expense.copy(id: id);
  }

  Future<List<Expense>> readAllExpenses() async {
    final db = await instance.database;

    final maps = await db.query(
      expenseTableName,
      columns: ExpenseFields.columns,
      where: '${ExpenseFields.typeField} = expense',
    );

    if (maps.isNotEmpty) {
      return maps.map((expense) => Expense.fromMap(expense)).toList();
    } else {
      return [];
    }
  }

  Future closeDB() async {
    final db = await instance.database;
    _database = null;
    await db.close();
  }
}
