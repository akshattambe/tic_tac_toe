import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/stats_card.dart';
import 'package:tic_tac_toe/widgets/tip_of_the_day.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({Key? key}) : super(key: key);

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
            )
          : TipOfTheDay(
              key: const ValueKey('TipOfTheDay'),
              onToggle: _toggleView,
            ),
    );
  }
}
