import 'package:flutter/material.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        color: colorScheme.surface,
        child: Center(
          child: Text(
            'Statistic Screen',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}