import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/skill_tag.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/explore_match_card.dart';
import '../../../host/presentation/pages/host_match_screen.dart';
import 'match_details_screen.dart';
import '../../../../core/utils/auth_interceptor.dart';
import '../providers/match_provider.dart';
import '../../data/match_model.dart';

class ExploreMatchesScreen extends ConsumerStatefulWidget {
  const ExploreMatchesScreen({super.key});

  @override
  ConsumerState<ExploreMatchesScreen> createState() =>
      _ExploreMatchesScreenState();
}

class _ExploreMatchesScreenState extends ConsumerState<ExploreMatchesScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = isDark
        ? DesignTokens.accentLime
        : DesignTokens.primary;

    final matchesAsync = ref.watch(matchesProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // --- App Bar ---
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor:
                    (isDark ? const Color(0xFF131315) : const Color(0xFFF5F6F7))
                        .withOpacity(0.9),
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: 60,
                title: Text(
                  l10n.exploreMatches,
                  style: GoogleFonts.ibmPlexSansThai(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: isDark ? Colors.white : Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              // --- Search Bar ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: AppSearchBar(hintText: l10n.searchCourtsOrClubs),
                ),
              ),

              // --- Filter Chips ---
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      AppChip(
                        label: l10n.today,
                        isSelected: _selectedFilter == 0,
                        icon: Iconsax.calendar_1_copy,
                        onTap: () => setState(() => _selectedFilter = 0),
                      ),
                      const SizedBox(width: 8),
                      AppChip(
                        label: l10n.skillLevel,
                        isSelected: _selectedFilter == 1,
                        onTap: () => setState(() => _selectedFilter = 1),
                      ),
                      const SizedBox(width: 8),
                      AppChip(
                        label: l10n.distance,
                        isSelected: _selectedFilter == 2,
                        icon: Iconsax.location_copy,
                        onTap: () => setState(() => _selectedFilter = 2),
                      ),
                      const SizedBox(width: 8),
                      AppChip(
                        label: l10n.price,
                        isSelected: _selectedFilter == 3,
                        onTap: () => setState(() => _selectedFilter = 3),
                      ),
                    ],
                  ),
                ),
              ),

              // --- Match Card List ---
              matchesAsync.when(
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Error: $error',
                      style: GoogleFonts.ibmPlexSansThai(color: Colors.red),
                    ),
                  ),
                ),
                data: (matches) {
                  if (matches.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.calendar_copy,
                              size: 64,
                              color: isDark ? Colors.white30 : Colors.black26,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'ยังไม่มีแมตช์การแข่งขันในขณะนี้',
                              style: GoogleFonts.ibmPlexSansThai(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white60 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 200),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final match = matches[index];
                          
                          // Format Time
                          final timeFormat = DateFormat('HH:mm');
                          final dateFormat = DateFormat('d MMM');
                          final startStr = timeFormat.format(match.dateTime);
                          final endStr = timeFormat.format(match.dateTime.add(
                            Duration(minutes: (match.durationHours * 60).toInt()),
                          ));
                          final timeStr = '${dateFormat.format(match.dateTime)}, $startStr - $endStr';

                          // Collect participant avatars
                          final List<String> avatars = [];
                          if (match.participants != null) {
                            for (var p in match.participants!) {
                              if (p.playerProfile?.avatarUrl != null) {
                                avatars.add(p.playerProfile!.avatarUrl!);
                              }
                            }
                          }
                          
                          // If avatars is empty, fallback to host avatar if available
                          if (avatars.isEmpty && match.hostProfile?.avatarUrl != null) {
                            avatars.add(match.hostProfile!.avatarUrl!);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ExploreMatchCard(
                              title: match.title,
                              location: match.court?.name ?? 'ไม่ระบุสนาม',
                              time: timeStr,
                              shuttleType: match.shuttlecockType ?? 'Standard',
                              price: match.estimatedCost.toInt(),
                              skillLevel: match.skillLevelEnum,
                              playerAvatars: avatars,
                              extraPlayers: match.totalSlots - match.availableSlots - avatars.length,
                              onJoin: () {
                                runWithAuth(context, ref, () async {
                                  // Show progress loader dialog
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => const Center(child: CircularProgressIndicator()),
                                  );

                                  final success = await ref
                                      .read(matchServiceProvider)
                                      .joinMatch(match.id);

                                  if (context.mounted) {
                                    Navigator.pop(context); // Pop loading dialog
                                  }

                                  if (success) {
                                    ref.invalidate(matchesProvider);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('เข้าร่วมแมตช์สำเร็จ!'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('ไม่สามารถเข้าร่วมแมตช์ได้ หรือคุณเข้าร่วมอยู่แล้ว'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                });
                              },
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MatchDetailsScreen(matchId: match.id),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        childCount: matches.length,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          // --- Create Match (+) FAB — bottom-right ---
          Positioned(
            right: 20,
            bottom: 150,
            child: FloatingActionButton(
              heroTag: 'createMatch',
              onPressed: () {
                runWithAuth(context, ref, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HostMatchScreen()),
                  );
                });
              },
              backgroundColor: DesignTokens.accentLime,
              foregroundColor: Colors.black,
              elevation: 6,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),

      // --- Map Toggle FAB ---
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButton.extended(
          heroTag: 'mapToggle',
          onPressed: () {},
          backgroundColor: colorScheme.onSurface,
          foregroundColor: colorScheme.surface,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.borderRadiusFull),
          ),
          icon: const Icon(Iconsax.map_1_copy, size: 20),
          label: Text(
            l10n.mapView,
            style: GoogleFonts.ibmPlexSansThai(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

