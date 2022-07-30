import 'package:flutter/material.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart(this.weeklyExpenses, {Key? key}) : super(key: key);

  final List<Map<String, dynamic>> weeklyExpenses;

  double getMaximumSpending(List<Map<String, dynamic>> expenses) {
    double max = 0.0;
    for (var element in expenses) {
      if (element['spending'] > max) {
        max = element['spending'];
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    final double maximumSpending = getMaximumSpending(weeklyExpenses);
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFF42224A),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weeklyExpenses
            .map((map) => ChartBar(
                  amount: map['spending'],
                  date: map['date'],
                  maximumSpending: maximumSpending,
                ))
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}
