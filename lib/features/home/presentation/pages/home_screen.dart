import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:match_me/core/theme/design_tokens.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/widgets/section_header.dart';
import '../widgets/hero_match_card.dart';
import '../widgets/stat_metric_card.dart';
import '../widgets/recommended_match_item.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../core/utils/auth_interceptor.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final currentLocale = ref.watch(localeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(userProfileProvider).valueOrNull;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(
            context,
            l10n,
            themeMode,
            currentLocale,
            isDark,
            ref,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  SectionHeader(
                    title: l10n.yourNextMatch,
                    onViewAll: () {},
                  ),
                  const SizedBox(height: 12),
                  HeroMatchCard(
                    title: 'ท้าดวลคู่มือโปร',
                    location: 'Smash It Arena, Sukhumvit',
                    time: 'Today, 19:00 - 21:00',
                    onTap: () {
                      runWithAuth(context, ref, () {
                        // TODO: Navigate to details
                        print('Hero match tapped');
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (user != null) ...[
                    SectionHeader(title: l10n.performance),
                    GridView.count(
                      padding: const EdgeInsets.only(top: 16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.35,
                      children: [
                        StatMetricCard(
                          label: l10n.eloScore,
                          value: profile != null ? profile.eloRating.toString() : '1200',
                          trend: profile != null ? l10n.weekTrend(profile.eloTrend) : l10n.weekTrend('+0'),
                          icon: Iconsax.trend_up_copy,
                          color: colorScheme.secondaryContainer,
                        ),
                        StatMetricCard(
                          label: l10n.played,
                          value: profile != null ? profile.totalMatches.toString() : '0',
                          subtitle: l10n.match,
                          icon: Iconsax.clock_copy,
                        ),
                        StatMetricCard(
                          label: l10n.winRate,
                          value: profile != null ? '${(profile.winRate).toStringAsFixed(0)}%' : '0%',
                          progress: profile != null ? profile.winRate / 100 : 0.0,
                          color: colorScheme.secondaryContainer,
                        ),
                        StatMetricCard(label: l10n.playFrequency, isChart: true),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  SectionHeader(title: l10n.courtsNearby, onViewAll: () {}),
                  const SizedBox(height: 16),
                  const CourtMapCard(),
                  const SizedBox(height: 16),

                  // 4. Recommended Matches Section
                  SectionHeader(
                    title: l10n.recommendedMatches,
                    onViewAll: () {},
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 280,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: [
                          RecommendedMatchItem(
                            title: '${l10n.match} (Level B)',
                            time: 'Mon, 18:00',
                            spotsLeft: 2,
                            location: 'The Court Rama 9',
                            imageUrl:
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuAojd--ZsWCBmSyfTgGMYjG7SoC_UCKmSnD4bMuFh61S11WSddvrYA4hEZ2tFRWLnTCD0CzX41bgxUrrN8_ezCr22mWPKcKKwPI2GzlXzaikWqF3khM3JWU_FbP8XdXAHJjfZov_YQRLzi2iXfxRTxxsHn_QPkfK_ywyxInp14Ddu_nxs68GzkmI7LLoiE9KC0I1W9CJQN8qByyDNe0Sze6XuFxjW_nzwWFuDohuC61N-IHycusIxtf4rlK7NWEV0aWWKNlI6_lzSI',
                            onJoin: () {
                              runWithAuth(context, ref, () {
                                print('Join match 1');
                              });
                            },
                          ),
                          RecommendedMatchItem(
                            title: '${l10n.match} (Chill)',
                            time: 'Tue, 19:30',
                            spotsLeft: 1,
                            location: 'Kinetic Central',
                            isUrgent: true,
                            imageUrl:
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuB_E84ekX3j7aXgbM8MUEGYQBFdChHgU-HvtW5zbxL14fguiN7Vsr1X-7PObJcMLgs0l7bIPbnMHiAW4_xMIKbVXLNgqBbSBTLFVb_oaOHUhwKPeRlNwBCNnYZUA8dgR-mA-D4cSpvps5LkSurGpIuXDw3bP32KlKePZt9VrcjSN260jHDnZnRGOR0uQIEtn7sBS48dxmg8L9utrkMyUvMms8cqOn-QwNR8DdIEUzoALDvxbf_BY5UGPAawlO6r1Q7u0ylEfruLRv8',
                            onJoin: () {
                              runWithAuth(context, ref, () {
                                print('Join match 2');
                              });
                            },
                          ),
                          RecommendedMatchItem(
                            title: 'Buffet 3 hrs',
                            time: 'Wed, 20:00',
                            spotsLeft: 4,
                            location: 'Court Town',
                            imageUrl:
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuDmCuSUG_ix3ROMnKfF7JXdjUhghyws-sWJrMMW2vbByKYlY8skBvIJSBThIOjVy5vdI2FylsIfbNFSnR3P2HsLp0Svf69Y62SBXnQcm5YiwAVJweSBdPL5uMdq4F0HxNQiSgS9U-JCU8HsbFewBuEihrZ8VblIVn359h-Z0lnYHcqR1es1gG_e1891DeqWOgfJ35uYX6Gc8y4LYixIjIQbTboGE6_7zwLgF119xaz5-IjU-aKA1D2tMjJOsikAhM6uGbENggcMwyo',
                            onJoin: () {
                              runWithAuth(context, ref, () {
                                print('Join match 3');
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // Height for BottomNav space
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    AppLocalizations l10n,
    ThemeMode themeMode,
    Locale currentLocale,
    bool isDark,
    WidgetRef ref,
  ) {
    final user = ref.watch(currentUserProvider);
    final profile = ref.watch(userProfileProvider).valueOrNull;
    return SliverAppBar(
      expandedHeight: 80.0,
      floating: true,
      pinned: true,
      backgroundColor: (isDark ? const Color(0xFF131315) : Colors.white)
          .withOpacity(0.8),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    (isDark ? const Color(0xFF2C2C2F) : const Color(0xFFE0E3E4))
                        .withOpacity(0.5),
              ),
            ),
          ),
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Colors.white12 : Colors.black12,
                image: profile?.highResAvatarUrl != null && profile!.highResAvatarUrl!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(profile.highResAvatarUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: profile?.highResAvatarUrl == null || profile!.highResAvatarUrl!.isEmpty
                  ? Icon(
                      Iconsax.user_copy,
                      size: 20,
                      color: isDark ? Colors.white70 : Colors.black54,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user == null
                      ? 'Hi, Guest'
                      : 'Hi, ${profile?.fullName ?? user.email?.split('@').first ?? 'Player'}',
                  style: GoogleFonts.ibmPlexSansThai(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isDark ? Colors.white : const Color(0xFF1A1C1D),
                  ),
                ),
                Text(
                  l10n.readyToPlay,
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 10,
                    color: isDark
                        ? const Color(0xFFA2ABAE)
                        : const Color(0xFF595C5D),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        // IconButton(
        //   icon: const Icon(Iconsax.setting_5_copy, size: 20),
        //   onPressed: () {},
        // ),
        // Language Toggle
        TextButton(
          onPressed: () {
            final nextLocale = currentLocale.languageCode == 'th'
                ? const Locale('en')
                : const Locale('th');
            ref.read(localeProvider.notifier).setLocale(nextLocale);
          },
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: Text(
            currentLocale.languageCode == 'th' ? 'EN' : 'TH',
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1A1C1D),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            themeMode == ThemeMode.dark
                ? Iconsax.sun_1_copy
                : Iconsax.moon_copy,
            size: 20,
          ),
          onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

}

class CourtMapCard extends StatelessWidget {
  const CourtMapCard({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(32),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Map Background (Mock)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.5,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDnS9svwuxx5vcJqapl1eD38owU9-UivOFqq8SGUfZ7k26Ai193jGGkB6iiRlKMK0FE8xLneWCqSY-AVBbdjOjZi-bBozrzeROZp5jLDV6gswre-lVgooP8f9MmaJzfTgNBtO58aXtR9LaPxdUmXKx-lebdWFBTgsf4F-1mSkOfRBn1h36X1dXtOVU0lfYzaglC4zBo-snRS101h2yGBhGoPmac1CKYQ1jVx4EMn08UbSluRhw5mjGSujH_dbNl965jTxd8SYXISMI',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Pins
              Center(
                child: Icon(
                  Iconsax.location_copy,
                  color: isDark
                      ? DesignTokens.accentLime
                      : DesignTokens.primary,
                  size: 32,
                ),
              ),
              // Floating Info
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colorScheme.outline),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark
                              ? colorScheme.secondaryContainer.withOpacity(0.1)
                              : colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Iconsax.discover_copy,
                          color: isDark
                              ? colorScheme.secondaryContainer
                              : colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.findNewCourts,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              l10n.courtsOpenToday(12),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? colorScheme.secondaryContainer
                              : colorScheme.primary,
                          foregroundColor: isDark
                              ? colorScheme.onSecondaryContainer
                              : colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          l10n.openMap,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
