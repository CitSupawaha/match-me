import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/game_summary_card.dart';
import 'quick_record_result_screen.dart';

class MatchResultsScreen extends ConsumerStatefulWidget {
  const MatchResultsScreen({super.key});

  @override
  ConsumerState<MatchResultsScreen> createState() => _MatchResultsScreenState();
}

class _MatchResultsScreenState extends ConsumerState<MatchResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [_buildAppBar(context, l10n), _buildResultsList(l10n)],
      ),
      bottomNavigationBar: _buildBottomAction(l10n),
    );
  }

  Widget _buildAppBar(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      pinned: true,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Iconsax.arrow_left_copy, color: colorScheme.onSurface),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'Casual Match - 24 May',
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          Text(
            '24 พ.ค. 2567  •  KINETIC CENTRAL',
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 11,
              color: colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(AppLocalizations l10n) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          GameSummaryCard(
            gameNumber: 3,
            courtName: '${l10n.court} 4',
            status: 'Finished 5 mins ago',
            teamAImages: const [
              'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=100',
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=100',
            ],
            teamAName: 'Marcus & Lina',
            teamAScore: 21,
            teamBImages: const [
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100',
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=100',
            ],
            teamBName: 'Tom & Jane',
            teamBScore: 15,
            rallies: 32,
            duration: '18m',
            smashes: 9,
          ),
          GameSummaryCard(
            gameNumber: 2,
            courtName: '${l10n.court} 4',
            status: 'Finished 35 mins ago',
            teamAImages: const [
              'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=100',
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=100',
            ],
            teamAName: 'Marcus & Lina',
            teamAScore: 19,
            teamBImages: const [
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=100',
              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=100',
            ],
            teamBName: 'Sarah & Mike',
            teamBScore: 21,
            rallies: 45,
            duration: '22m',
            smashes: 14,
          ),
          GameSummaryCard(
            gameNumber: 1,
            courtName: '${l10n.court} 4',
            status: 'Finished 1 hr ago',
            teamAImages: const [
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=100',
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=100',
            ],
            teamAName: 'Tom & Jane',
            teamAScore: 12,
            teamBImages: const [
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=100',
              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=100',
            ],
            teamBName: 'Sarah & Mike',
            teamBScore: 21,
            rallies: 28,
            duration: '15m',
            smashes: 5,
          ),
          const SizedBox(height: 100),
        ]),
      ),
    );
  }

  Widget _buildBottomAction(AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: BoxDecoration(
        color: (isDark ? const Color(0xFF131315) : colorScheme.surface)
            .withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuickRecordResultScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark ? colorScheme.secondaryContainer : colorScheme.primary,
          foregroundColor: isDark
              ? colorScheme.onSecondaryContainer
              : colorScheme.onPrimary,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bolt, size: 24),
            const SizedBox(width: 8),
            Text(
              l10n.createNextGame,
              style: GoogleFonts.ibmPlexSansThai(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
