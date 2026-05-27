class Profile {
  final String id;
  final String? username;
  final String? fullName;
  final String? avatarUrl;
  final String skillLevel;
  final int eloRating;
  final int totalMatches;
  final double winRate;
  final String eloTrend;
  final bool isPro;

  Profile({
    required this.id,
    this.username,
    this.fullName,
    this.avatarUrl,
    required this.skillLevel,
    required this.eloRating,
    required this.totalMatches,
    required this.winRate,
    required this.eloTrend,
    required this.isPro,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      username: json['username'] as String?,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      skillLevel: json['skill_level'] as String? ?? 'Beginner',
      eloRating: json['elo_rating'] as int? ?? 1200,
      totalMatches: json['total_matches'] as int? ?? 0,
      winRate: double.tryParse((json['win_rate'] ?? '0.00').toString()) ?? 0.0,
      eloTrend: json['elo_trend'] as String? ?? '+0',
      isPro: json['is_pro'] as bool? ?? false,
    );
  }

  String? get highResAvatarUrl {
    return avatarUrl;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'skill_level': skillLevel,
      'elo_rating': eloRating,
      'total_matches': totalMatches,
      'win_rate': winRate,
      'elo_trend': eloTrend,
      'is_pro': isPro,
    };
  }
}
