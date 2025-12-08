import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/leaderboard_screen.dart';
import 'package:tic_tac_toe/screens/setup_screen.dart';
import 'package:tic_tac_toe/screens/theme_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Tic-Tac-Toe',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.palette_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThemeScreen(),
                  ),
                );
              },
              tooltip: 'Theme & Wallpaper',
            ),
          ],
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Game'),
              Tab(text: 'Leaderboard'),
            ],
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            indicatorColor: Theme.of(context).primaryColor,
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
