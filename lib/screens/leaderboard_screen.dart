import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  Map<String, int> _scores = {};

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final scores = <String, int>{};
    for (String key in keys) {
      if (key != 'gamesPlayed' &&
          key != 'X_wins' &&
          key != 'O_wins' &&
          key != 'draws' &&
          key != 'selected_wallpaper') {
        scores[key] = prefs.getInt(key) ?? 0;
      }
    }
    setState(() {
      _scores = scores;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _loadScores,
        tooltip: 'Refresh Scores',
        child: const Icon(Icons.refresh),
      ),
      body: _scores.isEmpty
          ? Center(
              child: Text(
                'No scores yet!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListView.separated(
                  itemCount: _scores.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final playerName = _scores.keys.elementAt(index);
                    final score = _scores[playerName];
                    return ListTile(
                      title: Text(
                        playerName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Text(
                        score.toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
