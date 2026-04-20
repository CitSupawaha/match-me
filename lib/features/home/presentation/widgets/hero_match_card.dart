import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:match_me/core/theme/design_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';

class HeroMatchCard extends StatelessWidget {
  static const accentLime = Color(0xFFCCFF00);
  static const emerald950 = Color(0xFF022C16);
  static const emerald900 = Color(0xFF064E3B);

  final String title;
  final String? location;
  final String? time;

  const HeroMatchCard({
    super.key,
    required this.title,
    this.location,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isDark =
            Theme.of(context).brightness ==
            Brightness
                .dark; // Responsive values scaled down for modern mobile look
        final titleFontSize = (screenWidth * 0.065).clamp(20.0, 28.0);
        final padding = (screenWidth * 0.06).clamp(16.0, 24.0);
        final cardHeight = (screenWidth * 0.75).clamp(240.0, 320.0);
        final watermarkSize = (screenWidth * 0.35).clamp(120.0, 180.0);

        return Container(
          constraints: BoxConstraints(minHeight: cardHeight),
          decoration: BoxDecoration(
            color: isDark ? accentLime : emerald900,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Background Graphic (Watermark) - Bottom Right as per design
              Positioned(
                top: 20,
                right: 10,
                child: Opacity(
                  opacity: 0.15,
                  child: Icon(
                    Icons.sports_tennis,
                    size: watermarkSize,
                    color: isDark ? emerald950 : Colors.white,
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Section: Pulse Badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PulseBadge(
                          label: time ?? l10n.startInMinutes(45),
                          color: emerald950,
                        ),
                        SizedBox(height: padding * 0.6),

                        // Title & Subtitle
                        Text(
                          title,
                          style: GoogleFonts.ibmPlexSansThai(
                            color: isDark ? emerald950 : Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          location ?? 'Bangkapi Badminton Club • คอร์ท 4',
                          style: GoogleFonts.ibmPlexSansThai(
                            color: isDark ? emerald950 : Colors.white,
                            fontSize: (titleFontSize * 0.5).clamp(12.0, 14.0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: padding * 0.6),

                        // Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildTag(
                              Colors.white.withOpacity(0.8),
                              emerald950,
                              l10n.levelIntermediate,
                            ),
                            _buildTag(
                              Colors.white.withOpacity(0.5),
                              emerald950,
                              '2 กม.',
                              icon: Icons.location_on_outlined,
                            ),
                            _buildTag(
                              Colors.white.withOpacity(0.5),
                              emerald950,
                              'ห้องแอร์',
                              icon: Icons.ac_unit,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Bottom Section: Avatar Stack and CTA Button
                    Column(
                      children: [
                        Row(
                          children: [
                            _AvatarStack(),
                            const SizedBox(width: 8),
                            Text(
                              l10n.friendsPlaying(2),
                              style: GoogleFonts.ibmPlexSansThai(
                                color: isDark ? Colors.black : Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Full Width CTA Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? DesignTokens.darkSurface
                                  : DesignTokens.accentLime,
                              foregroundColor: isDark
                                  ? Colors.white
                                  : Colors.black,
                              elevation: 2,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              l10n.matchDetails,
                              style: GoogleFonts.ibmPlexSansThai(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTag(Color bg, Color text, String label, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: emerald950.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: text),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.ibmPlexSansThai(
              color: text,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseBadge extends StatefulWidget {
  final String label;
  final Color color;

  const _PulseBadge({required this.label, required this.color});

  @override
  State<_PulseBadge> createState() => _PulseBadgeState();
}

class _PulseBadgeState extends State<_PulseBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(99),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: _animation,
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFFF4D4D), // Red pulse as per design
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            widget.label.toUpperCase(),
            style: GoogleFonts.ibmPlexSansThai(
              color: widget.color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 28,
      child: Stack(
        children: [
          _buildAvatar(0),
          Positioned(left: 14, child: _buildAvatar(1)),
          Positioned(left: 28, child: _buildAvatar(2)),
        ],
      ),
    );
  }

  Widget _buildAvatar(int index) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.grey[400 + (index * 100)],
        shape: BoxShape.circle,
        border: Border.all(color: HeroMatchCard.accentLime, width: 2),
      ),
    );
  }
}
