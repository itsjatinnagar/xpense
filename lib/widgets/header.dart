import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({required this.leftLabel, required this.rightLabel, super.key});

  final String leftLabel;
  final String rightLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftLabel,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          rightLabel,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
