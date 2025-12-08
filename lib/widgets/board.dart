import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  final List<String> board;
  final Function(int) onTap;

  const Board({
    Key? key,
    required this.board,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        children: List.generate(9, (index) {
          return InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: () => onTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              child: Center(
                child: Text(
                  board[index],
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: board[index] == 'X'
                            ? Theme.of(context).primaryColor
                            : Colors.red,
                      ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
