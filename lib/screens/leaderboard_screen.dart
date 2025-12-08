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
      scores[key] = prefs.getInt(key) ?? 0;
    }
    setState(() {
      _scores = scores;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: _loadScores,
        tooltip: 'Refresh Scores',
        child: const Icon(Icons.refresh),
      ),
      body: _scores.isEmpty
          ? const Center(
              child: Text('No scores yet!'),
            )
          : Card(
              margin: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _scores.length,
                itemBuilder: (context, index) {
                  final playerName = _scores.keys.elementAt(index);
                  final score = _scores[playerName];
                  return ListTile(
                    title: Text(playerName),
                    trailing: Text(score.toString()),
                  );
                },
              ),
            ),
    );
  }
}
