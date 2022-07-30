import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  static const double barHeight = 122;
  const ChartBar({
    Key? key,
    required this.amount,
    required this.date,
    required this.maximumSpending,
  }) : super(key: key);
  final DateTime date;
  final double amount;
  final double maximumSpending;

  @override
  Widget build(BuildContext context) {
    final containerHeight =
        amount == 0.0 ? barHeight : amount * barHeight / maximumSpending;

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: containerHeight,
            constraints: BoxConstraints(minWidth: 10, maxWidth: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: amount == 0.0 ? Colors.grey : Color(0xFFEF8767),
            ),
          ),
          SizedBox(height: 2),
          Text(
            '${date.day}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
