import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreboardState {
  final int scoreA;
  final int scoreB;
  final int setsA;
  final int setsB;
  final bool isPlayerAActive;
  final List<({int scoreA, int scoreB, bool isPlayerAActive})> history;
  final bool isFinished;

  ScoreboardState({
    required this.scoreA,
    required this.scoreB,
    required this.setsA,
    required this.setsB,
    required this.isPlayerAActive,
    required this.history,
    this.isFinished = false,
  });

  ScoreboardState copyWith({
    int? scoreA,
    int? scoreB,
    int? setsA,
    int? setsB,
    bool? isPlayerAActive,
    List<({int scoreA, int scoreB, bool isPlayerAActive})>? history,
    bool? isFinished,
  }) {
    return ScoreboardState(
      scoreA: scoreA ?? this.scoreA,
      scoreB: scoreB ?? this.scoreB,
      setsA: setsA ?? this.setsA,
      setsB: setsB ?? this.setsB,
      isPlayerAActive: isPlayerAActive ?? this.isPlayerAActive,
      history: history ?? this.history,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  factory ScoreboardState.initial() {
    return ScoreboardState(
      scoreA: 0,
      scoreB: 0,
      setsA: 0,
      setsB: 0,
      isPlayerAActive: true, // Default to Player A starting
      history: [],
    );
  }
}

class ScoreboardNotifier extends Notifier<ScoreboardState> {
  @override
  ScoreboardState build() => ScoreboardState.initial();

  void incrementScoreA() {
    if (state.isFinished) return;
    final newHistory =
        List<({int scoreA, int scoreB, bool isPlayerAActive})>.from(
          state.history,
        )..add((
          scoreA: state.scoreA,
          scoreB: state.scoreB,
          isPlayerAActive: state.isPlayerAActive,
        ));
    state = state.copyWith(
      scoreA: state.scoreA + 1,
      isPlayerAActive: true,
      history: newHistory,
    );
    _checkGameEnd();
  }

  void incrementScoreB() {
    if (state.isFinished) return;
    final newHistory =
        List<({int scoreA, int scoreB, bool isPlayerAActive})>.from(
          state.history,
        )..add((
          scoreA: state.scoreA,
          scoreB: state.scoreB,
          isPlayerAActive: state.isPlayerAActive,
        ));
    state = state.copyWith(
      scoreB: state.scoreB + 1,
      isPlayerAActive: false,
      history: newHistory,
    );
    _checkGameEnd();
  }

  void decrementScoreA() {
    if (state.scoreA <= 0 || state.isFinished) return;
    final newHistory =
        List<({int scoreA, int scoreB, bool isPlayerAActive})>.from(
          state.history,
        )..add((
          scoreA: state.scoreA,
          scoreB: state.scoreB,
          isPlayerAActive: state.isPlayerAActive,
        ));
    state = state.copyWith(scoreA: state.scoreA - 1, history: newHistory);
  }

  void decrementScoreB() {
    if (state.scoreB <= 0 || state.isFinished) return;
    final newHistory =
        List<({int scoreA, int scoreB, bool isPlayerAActive})>.from(
          state.history,
        )..add((
          scoreA: state.scoreA,
          scoreB: state.scoreB,
          isPlayerAActive: state.isPlayerAActive,
        ));
    state = state.copyWith(scoreB: state.scoreB - 1, history: newHistory);
  }

  void undo() {
    if (state.history.isEmpty) return;
    final last = state.history.last;
    final newHistory =
        List<({int scoreA, int scoreB, bool isPlayerAActive})>.from(
          state.history,
        )..removeLast();
    state = state.copyWith(
      scoreA: last.scoreA,
      scoreB: last.scoreB,
      isPlayerAActive: last.isPlayerAActive,
      history: newHistory,
      isFinished: false,
    );
  }

  void reset() {
    state = ScoreboardState.initial();
  }

  void _checkGameEnd() {
    // Basic logic for 21 points, 2 points lead
    // This can be expanded to handle set wins
    if ((state.scoreA >= 21 || state.scoreB >= 21) &&
        (state.scoreA - state.scoreB).abs() >= 2) {
      // Game ended
      // For now, just mark as finished
      // Real logic would increment sets and reset scores
    }
  }
}

final scoreboardProvider =
    NotifierProvider<ScoreboardNotifier, ScoreboardState>(() {
      return ScoreboardNotifier();
    });
