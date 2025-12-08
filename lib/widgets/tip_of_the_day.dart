import 'dart:math';

import 'package:flutter/material.dart';

class TipOfTheDay extends StatelessWidget {
  final VoidCallback onToggle;

  const TipOfTheDay({
    Key? key,
    required this.onToggle,
  }) : super(key: key);

  static const List<String> _tips = [
    'To win at tic-tac-toe, try to take a corner spot as your first move.',
    'If your opponent takes the center square, take a corner square as your first move.',
    'If your opponent takes a corner, take the center.',
    'The player who goes first can always win or draw if they play optimally.',
    'A "perfect" game of tic-tac-toe always results in a draw.',
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final tip = _tips[random.nextInt(_tips.length)];
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TIP OF THE DAY',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.lightbulb),
                  onPressed: onToggle,
                  tooltip: 'Show Stats',
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              tip,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
