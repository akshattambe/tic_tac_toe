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
      statusColor = winner!.symbol == 'X'
          ? Theme.of(context).primaryColor
          : Colors.red;
    } else if (isDraw) {
      status = 'It\'s a Draw!';
      statusColor = Theme.of(context).textTheme.bodyMedium!.color!;
    } else {
      status = '$currentPlayer\'s Turn';
      statusColor = Theme.of(context).textTheme.bodyMedium!.color!;
    }
    return Text(
      status,
      style:
          Theme.of(context).textTheme.displayMedium?.copyWith(color: statusColor),
      textAlign: TextAlign.center,
    );
  }
}