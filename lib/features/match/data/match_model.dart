import '../../profile/data/profile_model.dart';
import '../../../../core/widgets/skill_tag.dart';

class CourtModel {
  final String id;
  final String name;
  final String location;
  final String? imageUrl;
  final List<String> amenities;
  final bool isTopRated;

  CourtModel({
    required this.id,
    required this.name,
    required this.location,
    this.imageUrl,
    required this.amenities,
    required this.isTopRated,
  });

  factory CourtModel.fromJson(Map<String, dynamic> json) {
    return CourtModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      imageUrl: json['image_url'] as String?,
      amenities: List<String>.from(json['amenities'] ?? []),
      isTopRated: json['is_top_rated'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'image_url': imageUrl,
      'amenities': amenities,
      'is_top_rated': isTopRated,
    };
  }
}

class MatchModel {
  final String id;
  final String hostId;
  final String? courtId;
  final String title;
  final DateTime dateTime;
  final double durationHours;
  final String skillLevel;
  final int availableSlots;
  final int totalSlots;
  final String? shuttlecockType;
  final double estimatedCost;
  final List<String> amenities;
  final String? hostsNote;
  final String status;
  final String? imageUrl;
  
  // Joined fields
  final Profile? hostProfile;
  final CourtModel? court;
  final List<ParticipantModel>? participants;

  MatchModel({
    required this.id,
    required this.hostId,
    this.courtId,
    required this.title,
    required this.dateTime,
    required this.durationHours,
    required this.skillLevel,
    required this.availableSlots,
    required this.totalSlots,
    this.shuttlecockType,
    required this.estimatedCost,
    required this.amenities,
    this.hostsNote,
    required this.status,
    this.imageUrl,
    this.hostProfile,
    this.court,
    this.participants,
  });

  SkillLevel get skillLevelEnum {
    switch (skillLevel.toLowerCase()) {
      case 'intermediate':
        return SkillLevel.intermediate;
      case 'advanced':
        return SkillLevel.advanced;
      case 'beginner':
      default:
        return SkillLevel.beginner;
    }
  }

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] as String,
      hostId: json['host_id'] as String,
      courtId: json['court_id'] as String?,
      title: json['title'] as String,
      dateTime: DateTime.parse(json['date_time'] as String).toLocal(),
      durationHours: double.tryParse(json['duration_hours'].toString()) ?? 1.0,
      skillLevel: json['skill_level'] as String? ?? 'Beginner',
      availableSlots: json['available_slots'] as int? ?? 0,
      totalSlots: json['total_slots'] as int? ?? 0,
      shuttlecockType: json['shuttlecock_type'] as String?,
      estimatedCost: double.tryParse(json['estimated_cost'].toString()) ?? 0.0,
      amenities: List<String>.from(json['amenities'] ?? []),
      hostsNote: json['hosts_note'] as String?,
      status: json['status'] as String? ?? 'scheduled',
      imageUrl: json['image_url'] as String?,
      hostProfile: json['profiles'] != null 
          ? Profile.fromJson(json['profiles'] as Map<String, dynamic>) 
          : null,
      court: json['courts'] != null 
          ? CourtModel.fromJson(json['courts'] as Map<String, dynamic>) 
          : null,
      participants: json['match_participants'] != null
          ? (json['match_participants'] as List)
              .map((p) => ParticipantModel.fromJson(p as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'host_id': hostId,
      'court_id': courtId,
      'title': title,
      'date_time': dateTime.toUtc().toIso8601String(),
      'duration_hours': durationHours,
      'skill_level': skillLevel,
      'available_slots': availableSlots,
      'total_slots': totalSlots,
      'shuttlecock_type': shuttlecockType,
      'estimated_cost': estimatedCost,
      'amenities': amenities,
      'hosts_note': hostsNote,
      'status': status,
      'image_url': imageUrl,
    };
  }
}

class ParticipantModel {
  final String id;
  final String matchId;
  final String playerId;
  final int team;
  final String status;
  final Profile? playerProfile;

  ParticipantModel({
    required this.id,
    required this.matchId,
    required this.playerId,
    required this.team,
    required this.status,
    this.playerProfile,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      id: json['id'] as String,
      matchId: json['match_id'] as String,
      playerId: json['player_id'] as String,
      team: json['team'] as int? ?? 1,
      status: json['status'] as String? ?? 'pending',
      playerProfile: json['profiles'] != null
          ? Profile.fromJson(json['profiles'] as Map<String, dynamic>)
          : null,
    );
  }
}
