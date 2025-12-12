import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tic_tac_toe/models/game_state.dart';

class GameRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Generates a short 6-character game code using A–Z and 0–9.
  String _randomGameId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  // Creates a new game and saves its initial state to Firestore.
  Future<GameState> createGame() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not authenticated.");
    }

    final gameId = _randomGameId();
    final newGame = GameState.initial(gameId, currentUser.uid);

    await _firestore.collection('games').doc(gameId).set(newGame.toMap());
    return newGame;
  }

  // Allows an authenticated user to join an existing game.
  Future<void> joinGame(String gameId) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not authenticated.");
    }

    final gameDocRef = _firestore.collection('games').doc(gameId);
    final gameDoc = await gameDocRef.get();

    if (!gameDoc.exists) {
      throw Exception("Game not found.");
    }

    final gameState = GameState.fromDoc(gameDoc);

    if (gameState.playerOId != null) {
      throw Exception("Game is already full.");
    }

    // Update playerOId and status to in_progress
    await gameDocRef.update({
      'playerOId': currentUser.uid,
      'status': 'in_progress',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Provides a real-time stream of GameState updates for a given game.
  Stream<GameState> watchGame(String gameId) {
    return _firestore.collection('games').doc(gameId).snapshots().map((doc) {
      if (!doc.exists) {
        throw Exception("Game deleted.");
      }
      return GameState.fromDoc(doc);
    });
  }

  // Updates the board, current turn, and status of a specific game.
  Future<void> updateBoard({
    required String gameId,
    required List<String> board,
    required String currentTurn,
    required String status,
  }) async {
    await _firestore.collection('games').doc(gameId).update({
      'board': board,
      'currentTurn': currentTurn,
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
