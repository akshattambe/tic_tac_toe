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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Setup Game',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  TextField(
                    controller: _player1NameController,
                    decoration: const InputDecoration(
                      labelText: 'Player 1 Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextField(
                    controller: _player2NameController,
                    decoration: const InputDecoration(
                      labelText: 'Player 2 Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player 1 Symbol:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 16.0),
                      ToggleButtons(
                        isSelected: [_player1Symbol == 'X', _player1Symbol == 'O'],
                        onPressed: (index) {
                          setState(() {
                            _player1Symbol = index == 0 ? 'X' : 'O';
                          });
                        },
                        borderRadius: BorderRadius.circular(8.0),
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
                  const SizedBox(height: 48.0),
                  ElevatedButton(
                    onPressed: () {
                      final player1 = Player(
                        name: _player1NameController.text.isNotEmpty
                            ? _player1NameController.text
                            : 'Player 1',
                        symbol: _player1Symbol,
                      );
                      final player2 = Player(
                        name: _player2NameController.text.isNotEmpty
                            ? _player2NameController.text
                            : 'Player 2',
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
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text('Start Game'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
