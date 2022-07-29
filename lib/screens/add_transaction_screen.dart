import 'package:flutter/material.dart';
import 'package:xpense/models/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  TransactionType transactionType = TransactionType.expense;
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  void datePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 7, 1),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) {
      return;
    }

    setState(
      () => date = selectedDate,
    );
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Validated');
                }
              },
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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
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
                selected: transactionType == TransactionType.expense,
                selectedColor: Color(0xFF42224A),
                onSelected: (_) =>
                    setState(() => transactionType = TransactionType.expense),
              ),
              ChoiceChip(
                label: Text(
                  'Income',
                  style: TextStyle(color: Colors.white),
                ),
                selected: transactionType == TransactionType.income,
                selectedColor: Color(0xFF42224A),
                onSelected: (_) =>
                    setState(() => transactionType = TransactionType.income),
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
              borderRadius: BorderRadius.circular(20.0),
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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
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
