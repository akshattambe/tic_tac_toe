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
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return Material(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () => onTap(index),
                child: Center(
                  child: Text(
                    board[index],
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: board[index] == 'X'
                          ? Colors.blue[800]
                          : Colors.red[800],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
