import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final VoidCallback onToggle;
  final int gamesPlayed;
  final int xWins;
  final int oWins;
  final int draws;

  const StatsCard({
    Key? key,
    required this.onToggle,
    required this.gamesPlayed,
    required this.xWins,
    required this.oWins,
    required this.draws,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CUMULATIVE STATS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text('Games: $gamesPlayed'),
                Text('X Wins: $xWins'),
                Text('O Wins: $oWins'),
                Text('Draws: $draws'),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.lightbulb_outline),
              onPressed: onToggle,
              tooltip: 'Show Tip of the Day',
            ),
          ],
        ),
      ),
    );
  }
}
