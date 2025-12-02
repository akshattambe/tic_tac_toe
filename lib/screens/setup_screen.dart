import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _player1NameController = TextEditingController();
  final _player2NameController = TextEditingController();
  String _player1Symbol = 'X';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _player1NameController,
              decoration: const InputDecoration(
                labelText: 'Player 1 Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _player2NameController,
              decoration: const InputDecoration(
                labelText: 'Player 2 Name',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Player 1 Symbol:'),
                const SizedBox(width: 16.0),
                ToggleButtons(
                  isSelected: [_player1Symbol == 'X', _player1Symbol == 'O'],
                  onPressed: (index) {
                    setState(() {
                      _player1Symbol = index == 0 ? 'X' : 'O';
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('X'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('O'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                final player1 = Player(
                  name: _player1NameController.text,
                  symbol: _player1Symbol,
                );
                final player2 = Player(
                  name: _player2NameController.text,
                  symbol: _player1Symbol == 'X' ? 'O' : 'X',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      player1: player1,
                      player2: player2,
                    ),
                  ),
                );
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
