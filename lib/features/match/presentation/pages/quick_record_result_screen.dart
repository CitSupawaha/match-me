import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/presentation/widgets/tonal_container.dart';
import 'scoreboard_screen.dart';

class QuickRecordResultScreen extends ConsumerStatefulWidget {
  const QuickRecordResultScreen({super.key});

  @override
  ConsumerState<QuickRecordResultScreen> createState() =>
      _QuickRecordResultScreenState();
}

class _QuickRecordResultScreenState
    extends ConsumerState<QuickRecordResultScreen> {
  bool isDoubles = true;
  String scoringSystem = 'Best of 3 (21 Points)';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Labels
    const recordMatchLabel = 'Record Match';
    const matchSetupLabel = 'Match Setup';
    const matchTypeLabel = 'Match Type';
    const doublesLabel = 'Doubles';
    const singlesLabel = 'Singles';
    const scoringSystemLabel = 'Scoring System';
    const team1Label = 'Team 1';
    const team2Label = 'Team 2';
    const quickSwitchLabel = 'Quick Switch';
    const selectPlayerLabel = 'Select Player...';
    const recordResultLabel = 'Record Result';

    return Scaffold(
      backgroundColor: isDark
          ? DesignTokens.darkBackground
          : colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, recordMatchLabel),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildMatchSetup(
                    matchSetupLabel,
                    matchTypeLabel,
                    doublesLabel,
                    singlesLabel,
                    scoringSystemLabel,
                    colorScheme,
                  ),
                  const SizedBox(height: 32),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          _buildTeamCard(
                            team1Label,
                            team2Label,
                            quickSwitchLabel,
                            selectPlayerLabel,
                            colorScheme,
                            isDark,
                            true,
                          ),
                          const SizedBox(height: 12),
                          _buildTeamCard(
                            team1Label,
                            team2Label,
                            quickSwitchLabel,
                            selectPlayerLabel,
                            colorScheme,
                            isDark,
                            false,
                          ),
                        ],
                      ),
                      _buildVSDivider(colorScheme),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildActionButton(recordResultLabel, colorScheme),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String recordMatchLabel) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      pinned: true,
      backgroundColor: isDark
          ? DesignTokens.darkBackground
          : const Color(0xFFF5F6F7),
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Iconsax.arrow_left_copy,
          color: isDark ? colorScheme.secondaryContainer : colorScheme.primary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        recordMatchLabel,
        style: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDark ? colorScheme.secondaryContainer : colorScheme.primary,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Iconsax.clock_copy, color: colorScheme.onSurface),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMatchSetup(
    String label,
    String matchTypeLabel,
    String doublesLabel,
    String singlesLabel,
    String scoringLabel,
    ColorScheme colorScheme,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TonalContainer(
      level: isDark ? TonalLevel.low : TonalLevel.lowest,
      padding: const EdgeInsets.all(20),
      borderRadius: DesignTokens.borderRadiusMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? colorScheme.surfaceContainerHigh
                      : colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Court 3',
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            matchTypeLabel,
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildTypeButton(doublesLabel, isDoubles, () {
                  setState(() => isDoubles = true);
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTypeButton(singlesLabel, !isDoubles, () {
                  setState(() => isDoubles = false);
                }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            scoringLabel,
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDark
                  ? colorScheme.surfaceContainerHighest
                  : colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: scoringSystem,
                isExpanded: true,
                icon: const Icon(Icons.expand_more),
                items:
                    [
                      'Best of 3 (21 Points)',
                      'Single Game (21 Points)',
                      'Single Game (31 Points)',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.ibmPlexSansThai(fontSize: 15),
                        ),
                      );
                    }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => scoringSystem = val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String label, bool isSelected, VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
        ),
        child: Text(
          label,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildTeamCard(
    String team1Label,
    String team2Label,
    String quickSwitchLabel,
    String selectPlayerLabel,
    ColorScheme colorScheme,
    bool isDark,
    bool isTeam1,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(DesignTokens.borderRadiusXl),
      child: Stack(
        children: [
          TonalContainer(
            level: isDark ? TonalLevel.low : TonalLevel.lowest,
            padding: const EdgeInsets.all(20),
            borderRadius: DesignTokens.borderRadiusXl,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTeam1 ? team1Label : team2Label,
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Iconsax.refresh_copy, size: 16),
                      label: Text(
                        quickSwitchLabel,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: isDark
                            ? colorScheme.secondaryContainer
                            : colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildPlayerSelector(
                  'Sarah Chen',
                  'Advanced',
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=100',
                  colorScheme,
                ),
                if (isDoubles) ...[
                  const SizedBox(height: 12),
                  _buildPlayerSelector(
                    isTeam1 ? 'David Kim' : selectPlayerLabel,
                    isTeam1 ? 'Intermediate' : '',
                    isTeam1
                        ? 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=100'
                        : null,
                    colorScheme,
                    isEmpty: !isTeam1,
                  ),
                ],
              ],
            ),
          ),
          Positioned(
            left: isTeam1 ? 0 : null,
            right: isTeam1 ? null : 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: isTeam1
                    ? (isDark ? DesignTokens.accentLime : DesignTokens.primary)
                    : (isDark
                          ? colorScheme.surfaceContainerHighest
                          : colorScheme.outlineVariant),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSelector(
    String name,
    String level,
    String? imageUrl,
    ColorScheme colorScheme, {
    bool isEmpty = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.surfaceContainerLow
            : colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surfaceContainerHighest,
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imageUrl == null
                ? Icon(
                    Iconsax.user_add_copy,
                    size: 20,
                    color: colorScheme.onSurfaceVariant,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 14,
                    fontWeight: isEmpty ? FontWeight.w400 : FontWeight.w600,
                    color: isEmpty
                        ? colorScheme.onSurfaceVariant
                        : colorScheme.onSurface,
                    fontStyle: isEmpty ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
                if (level.isNotEmpty)
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: level == 'Advanced'
                              ? colorScheme.primary
                              : Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        level,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Icon(
            Iconsax.arrow_down_1_copy,
            size: 16,
            color: colorScheme.outlineVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildVSDivider(ColorScheme colorScheme) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: isDark ? DesignTokens.darkBackground : colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          'VS',
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, ColorScheme colorScheme) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: isDark ? colorScheme.secondaryContainer : colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScoreboardScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.play_arrow, color: isDark ? Colors.black : Colors.white),
          ],
        ),
      ),
    );
  }
}
