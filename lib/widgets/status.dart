import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/player.dart';

class Status extends StatelessWidget {
  final Player? winner;
  final bool isDraw;
  final String currentPlayer;

  const Status({
    Key? key,
    required this.winner,
    required this.isDraw,
    required this.currentPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status;
    Color statusColor;
    if (winner != null) {
      status = '${winner!.name} Wins!';
      statusColor = winner!.symbol == 'X' ? Colors.blue[800]! : Colors.red[800]!;
    } else if (isDraw) {
      status = 'It\'s a Draw!';
      statusColor = Colors.grey[800]!;
    } else {
      status = '$currentPlayer\'s Turn';
      statusColor = Colors.black;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: statusColor,
        ),
      ),
    );
  }
}
