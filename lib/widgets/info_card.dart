import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/stats_card.dart';
import 'package:tic_tac_toe/widgets/tip_of_the_day.dart';

class InfoCard extends StatefulWidget {
  final int gamesPlayed;
  final int xWins;
  final int oWins;
  final int draws;

  const InfoCard({
    Key? key,
    required this.gamesPlayed,
    required this.xWins,
    required this.oWins,
    required this.draws,
  }) : super(key: key);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _showStats = true;

  void _toggleView() {
    setState(() {
      _showStats = !_showStats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _showStats
          ? StatsCard(
              key: const ValueKey('StatsCard'),
              onToggle: _toggleView,
              gamesPlayed: widget.gamesPlayed,
              xWins: widget.xWins,
              oWins: widget.oWins,
              draws: widget.draws,
            )
          : TipOfTheDay(
              key: const ValueKey('TipOfTheDay'),
              onToggle: _toggleView,
            ),
    );
  }
}
