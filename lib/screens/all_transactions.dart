import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpense/models/transaction_manager.dart';
import 'package:xpense/theme.dart';
import 'package:xpense/widgets/expense_list_view.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupedExpenses = Provider.of<TransactionManager>(context)
        .groupedTransactions
        .where((element) => element['spending'] != 0)
        .toList();

    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: groupedExpenses.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Empty List',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: kDarkPurpleColor),
                    ),
                    SizedBox(height: 30),
                    Image.asset('assets/images/empty.png'),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'There is no expenses. Please start adding your expenses for better tracking.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            : buildExpenseList(groupedExpenses));
  }

  Widget buildExpenseList(groupedExpenses) => ListView(
        children: groupedExpenses
            .map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(e['date'].toString()),
                  SizedBox(height: 6),
                  ExpenseListView(e['expenses']),
                  SizedBox(height: 16),
                ],
              ),
            )
            .toList(),
      );
}
