import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/presentation/widgets/tonal_container.dart';
import '../../../../core/widgets/player_avatar_group.dart';
import '../../../../l10n/generated/app_localizations.dart';

class GameSummaryCard extends StatelessWidget {
  final int gameNumber;
  final String courtName;
  final String status;
  final List<String> teamAImages;
  final String teamAName;
  final int teamAScore;
  final List<String> teamBImages;
  final String teamBName;
  final int teamBScore;
  final int rallies;
  final String duration;
  final int smashes;

  const GameSummaryCard({
    super.key,
    required this.gameNumber,
    required this.courtName,
    required this.status,
    required this.teamAImages,
    required this.teamAName,
    required this.teamAScore,
    required this.teamBImages,
    required this.teamBName,
    required this.teamBScore,
    required this.rallies,
    required this.duration,
    required this.smashes,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isTeamAWinner = teamAScore > teamBScore;
    final isTeamBWinner = teamBScore > teamAScore;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.borderRadiusXl),
        child: Stack(
          children: [
            TonalContainer(
              level: TonalLevel.lowest,
              padding: EdgeInsets.zero,
              borderRadius: DesignTokens.borderRadiusXl,
              child: Stack(
                children: [
                  // Glowing Gradient inside container
                  // Positioned(
                  //   left: isTeamAWinner ? 0 : null,
                  //   right: isTeamBWinner ? 0 : null,
                  //   top: 0,
                  //   bottom: 0,
                  //   width: 150,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           isDark
                  //               ? colorScheme.secondaryContainer.withOpacity(
                  //                   0.1,
                  //                 )
                  //               : colorScheme.primary.withOpacity(0.1),
                  //           Colors.transparent,
                  //         ],
                  //         begin: isTeamAWinner
                  //             ? Alignment.centerLeft
                  //             : Alignment.centerRight,
                  //         end: isTeamAWinner
                  //             ? Alignment.centerRight
                  //             : Alignment.centerLeft,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${l10n.game.toUpperCase()} $gameNumber',
                                  style: GoogleFonts.ibmPlexSansThai(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorScheme.outlineVariant,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  courtName,
                                  style: GoogleFonts.ibmPlexSansThai(
                                    fontSize: 12,
                                    color: colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                            TonalContainer(
                              level: TonalLevel.high,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              borderRadius: 8,
                              child: Text(
                                status,
                                style: GoogleFonts.ibmPlexSansThai(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.outline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Match Score Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Team A
                            SizedBox(
                              width: 100,
                              child: _buildTeam(
                                context,
                                teamAImages,
                                teamAName,
                                isTeamAWinner,
                              ),
                            ),

                            // Score & Bolt
                            Column(
                              children: [
                                Icon(
                                  Icons.bolt,
                                  color: isDark
                                      ? colorScheme.secondaryContainer
                                      : colorScheme.primary,
                                  size: 28,
                                  shadows: [
                                    Shadow(
                                      color: isDark
                                          ? colorScheme.secondaryContainer
                                                .withOpacity(0.5)
                                          : colorScheme.primary.withOpacity(
                                              0.5,
                                            ),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      teamAScore.toString(),
                                      style: GoogleFonts.ibmPlexSansThai(
                                        fontSize: isTeamAWinner ? 36 : 28,
                                        fontWeight: isTeamAWinner
                                            ? FontWeight.w900
                                            : FontWeight.bold,
                                        color: isTeamAWinner
                                            ? colorScheme.onSurface
                                            : colorScheme.outlineVariant,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      child: Text(
                                        '-',
                                        style: GoogleFonts.ibmPlexSansThai(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.outlineVariant,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      teamBScore.toString(),
                                      style: GoogleFonts.ibmPlexSansThai(
                                        fontSize: isTeamBWinner ? 36 : 28,
                                        fontWeight: isTeamBWinner
                                            ? FontWeight.w900
                                            : FontWeight.bold,
                                        color: isTeamBWinner
                                            ? colorScheme.onSurface
                                            : colorScheme.outlineVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Team B
                            SizedBox(
                              width: 100,
                              child: _buildTeam(
                                context,
                                teamBImages,
                                teamBName,
                                isTeamBWinner,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Divider
                        Divider(color: colorScheme.surfaceContainerHigh),
                        const SizedBox(height: 16),

                        // Stats Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              context,
                              rallies.toString(),
                              l10n.rallies.toUpperCase(),
                            ),
                            _buildStatItem(
                              context,
                              duration,
                              l10n.duration.toUpperCase(),
                            ),
                            _buildStatItem(
                              context,
                              smashes.toString(),
                              l10n.smashes.toUpperCase(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Side accent line
            Positioned(
              left: isTeamAWinner ? 0 : null,
              right: isTeamBWinner ? 0 : null,
              top: 0,
              bottom: 0,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? colorScheme.secondaryContainer
                      : colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeam(
    BuildContext context,
    List<String> images,
    String name,
    bool isWinner,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget content = Column(
      children: [
        PlayerAvatarGroup(imageUrls: images, isWinner: isWinner, size: 44),
        const SizedBox(height: 12),
        Text(
          name,
          textAlign: TextAlign.center,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 13,
            fontWeight: isWinner ? FontWeight.bold : FontWeight.w500,
            color: isWinner
                ? colorScheme.onSurface
                : colorScheme.onSurfaceVariant,
            height: 1.2,
          ),
        ),
      ],
    );

    if (!isWinner) {
      content = Opacity(
        opacity: 0.6,
        child: ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: content,
        ),
      );
    }

    return content;
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
            color: colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
