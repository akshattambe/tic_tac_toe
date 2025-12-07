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
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TIP OF THE DAY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(tip),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.lightbulb),
              onPressed: onToggle,
              tooltip: 'Show Stats',
            ),
          ],
        ),
      ),
    );
  }
}
