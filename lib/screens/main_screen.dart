import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/leaderboard_screen.dart';
import 'package:tic_tac_toe/screens/setup_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tic-Tac-Toe'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Game'),
              Tab(text: 'Leaderboard'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SetupScreen(),
            LeaderboardScreen(),
          ],
        ),
      ),
    );
  }
}
