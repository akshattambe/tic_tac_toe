import 'package:cloud_firestore/cloud_firestore.dart';

class GameState {
  final String gameId;
  final List<String> board; // length 9, values: "", "X", "O"
  final String? playerXId;
  final String? playerOId;
  final String currentTurn; // "X" or "O"
  final String status; // "waiting_for_player" | "in_progress" | "x_won" | "o_won" | "draw"

  GameState({
    required this.gameId,
    required this.board,
    this.playerXId,
    this.playerOId,
    required this.currentTurn,
    required this.status,
  });

  // Factory constructor for initial game state
  factory GameState.initial(String gameId, String playerXId) {
    return GameState(
      gameId: gameId,
      board: List.filled(9, ''), // 9 empty strings
      playerXId: playerXId,
      playerOId: null,
      currentTurn: 'X',
      status: 'waiting_for_player',
    );
  }

  // Convert GameState to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'gameId': gameId,
      'board': board,
      'playerXId': playerXId,
      'playerOId': playerOId,
      'currentTurn': currentTurn,
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(), // Firestore server timestamp
    };
  }

  // Create GameState from a Firestore DocumentSnapshot
  factory GameState.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GameState(
      gameId: doc.id, // Use document ID as gameId
      board: List<String>.from(data['board'] ?? List.filled(9, '')),
      playerXId: data['playerXId'],
      playerOId: data['playerOId'],
      currentTurn: data['currentTurn'] ?? 'X',
      status: data['status'] ?? 'waiting_for_player',
    );
  }

  // Helper for creating a new GameState instance with updated values.
  // Useful for immutability when updating parts of the state.
  GameState copyWith({
    String? gameId,
    List<String>? board,
    String? playerXId,
    String? playerOId,
    String? currentTurn,
    String? status,
  }) {
    return GameState(
      gameId: gameId ?? this.gameId,
      board: board ?? this.board,
      playerXId: playerXId ?? this.playerXId,
      playerOId: playerOId ?? this.playerOId,
      currentTurn: currentTurn ?? this.currentTurn,
      status: status ?? this.status,
    );
  }
}
