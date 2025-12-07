import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsCard extends StatefulWidget {
  final VoidCallback onToggle;

  const StatsCard({
    Key? key,
    required this.onToggle,
  }) : super(key: key);

  @override
  _StatsCardState createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  int _gamesPlayed = 0;
  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _gamesPlayed = prefs.getInt('gamesPlayed') ?? 0;
      _xWins = prefs.getInt('X_wins') ?? 0;
      _oWins = prefs.getInt('O_wins') ?? 0;
      _draws = prefs.getInt('draws') ?? 0;
    });
  }

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
                Text('Games: $_gamesPlayed'),
                Text('X Wins: $_xWins'),
                Text('O Wins: $_oWins'),
                Text('Draws: $_draws'),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadStats,
                  tooltip: 'Refresh Stats',
                ),
                IconButton(
                  icon: const Icon(Icons.lightbulb_outline),
                  onPressed: widget.onToggle,
                  tooltip: 'Show Tip of the Day',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
