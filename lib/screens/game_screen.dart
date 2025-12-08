import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/models/player.dart';
import 'package:tic_tac_toe/widgets/board.dart';
import 'package:tic_tac_toe/widgets/info_card.dart';
import 'package:tic_tac_toe/widgets/status.dart';

class GameScreen extends StatefulWidget {
  final Player player1;
  final Player player2;

  const GameScreen({
    Key? key,
    required this.player1,
    required this.player2,
  }) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<String> _board;
  late Player _currentPlayer;
  Player? _winner;
  late bool _isDraw;
  int _gamesPlayed = 0;
  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;

  @override
  void initState() {
    super.initState();
    _currentPlayer = widget.player1;
    _loadStats();
    _resetGame();
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

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = widget.player1;
      _winner = null;
      _isDraw = false;
    });
    _loadStats();
  }

  Future<void> _updateStats() async {
    final prefs = await SharedPreferences.getInstance();
    final gamesPlayed = (_gamesPlayed) + 1;
    await prefs.setInt('gamesPlayed', gamesPlayed);

    if (_winner != null) {
      final winnerSymbol = _winner!.symbol;
      if (winnerSymbol == 'X') {
        final wins = (_xWins) + 1;
        await prefs.setInt('X_wins', wins);
      } else {
        final wins = (_oWins) + 1;
        await prefs.setInt('O_wins', wins);
      }
    } else {
      final draws = (_draws) + 1;
      await prefs.setInt('draws', draws);
    }
    _loadStats();
  }

  void _handleTap(int index) {
    if (_board[index] != '' || _winner != null) {
      return;
    }

    setState(() {
      _board[index] = _currentPlayer.symbol;
      _checkWinner();
      if (_winner == null) {
        _currentPlayer =
            _currentPlayer == widget.player1 ? widget.player2 : widget.player1;
        _isDraw = !_board.contains('');
        if (_isDraw) {
          _updateStats();
          _showEndDialog('Draw!');
        }
      } else {
        _updateStats();
        _showEndDialog('${_winner!.name} wins!');
      }
    });
  }

  void _checkWinner() {
    const List<List<int>> winningLines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6] // diagonals
    ];

    for (var line in winningLines) {
      String playerSymbol = _board[line[0]];
      if (playerSymbol != '' &&
          playerSymbol == _board[line[1]] &&
          playerSymbol == _board[line[2]]) {
        _winner =
            playerSymbol == widget.player1.symbol ? widget.player1 : widget.player2;
        return;
      }
    }
  }

  void _showEndDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Game Over',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Tic-Tac-Toe',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: _resetGame,
            tooltip: 'Restart Game',
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Status(
                winner: _winner,
                isDraw: _isDraw,
                currentPlayer: _currentPlayer.name,
              ),
              const SizedBox(height: 32.0),
              Board(
                board: _board,
                onTap: _handleTap,
              ),
              const SizedBox(height: 32.0),
              InfoCard(
                gamesPlayed: _gamesPlayed,
                xWins: _xWins,
                oWins: _oWins,
                draws: _draws,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
