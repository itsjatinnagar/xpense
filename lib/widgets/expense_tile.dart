import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFF2EDF3),
      ),
      child: ListTile(
        title: Text('Title'),
        subtitle: Text('Date'),
        trailing: Text('Amount'),
      ),
    );
  }
}
