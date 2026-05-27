import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_model.dart';

class ProfileService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Upload avatar to Supabase Storage and return public URL
  Future<String?> uploadAvatar({
    required String userId,
    required String filePath,
  }) async {
    try {
      final file = File(filePath);
      final fileExtension = filePath.split('.').last;
      final path = '$userId/avatar-${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      // Upload file to avatars bucket
      await _supabaseClient.storage.from('avatars').upload(
        path,
        file,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: true,
        ),
      );

      // Get public URL
      final publicUrl = _supabaseClient.storage.from('avatars').getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      print('Error uploading avatar: $e');
      return null;
    }
  }

  // Fetch profile by user ID
  Future<Profile?> getProfile(String userId) async {
    try {
      final response = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      if (response == null) return null;
      return Profile.fromJson(response);
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }

  // Stream profile by user ID to listen to real-time changes
  Stream<Profile?> streamProfile(String userId) {
    return _supabaseClient
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', userId)
        .map((maps) {
          if (maps.isEmpty) return null;
          return Profile.fromJson(maps.first);
        });
  }

  // Update profile
  Future<void> updateProfile({
    required String userId,
    String? fullName,
    String? username,
    String? avatarUrl,
    String? skillLevel,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (fullName != null) updates['full_name'] = fullName;
    if (username != null) updates['username'] = username;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
    if (skillLevel != null) updates['skill_level'] = skillLevel;

    await _supabaseClient.from('profiles').update(updates).eq('id', userId);
  }
}
