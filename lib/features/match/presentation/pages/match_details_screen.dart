import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:ui';
import 'dart:math' as import_math;

import '../../../../core/theme/design_tokens.dart';
import 'match_results_screen.dart';

class MatchDetailsScreen extends StatelessWidget {
  const MatchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = isDark
        ? DesignTokens.accentLime
        : DesignTokens.primary;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF131315) : colorScheme.surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context, isDark, colorScheme, primaryColor),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeroImage(context, isDark),
                Transform.translate(
                  offset: const Offset(0, -32),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleCard(context, isDark, primaryColor),
                        const SizedBox(height: 32),
                        _buildLogisticsSection(context, isDark, primaryColor),
                        const SizedBox(height: 32),
                        _buildHighlightsGrid(context, isDark, primaryColor),
                        const SizedBox(height: 32),
                        _buildSquadSection(context, isDark, primaryColor),
                        const SizedBox(height: 32),
                        _buildHostNote(context, isDark, primaryColor),
                        const SizedBox(
                          height: 120,
                        ), // Padding for sticky bottom button
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildStickyBottomBar(context, isDark, primaryColor),
    );
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
  ) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: isDark
          ? DesignTokens.darkBackground
          : const Color(0xFFF5F6F7),
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Iconsax.arrow_left_copy,
          color: isDark ? colorScheme.secondaryContainer : colorScheme.primary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        'Match Details',
        style: GoogleFonts.ibmPlexSansThai(
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Iconsax.clock_copy, color: colorScheme.onSurface),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.share, color: colorScheme.onSurface),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, bool isDark) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?q=80&w=2670&auto=format&fit=crop',
            fit: BoxFit.cover,
          ),
          // Gradient Overlay
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  isDark
                      ? const Color(0xFF131315)
                      : Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ColorScheme colorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  Widget _buildTitleCard(
    BuildContext context,
    bool isDark,
    Color primaryColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ]
            : DesignTokens.softLift,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Casual Match - 24 May',
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 24, // matched to text-3xl
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag(
                text: 'INTERMEDIATE',
                color: primaryColor,
                isDark: isDark,
              ),
              _buildTag(
                text: 'RSL SILVER',
                color: isDark ? Colors.white30 : Colors.black26,
                isDark: isDark,
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MatchResultsScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  'ดูผลการแข่งทั้งหมด',
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.chevron_right, size: 20, color: primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag({
    required String text,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.ibmPlexSansThai(
          fontSize: 12, // matched to text-xs
          fontWeight: FontWeight.bold,
          color: color == Colors.white30
              ? (isDark ? Colors.white70 : Colors.black87)
              : color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildLogisticsSection(
    BuildContext context,
    bool isDark,
    Color primaryColor,
  ) {
    return Column(
      children: [
        _buildLogisticRow(
          icon: Iconsax.calendar_1_copy,
          title: '24 พ.ค. 2567',
          isDark: isDark,
          primaryColor: primaryColor,
        ),
        const SizedBox(height: 20),
        _buildLogisticRow(
          icon: Iconsax.clock_copy,
          title: '18:00 - 20:00 (2 ชม.)',
          isDark: isDark,
          primaryColor: primaryColor,
          isSubtitle: true,
        ),
        const SizedBox(height: 20),
        _buildLogisticRow(
          icon: Iconsax.location_copy,
          title: 'Kinetic Central (คอร์ท 4)',
          subtitle: 'Bangkok, Thailand',
          isDark: isDark,
          primaryColor: primaryColor,
          actionText: 'ดูแผนที่',
        ),
      ],
    );
  }

  Widget _buildLogisticRow({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool isDark,
    required Color primaryColor,
    bool isSubtitle = false,
    String? actionText,
  }) {
    return Row(
      crossAxisAlignment: subtitle != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Icon(icon, color: primaryColor, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 18, // matched to text-lg
                  fontWeight: isSubtitle ? FontWeight.w500 : FontWeight.bold,
                  color: isSubtitle
                      ? (isDark ? Colors.white54 : Colors.black54)
                      : (isDark ? Colors.white : Colors.black87),
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      subtitle,
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 14,
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                    ),
                    if (actionText != null) ...[
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 1),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: primaryColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                          child: Text(
                            actionText,
                            style: GoogleFonts.ibmPlexSansThai(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightsGrid(
    BuildContext context,
    bool isDark,
    Color primaryColor,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? DesignTokens.darkSurfaceVariant
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRICE',
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '150',
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'THB / คน',
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark
                    ? DesignTokens.darkSurfaceVariant
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AMENITIES',
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildAmenityIcon(Icons.ac_unit, 'แอร์', isDark),
                      const SizedBox(width: 20),
                      _buildAmenityIcon(Icons.layers, 'พื้นยาง', isDark),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityIcon(IconData icon, String label, bool isDark) {
    return Column(
      children: [
        Icon(icon, size: 24, color: isDark ? Colors.white54 : Colors.black54),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white54 : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildSquadSection(
    BuildContext context,
    bool isDark,
    Color primaryColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'รายชื่อผู้เล่น',
              style: GoogleFonts.ibmPlexSansThai(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Text(
                'เหลือที่เดียว!',
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 20,
          runSpacing: 24,
          clipBehavior: Clip.none,
          children: [
            _buildSquadPlayer(
              imageUrl:
                  'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=200&auto=format&fit=crop',
              name: 'Marcus',
              isHost: true,
              primaryColor: primaryColor,
              isDark: isDark,
            ),
            _buildSquadPlayer(
              imageUrl:
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
              name: 'Lina',
              isDark: isDark,
              primaryColor: primaryColor,
            ),
            _buildSquadPlayer(
              imageUrl:
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
              name: 'Tom',
              isDark: isDark,
              primaryColor: primaryColor,
            ),
            _buildSquadPlayer(
              imageUrl:
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
              name: 'Jane',
              isDark: isDark,
              primaryColor: primaryColor,
            ),
            _buildEmptySquadSlot(isDark),
          ],
        ),
      ],
    );
  }

  Widget _buildSquadPlayer({
    required String imageUrl,
    required String name,
    bool isHost = false,
    required Color primaryColor,
    required bool isDark,
  }) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isHost ? primaryColor : Colors.transparent,
                  width: isHost ? 3 : 0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            if (!isHost)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 14,
                  ), // matched sizes
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 12,
            fontWeight: isHost ? FontWeight.bold : FontWeight.w500,
            color: isHost
                ? (isDark ? Colors.white : Colors.black87)
                : (isDark ? Colors.white54 : Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptySquadSlot(bool isDark) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          ),
          child: CustomPaint(
            painter: DashedCirclePainter(
              color: isDark ? Colors.white30 : Colors.black26,
            ),
            child: Center(
              child: Text(
                '+1 ว่าง',
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Open',
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 12,
            color: isDark ? Colors.white54 : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildHostNote(BuildContext context, bool isDark, Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
        ),
        boxShadow: isDark ? [] : DesignTokens.softLift,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19), // Accounts for 1px border
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: primaryColor, width: 4)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.sticky_note_2, color: primaryColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "HOST'S NOTE",
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'ตีชิลๆ เน้นออกกำลังกาย ไม่ซีเรียสครับ',
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 15,
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStickyBottomBar(
    BuildContext context,
    bool isDark,
    Color primaryColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: (isDark ? const Color(0xFF131315) : colorScheme(context).surface)
            .withOpacity(0.9), // 90% opacity from HTML
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: isDark ? Colors.black : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    DesignTokens.borderRadiusXl,
                  ),
                ),
                elevation: 0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Join Match',
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.bolt, size: 22),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '(150 THB เก็บที่สนาม)',
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 10, // matched to text-[10px]
                      fontWeight: FontWeight.w500,
                      color: (isDark ? Colors.black : Colors.white).withOpacity(
                        0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Simple dashed circle painter for empty slot
class DashedCirclePainter extends CustomPainter {
  final Color color;
  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(radius, radius);

    // So let's draw a solid semi-transparent circle for now or manual short arcs
    for (double i = 0; i < 360; i += 15) {
      final x1 = center.dx + radius * 0.95 * (dart_math_cos(i));
      final y1 = center.dy + radius * 0.95 * (dart_math_sin(i));
      final x2 = center.dx + radius * 0.95 * (dart_math_cos(i + 8));
      final y2 = center.dy + radius * 0.95 * (dart_math_sin(i + 8));
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  double dart_math_cos(double degrees) =>
      import_math.cos(degrees * import_math.pi / 180);
  double dart_math_sin(double degrees) =>
      import_math.sin(degrees * import_math.pi / 180);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
