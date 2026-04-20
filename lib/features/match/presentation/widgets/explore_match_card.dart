import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/player_avatar_group.dart';
import '../../../../core/widgets/skill_tag.dart';
import '../../../../l10n/generated/app_localizations.dart';

class ExploreMatchCard extends StatelessWidget {
  final String title;
  final String location;
  final String time;
  final String shuttleType;
  final int price;
  final SkillLevel skillLevel;
  final List<String> playerAvatars;
  final int extraPlayers;
  final VoidCallback? onJoin;
  final VoidCallback? onTap;

  const ExploreMatchCard({
    super.key,
    required this.title,
    required this.location,
    required this.time,
    required this.shuttleType,
    required this.price,
    required this.skillLevel,
    this.playerAvatars = const [],
    this.extraPlayers = 0,
    this.onJoin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final onSurface = colorScheme.onSurface;
    final onSurfaceVariant = isDark
        ? DesignTokens.onSurfaceVariantDark
        : DesignTokens.onSurfaceVariant;
    final primaryColor = isDark ? DesignTokens.accentLime : DesignTokens.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? DesignTokens.darkSurfaceVariant : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header: Tag + Title/Location | Price ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkillTag(level: skillLevel),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: onSurface,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Iconsax.location_copy,
                            size: 14,
                            color: onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.ibmPlexSansThai(
                                fontSize: 13,
                                color: onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '฿$price',
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: primaryColor,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      l10n.perPlayer,
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // --- Detail Row: Shuttle + Time ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: onSurfaceVariant.withOpacity(0.1),
                  ),
                  bottom: BorderSide(
                    color: onSurfaceVariant.withOpacity(0.1),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sports_tennis,
                    size: 18,
                    color: primaryColor.withOpacity(0.8),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    shuttleType,
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: onSurface,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 1,
                    height: 16,
                    color: onSurfaceVariant.withOpacity(0.2),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Iconsax.clock_copy,
                    size: 18,
                    color: primaryColor.withOpacity(0.8),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    time,
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: onSurface,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // --- Footer: Avatars + Join Button ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar Stack
                Row(
                  children: [
                    PlayerAvatarGroup(
                      imageUrls: playerAvatars,
                      extraCount: extraPlayers,
                      size: 32,
                    ),
                  ],
                ),

                // Join Button
                ElevatedButton(
                  onPressed: onJoin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? DesignTokens.accentLime
                        : DesignTokens.primary,
                    foregroundColor: isDark ? Colors.black : Colors.white,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    l10n.joinMatch,
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
