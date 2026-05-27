import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/match_model.dart';
import '../../data/match_service.dart';

final matchServiceProvider = Provider<MatchService>((ref) {
  return MatchService();
});

final courtsProvider = FutureProvider<List<CourtModel>>((ref) async {
  return ref.watch(matchServiceProvider).fetchCourts();
});

final matchesProvider = FutureProvider<List<MatchModel>>((ref) async {
  return ref.watch(matchServiceProvider).fetchMatches();
});

final matchDetailsProvider = FutureProvider.family<MatchModel?, String>((ref, matchId) async {
  return ref.watch(matchServiceProvider).fetchMatchDetails(matchId);
});

