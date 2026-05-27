import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/theme/design_tokens.dart';
import '../providers/scoreboard_provider.dart';

class ScoreboardScreen extends ConsumerWidget {
  const ScoreboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scoreboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Design Colors from Stitch
    final bgColor = isDark ? const Color(0xFF0D0D0F) : const Color(0xFFF5F6F7);
    final cardBg = isDark ? const Color(0xFF131315) : Colors.white;
    final accentColor = isDark ? const Color(0xFFCCFF00) : DesignTokens.primary;
    final secondaryTextColor = isDark
        ? const Color(0xFFADAAAD)
        : const Color(0xFF595C5D);

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, isDark, bgColor, accentColor),
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildMainContent(
              context,
              ref,
              state,
              isDark,
              accentColor,
              cardBg,
              secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    bool isDark,
    Color bgColor,
    Color accentColor,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      backgroundColor: bgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Iconsax.arrow_left_copy,
          color: isDark ? Colors.white : Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          Text(
            'PRECISION COURT',
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : Colors.black,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Iconsax.notification_copy,
            color: colorScheme.onSurface,
            size: 20,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    WidgetRef ref,
    ScoreboardState state,
    bool isDark,
    Color accentColor,
    Color cardBg,
    Color secondaryTextColor,
  ) {
    return Column(
      children: [
        _buildTimerPill(isDark, accentColor, secondaryTextColor),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildPlayerColumn(
                  ref,
                  true,
                  state.scoreA,
                  'Chen Long',
                  isDark,
                  accentColor,
                  cardBg,
                  state.isPlayerAActive,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPlayerColumn(
                  ref,
                  false,
                  state.scoreB,
                  'T. Ying',
                  isDark,
                  accentColor,
                  cardBg,
                  !state.isPlayerAActive,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildBottomControls(
          context,
          ref,
          isDark,
          accentColor,
          secondaryTextColor,
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildTimerPill(
    bool isDark,
    Color accentColor,
    Color secondaryTextColor,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131315) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? const Color(0xFF2C2C2F)
              : Colors.black.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Iconsax.timer_1_copy, color: accentColor, size: 16),
              const SizedBox(width: 8),
              Text(
                '00:34:12',
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          Container(
            height: 16,
            width: 1,
            color: isDark
                ? const Color(0xFF2C2C2F)
                : Colors.black.withOpacity(0.1),
          ),
          Row(
            children: [
              Text(
                'SET',
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFCAFD00),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '2',
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF516700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerColumn(
    WidgetRef ref,
    bool isPlayer1,
    int score,
    String name,
    bool isDark,
    Color accentColor,
    Color cardBg,
    bool isActive,
  ) {
    return Column(
      children: [
        _buildAvatar(isPlayer1, isActive, accentColor, isDark),
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 0.8,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark
                  ? (isActive
                        ? const Color(0xFF131315)
                        : const Color(0xFF1A1A1C))
                  : Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: isActive
                    ? accentColor
                    : (isDark
                          ? const Color(0xFF2C2C2F)
                          : Colors.black.withOpacity(0.05)),
                width: 2,
              ),
              boxShadow: isActive && isDark
                  ? [
                      BoxShadow(
                        color: accentColor.withOpacity(0.15),
                        blurRadius: 30,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                      ),
                    ],
            ),
            child: Center(
              child: Text(
                score.toString(),
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 72,
                  fontWeight: FontWeight.w900,
                  color: isActive
                      ? accentColor
                      : (isDark ? Colors.white : Colors.black),
                  letterSpacing: -2,
                  shadows: isActive && isDark
                      ? [
                          Shadow(
                            color: accentColor.withOpacity(0.5),
                            blurRadius: 15,
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildScoreButton(
          onTap: () => isPlayer1
              ? ref.read(scoreboardProvider.notifier).incrementScoreA()
              : ref.read(scoreboardProvider.notifier).incrementScoreB(),
          isAdd: true,
          isActive: isActive,
          accentColor: accentColor,
          isDark: isDark,
        ),
        const SizedBox(height: 8),
        _buildScoreButton(
          onTap: () => isPlayer1
              ? ref.read(scoreboardProvider.notifier).decrementScoreA()
              : ref.read(scoreboardProvider.notifier).decrementScoreB(),
          isAdd: false,
          isActive: isActive,
          accentColor: accentColor,
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildAvatar(
    bool isPlayer1,
    bool isActive,
    Color accentColor,
    bool isDark,
  ) {
    final playerAccent = isActive
        ? accentColor
        : (isDark ? const Color(0xFF2C2C2F) : const Color(0xFFE0E0E0));
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: playerAccent, width: 4),
        boxShadow: [
          BoxShadow(color: playerAccent.withOpacity(0.3), blurRadius: 15),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          isPlayer1
              ? 'https://lh3.googleusercontent.com/aida-public/AB6AXuDdwNfe5Pk8CTNj2Xxte8vR1A8ZcFt4T7Z_z-g8O1ietGRm3EkNtfAERnKTG3F73BK_Q9u6MqjQ9ihWZVaJsVcztR7LG5I6f3brRIgdZqJXmEV2yQgpfZFrgNnzB3e1CvdUCbJniLOdzzi4dpb0yFB3I_iQ84OaM7e3BA6hkiGnub5ndu0IgE0XQzPlfdgoRG9k-D4JAq1l11NgH0aeEfoTeBS5zFwRgHjs1JPw_9M7Ne00wSZUTmJDPrtalRY8hKTfKPeD2DXBr9A'
              : 'https://lh3.googleusercontent.com/aida-public/AB6AXuBhEXSjQnVyGkJInzoELhUpojzyLi_F5g8dh8ZGBkTJDyA6mRaMnj3qnMnpWv-Fs6gTSSAYgtVoWXl5QBl0BR3GoYNSt783OUthVmTX31jXIrTfjaRp9NENqeFHbe1fB61I4XPup8F0IPUlKHUReCi08blwqunE4KTihGUF4AM7-EOWLu2fNHNNnt3f-Z9Ocpi822MhHf_mviSoFJtdLqry0oxDhSgV0ij4zFSHSdstoFRwcsfU-nn4zFI85PZmWFcXTNDNj_W6pXE',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildScoreButton({
    required VoidCallback onTap,
    required bool isAdd,
    required bool isActive,
    required Color accentColor,
    required bool isDark,
  }) {
    final height = isAdd ? 100.0 : 48.0;
    final bgColor = isAdd
        ? (isActive
              ? accentColor
              : (isDark ? const Color(0xFF1A1A1C) : Colors.white))
        : (isDark ? const Color(0xFF2C2C2F) : const Color(0xFFE6E8EA));
    final iconColor = isAdd
        ? (isActive
              ? (isDark ? const Color(0xFF0D0D0F) : Colors.white)
              : (isDark ? Colors.white : Colors.black))
        : (isDark ? Colors.white : Colors.black);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(isAdd ? 24 : 16),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(isAdd ? 24 : 16),
          border: !isAdd
              ? null
              : (isActive
                    ? null
                    : Border.all(
                        color: isDark
                            ? const Color(0xFF2C2C2F)
                            : Colors.black.withOpacity(0.05),
                      )),
          boxShadow: isAdd
              ? [
                  BoxShadow(
                    color: isActive
                        ? accentColor.withOpacity(0.25)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Icon(
          isAdd ? Icons.add : Icons.remove,
          size: isAdd ? 40 : 24,
          color: iconColor,
        ),
      ),
    );
  }

  Widget _buildBottomControls(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
    Color accentColor,
    Color secondaryTextColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildControlBtn(
                  onTap: () => ref.read(scoreboardProvider.notifier).undo(),
                  icon: Iconsax.undo_copy,
                  label: 'UNDO',
                  isDark: isDark,
                  isLarge: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: _buildControlBtn(
                  onTap: () {},
                  icon: Iconsax.volume_high_copy,
                  label: 'VOICE',
                  isDark: isDark,
                  isLarge: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildFinishButton(context, isDark),
        ],
      ),
    );
  }

  Widget _buildControlBtn({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required bool isDark,
    required bool isLarge,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2F) : const Color(0xFF2C2F30),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            if (isLarge) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.ibmPlexSansThai(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context, bool isDark) {
    final finishBg = isDark ? const Color(0xFF3F1111) : Colors.white;
    final finishText = isDark
        ? const Color(0xFFFF6B6B)
        : const Color(0xFFB02500);

    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: finishBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: finishText.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.stop_circle, color: finishText, size: 20),
            const SizedBox(width: 8),
            Text(
              'Finish Match',
              style: GoogleFonts.ibmPlexSansThai(
                color: finishText,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
