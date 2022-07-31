import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpense/theme.dart';

import '../models/transaction.dart';
import '../models/transaction_manager.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final today = DateTime.now();

  late ExpenseType transactionType;
  late DateTime date;

  void datePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 8, 1),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    setState(
      () => date = selectedDate,
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final transaction = Expense(
        amount: double.parse(_amountController.text),
        dateTime: date,
        title: _titleController.text,
        transactionType: transactionType,
      );

      Provider.of<TransactionManager>(context, listen: false)
          .addTransaction(transaction);

      setState(initialize);
    }
  }

  void initialize() {
    _titleController.clear();
    _amountController.clear();
    transactionType = ExpenseType.expense;
    date = DateTime(today.year, today.month, today.day);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(6.0),
          children: [
            buildTitleField(),
            SizedBox(height: 10),
            buildTypeField(),
            SizedBox(height: 10),
            buildDateField(context),
            SizedBox(height: 10),
            buildAmountField(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: submit,
              child: Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitleField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title'),
          TextFormField(
            controller: _titleController,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == '') {
                return 'Title cannot be empty';
              }
            },
          ),
        ],
      );

  Widget buildTypeField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transaction Type'),
          Wrap(
            spacing: 6,
            children: [
              ChoiceChip(
                label: Text(
                  'Expense',
                  style: TextStyle(color: Colors.white),
                ),
                selected: transactionType == ExpenseType.expense,
                selectedColor: Color(0xFF42224A),
                onSelected: (_) =>
                    setState(() => transactionType = ExpenseType.expense),
              ),
              ChoiceChip(
                label: Text(
                  'Income',
                  style: TextStyle(color: Colors.white),
                ),
                selected: transactionType == ExpenseType.income,
                selectedColor: Color(0xFF42224A),
                onSelected: (_) =>
                    setState(() => transactionType = ExpenseType.income),
              ),
            ],
          ),
        ],
      );

  Widget buildDateField(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date'),
          Container(
            height: 48,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: kBorderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date.toString()),
                IconButton(
                  onPressed: () => datePicker(context),
                  icon: Icon(Icons.watch_later_outlined),
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildAmountField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount'),
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == '') {
                return 'Amount cannot be empty';
              } else if (double.tryParse(value!) == null ||
                  double.parse(value) < 0) {
                return 'Invalid Amount';
              }
            },
          ),
        ],
      );
}
