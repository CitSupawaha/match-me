import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'match_model.dart';

class MatchService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Fetch all courts from courts table
  Future<List<CourtModel>> fetchCourts() async {
    try {
      final response = await _supabaseClient
          .from('courts')
          .select()
          .order('name', ascending: true);
      
      return (response as List)
          .map((json) => CourtModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching courts: $e');
      return [];
    }
  }

  // Fetch all matches from matches table, including host profile, court details, and participants
  Future<List<MatchModel>> fetchMatches() async {
    try {
      final response = await _supabaseClient
          .from('matches')
          .select('*, courts(*), profiles(*), match_participants(*, profiles(*))')
          .neq('status', 'cancelled')
          .order('date_time', ascending: true);

      return (response as List)
          .map((json) => MatchModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching matches: $e');
      return [];
    }
  }

  // Create a new match and auto-add host as a participant
  Future<MatchModel?> createMatch({
    required String title,
    required String? courtId,
    required DateTime dateTime,
    required double durationHours,
    required String skillLevel,
    required int totalSlots,
    required String? shuttlecockType,
    required double estimatedCost,
    required List<String> amenities,
    required String? hostsNote,
    String? imageUrl,
  }) async {
    try {
      final hostId = _supabaseClient.auth.currentUser?.id;
      if (hostId == null) {
        throw Exception('User must be logged in to host a match');
      }

      // 1. Insert Match
      final matchData = {
        'host_id': hostId,
        'court_id': courtId,
        'title': title,
        'date_time': dateTime.toUtc().toIso8601String(),
        'duration_hours': durationHours,
        'skill_level': skillLevel,
        'available_slots': totalSlots - 1, // Exclude the host
        'total_slots': totalSlots,
        'shuttlecock_type': shuttlecockType,
        'estimated_cost': estimatedCost,
        'amenities': amenities,
        'hosts_note': hostsNote,
        'status': 'scheduled',
        'image_url': imageUrl,
      };

      final newMatchResponse = await _supabaseClient
          .from('matches')
          .insert(matchData)
          .select()
          .single();

      final matchId = newMatchResponse['id'] as String;

      // 2. Auto-add host as confirmed participant
      await _supabaseClient.from('match_participants').insert({
        'match_id': matchId,
        'player_id': hostId,
        'team': 1,
        'status': 'confirmed',
      });

      // 3. Return full MatchModel by querying again (to include joined relations)
      final fullMatchData = await _supabaseClient
          .from('matches')
          .select('*, courts(*), profiles(*), match_participants(*, profiles(*))')
          .eq('id', matchId)
          .single();

      return MatchModel.fromJson(fullMatchData);
    } catch (e) {
      print('Error creating match: $e');
      return null;
    }
  }

  // Join an existing match
  Future<bool> joinMatch(String matchId) async {
    try {
      final playerId = _supabaseClient.auth.currentUser?.id;
      if (playerId == null) {
        throw Exception('User must be logged in to join a match');
      }

      // Check if already a participant
      final existing = await _supabaseClient
          .from('match_participants')
          .select()
          .eq('match_id', matchId)
          .eq('player_id', playerId)
          .maybeSingle();

      if (existing != null) {
        // Already joined
        return true;
      }

      // Insert new participant
      await _supabaseClient.from('match_participants').insert({
        'match_id': matchId,
        'player_id': playerId,
        'team': 1,
        'status': 'confirmed',
      });

      // Decrement available slots in the match
      final match = await _supabaseClient
          .from('matches')
          .select('available_slots')
          .eq('id', matchId)
          .single();

      final currentAvailable = match['available_slots'] as int;
      if (currentAvailable > 0) {
        await _supabaseClient
            .from('matches')
            .update({'available_slots': currentAvailable - 1})
            .eq('id', matchId);
      }

      return true;
    } catch (e) {
      print('Error joining match: $e');
      return false;
    }
  }

  // Fetch a single match details by ID
  Future<MatchModel?> fetchMatchDetails(String matchId) async {
    try {
      final response = await _supabaseClient
          .from('matches')
          .select('*, courts(*), profiles(*), match_participants(*, profiles(*))')
          .eq('id', matchId)
          .single();

      return MatchModel.fromJson(response);
    } catch (e) {
      print('Error fetching match details: $e');
      return null;
    }
  }

  // Cancel a match hosted by the current user
  Future<bool> cancelMatch(String matchId) async {
    try {
      final currentUserId = _supabaseClient.auth.currentUser?.id;
      if (currentUserId == null) throw Exception('User must be logged in to cancel a match');

      await _supabaseClient
          .from('matches')
          .update({'status': 'cancelled'})
          .eq('id', matchId)
          .eq('host_id', currentUserId);

      return true;
    } catch (e) {
      print('Error cancelling match: $e');
      return false;
    }
  }

  // Update match cover image URL in the database
  Future<bool> updateMatchImageUrl({
    required String matchId,
    required String imageUrl,
  }) async {
    try {
      final currentUserId = _supabaseClient.auth.currentUser?.id;
      if (currentUserId == null) throw Exception('User must be logged in to update match image');

      await _supabaseClient
          .from('matches')
          .update({'image_url': imageUrl})
          .eq('id', matchId)
          .eq('host_id', currentUserId);

      return true;
    } catch (e) {
      print('Error updating match image URL: $e');
      return false;
    }
  }

  // Upload match cover image to Supabase Storage and return public URL
  Future<String?> uploadMatchImage({
    required String filePath,
  }) async {
    try {
      final file = File(filePath);
      final fileExtension = filePath.split('.').last;
      final fileName = 'match-${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      // Upload file to matches bucket
      await _supabaseClient.storage.from('matches').upload(
        fileName,
        file,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: true,
        ),
      );

      // Get public URL
      final publicUrl = _supabaseClient.storage.from('matches').getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      print('Error uploading match image: $e');
      return null;
    }
  }
}

