import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/skill_tag.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/explore_match_card.dart';
import '../../../host/presentation/pages/host_match_screen.dart';
import 'match_details_screen.dart';

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
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    color: primaryColor,
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
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 200),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    ExploreMatchCard(
                      title: 'Velocity Open Singles',
                      location: 'Skyline Badminton Club',
                      time: '19:00 - 21:00',
                      shuttleType: 'Yonex AS-30',
                      price: 15,
                      skillLevel: SkillLevel.advanced,
                      playerAvatars: const [
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuARoQQj9ZrgHRExnwwNYjghVclFwyn2_PPAmJ8_wWwJM8g3lvOpyTJ9loQxOeCNcjBhn_RXaaZeyWrKmbTeF_vue03UE7S-uNdbvol6rTpwSaV80_KtXWKfgobVjg4fwpYs7BczKsm753TNvGMAvo72ZypgYVURAKffoNT7T-5nAuqEo1fWwdfxCgxxfT67Ho5JGrnjRKDtOI3UUo6WObbcGBj8iUFJWZPBHS2qb35pITAr0cOJtdcuziOR89DZCWtDLsBhK5XQE0k',
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDuDS-eMvu7bkTi-euUKa7WGngim6QU8AAVS5ricUEr5A4II6R95FOrhXZqBNeZaGk-7NWbxwZGFzhJ1loKXEWnGPPGIzGwkVkc6KHEG-XKhXxNC-rcd2VanMY91i0ML88ZwGG0zVrgeQVRzUUhNpjs8o4_kOX7b64CN8pDUYohUOGUZea8w1P2DwWelmJw2zxcWaNlsoXFS7_PL5c0WMVXy5UcW55sgUwmfpWkaNcrizaSHzkML1BaLGkIo0g2INyQyRD54eTyjXA',
                      ],
                      extraPlayers: 2,
                      onJoin: () {},
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MatchDetailsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ExploreMatchCard(
                      title: 'Morning Rally Doubles',
                      location: 'The Green Arena',
                      time: '08:00 - 10:00',
                      shuttleType: 'RSL No.1',
                      price: 12,
                      skillLevel: SkillLevel.intermediate,
                      playerAvatars: const [
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuB5nr_eXuuKqbZo7VgDSjyxP5Xm6QDxDDbB1KVlToA360v6c8WpCcHrDapTBYHvIppcUDHirlvseXFB0EsCGB9_3H5k7UfW_u0z0T3wGou1siAWNSE26AXP50bR9_cH9akVAOPjalHftekMAsDhRS8bUgmeOdK94qVdjyzzANsMfgMfwyLxBqJpuFGned-PNurahp399mHU2WeOYDWkdCdZpJAM6rEzNIul7F3wB4yu2ric17VSme1n73nPbhPPigjgb8M45Of1ktk',
                      ],
                      onJoin: () {},
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MatchDetailsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ExploreMatchCard(
                      title: 'Casual Sunday Smash',
                      location: 'Downtown Community Hub',
                      time: '16:00 - 18:00',
                      shuttleType: 'Nylon Hybrid',
                      price: 8,
                      skillLevel: SkillLevel.beginner,
                      playerAvatars: const [
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuCubJnoOqKxoqSY0L3TltHzL7MjZ4T7VSIS82EjIsbc5gI3JMPLgYg3Wr9iFlH_9GLK9PajQmzrZMe_waN50BfpdTtY4OhxV2mjaaLd4-au_ZzSiLTVTyL7wNZf8X9VjEZtP5zeKIdeP3SkWpFfQdmqANWbtGSKmrS8LLUR8fN0F-yiv0jdJZCIQreNRVMkXvNUuClKJNwfBqKWmMHeq3_D3ReJCzrBBm_qf7zBZVt3FJIqePIT2Sq5pzwUJUkjgCd2knTYAPZp_aE',
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDc3Hvr4Hq0w85oReI-j6Ox8Cu-SL-dQ6X7qM43No4UeXiXOmeSIdXxC79tFXO7YxB8h8G4jm7XAhrpQIjffpbN4RkjbKaejE3bJk5YjltsLPh-SwUC4MUxygvqod1yDBNWhY_f4hr_Kr_XAlxzARtHHyz2zc5ei0YnT9Kwmhklu4xZXwql-BSRSDUjSq6p4eCXQ_Ndy1ii6zVny7XGuzxxLh3tEbFl_3oBHnEBuD--BTv5rRJPYQdMh13LE9Rr7-J2EQ6PphHEqd4',
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuB05UPZDfi-C0ZgRJvP-Al7ICAm08XY6JCoa1gxuK6uculLsLck5S7_HR-5sznVD3cUmGcQ4zEAuGBg7qNqbyLC5GJZRMD98gtTG0kQzvNa7rf56q2WXCOsW-8xsHBsIM_bo6DwOVWvtD0tOAfY8UBtH_jw-Po5B7UQAlSTp_t_3_guoD_4bQXGT1OFG00rYE3ClxIcr5-bGwewG6imaYfabSYbPBdx29--kb6TnuG6Vx9CLa6rM-3dTt80qmuFVoI0XzMcWrhbuIs',
                      ],
                      onJoin: () {},
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MatchDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  ]),
                ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HostMatchScreen(),
                  ),
                );
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
