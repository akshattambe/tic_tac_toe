import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final int gamesPlayed;
  final int xWins;
  final int oWins;
  final int draws;
  final VoidCallback onToggle;

  const StatsCard({
    Key? key,
    required this.gamesPlayed,
    required this.xWins,
    required this.oWins,
    required this.draws,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'CUMULATIVE STATS',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.lightbulb_outline),
                  onPressed: onToggle,
                  tooltip: 'Show Tip of the Day',
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(context, 'Games', gamesPlayed),
                _buildStatItem(context, 'X Wins', xWins),
                _buildStatItem(context, 'O Wins', oWins),
                _buildStatItem(context, 'Draws', draws),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, int value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4.0),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
