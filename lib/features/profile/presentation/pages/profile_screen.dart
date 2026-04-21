import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/generated/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // Stitch Colors
    final primaryColor = isDark
        ? const Color(0xFFCCFF00)
        : const Color(0xFF006a3c);
    final onPrimaryColor = isDark
        ? const Color(0xFF131315)
        : const Color(0xFFcbffd8);
    final surfaceContainer = isDark
        ? const Color(0xFF1c1c1e)
        : const Color(0xFFeff1f2);
    final secondaryFixed = const Color(0xFFc3f400);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF131315)
          : const Color(0xFFf5f6f7),
      appBar: _buildAppBar(context, isDark, primaryColor, l10n),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileIntro(context, isDark, primaryColor, secondaryFixed),
              const SizedBox(height: 32),
              _buildStatsGrid(
                context,
                isDark,
                primaryColor,
                onPrimaryColor,
                surfaceContainer,
                l10n,
              ),
              const SizedBox(height: 32),
              _buildSectionTitle(l10n.matchResults, isDark),
              const SizedBox(height: 16),
              _buildMatchHistory(context, isDark, primaryColor),
              const SizedBox(height: 32),
              _buildSectionTitle('การตั้งค่า', isDark),
              const SizedBox(height: 16),
              _buildSettingsMenu(
                context,
                isDark,
                primaryColor,
                surfaceContainer,
              ),
              const SizedBox(height: 24),
              _buildLogoutButton(context, isDark),
              const SizedBox(height: 100), // Bottom nav space
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    bool isDark,
    Color primaryColor,
    AppLocalizations l10n,
  ) {
    return AppBar(
      backgroundColor:
          (isDark ? const Color(0xFF131315) : const Color(0xFFf5f6f7))
              .withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      title: Text(
        'PLAYER PROFILE',
        style: GoogleFonts.ibmPlexSansThai(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: primaryColor,
          letterSpacing: 1.2,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Iconsax.setting_2_copy,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildProfileIntro(
    BuildContext context,
    bool isDark,
    Color primaryColor,
    Color secondaryFixed,
  ) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Glow Effect
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? primaryColor : secondaryFixed).withOpacity(
                      0.4,
                    ),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            // Avatar
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? primaryColor : secondaryFixed,
                  width: 4,
                ),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAy2ZFeJJNxkU1Z_uJmmCJulXo-WNIf52OFa1Pc3g2BURaqy9Szg3E4UDJVfXra7Pz1JfPneBBCCuF2YonF4z31BjEEmDe_6vD8L_Z744OjEO9HEHbcjS1gUaeT9ZHU868BDdZ1PnkI7s7v4Hrg2Poq_0lgUNAv3aGQnDXUyjMEH895h3rhZyeKBwv3ttkPKfILuYr-0hD5tGu_gTOA-RWiZHpWmAZQs-W7tbIr8UAhLqNAGhyv-FPycrRPpCJ1cYYtpLmXm52JTlk',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // PRO Badge
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2c3b00) : primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? const Color(0xFF131315) : Colors.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  'PRO',
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: isDark ? const Color(0xFFd7ff33) : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Teerasak S.',
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color:
                      (isDark
                              ? const Color(0xFF516700)
                              : const Color(0xFFc3f400))
                          .withOpacity(isDark ? 1.0 : 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ระดับกลาง / Intermediate',
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? const Color(0xFFe1ff66)
                        : const Color(0xFF455900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(
    BuildContext context,
    bool isDark,
    Color primaryColor,
    Color onPrimaryColor,
    Color surfaceContainer,
    AppLocalizations l10n,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double gridSpacing = 12.0;
        final boxSize = (constraints.maxWidth - gridSpacing) / 2;
        return Wrap(
          spacing: gridSpacing,
          runSpacing: gridSpacing,
          children: [
            // ELO Rating
            _buildStatBox(
              isDark,
              'ELO RATING',
              '1,420',
              boxSize,
              surfaceContainer,
              bottomWidget: Row(
                children: [
                  Text(
                    '+12 pts',
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  _buildMiniTrend(primaryColor),
                ],
              ),
            ),
            // Win Rate (Highlighted)
            _buildStatBox(
              isDark,
              'WIN RATE',
              '68%',
              boxSize,
              primaryColor,
              isHighlighted: true,
              onPrimary: onPrimaryColor,
              bottomWidget: Icon(
                Iconsax.trend_up_copy,
                color: isDark ? onPrimaryColor : const Color(0xFFc3f400),
                size: 18,
              ),
            ),
            // Total Matches
            _buildStatBox(
              isDark,
              'TOTAL MATCHES',
              '42',
              boxSize,
              surfaceContainer,
              bottomWidget: Text(
                '32 ชนะ / 10 แพ้',
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
            // Weekly Activity
            _buildStatBox(
              isDark,
              'WEEKLY ACTIVITY',
              '', // Move text to bottom list
              boxSize,
              surfaceContainer,
              bottomWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildActivityChart(primaryColor, isDark),
                  const SizedBox(height: 12),
                  Text(
                    '14 ชั่วโมง สัปดาห์นี้',
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatBox(
    bool isDark,
    String label,
    String value,
    double size,
    Color bgColor, {
    bool isHighlighted = false,
    Color? onPrimary,
    Widget? bottomWidget,
  }) {
    final textColor = isHighlighted
        ? (isDark ? const Color(0xFF131315) : Colors.white)
        : (isDark ? Colors.white : Colors.black);
    final labelColor = isHighlighted
        ? (isDark ? const Color(0xFF131315).withOpacity(0.7) : Colors.white70)
        : (isDark ? Colors.white54 : Colors.grey[600]);

    return Container(
      width: size,
      height: size * 0.95,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: !isHighlighted && isDark
            ? Border.all(color: Colors.white.withOpacity(0.1))
            : null,
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: bgColor.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: labelColor,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              ),
            ],
          ),
          if (bottomWidget != null) bottomWidget,
        ],
      ),
    );
  }

  Widget _buildMiniTrend(Color primary) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _trendBar(0.3, primary.withOpacity(0.3)),
        const SizedBox(width: 2),
        _trendBar(0.5, primary.withOpacity(0.5)),
        const SizedBox(width: 2),
        _trendBar(0.8, primary.withOpacity(0.8)),
        const SizedBox(width: 2),
        _trendBar(1.0, primary),
      ],
    );
  }

  Widget _trendBar(double heightFactor, Color color) {
    return Container(
      width: 5,
      height: 14 * heightFactor,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildActivityChart(Color primary, bool isDark) {
    // Data matching the visual representation in the design image
    final bars = [
      {
        'val': 0.35,
        'color': isDark ? primary.withOpacity(0.5) : const Color(0xFF9af3b8),
      }, // Mon
      {'val': 0.65, 'color': primary}, // Tue
      {
        'val': 0.30,
        'color': isDark ? primary.withOpacity(0.5) : const Color(0xFF9af3b8),
      }, // Wed
      {'val': 1.00, 'color': primary}, // Thu
      {'val': 0.55, 'color': primary}, // Fri
      {
        'val': 0.20,
        'color': isDark ? Colors.white10 : const Color(0xFFE0E0E0),
      }, // Sat (Gray dot)
      {
        'val': 0.10,
        'color': isDark ? Colors.white10 : const Color(0xFFE0E0E0),
      }, // Sun (Gray line)
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: bars
          .map(
            (bar) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Container(
                width: 10,
                height: 40 * (bar['val'] as double),
                decoration: BoxDecoration(
                  color: bar['color'] as Color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Divider(color: isDark ? Colors.white10 : Colors.black12),
        ),
      ],
    );
  }

  Widget _buildMatchHistory(BuildContext context, bool isDark, Color primary) {
    return Column(
      children: [
        _buildHistoryItem(
          isDark,
          primary,
          'Casual Match',
          'Kinetic Central',
          '24 Oct 2023',
          'WIN',
          '+15 ELO',
          true,
        ),
        const SizedBox(height: 12),
        _buildHistoryItem(
          isDark,
          primary,
          'Ranked Match',
          'Siam Arena',
          '21 Oct 2023',
          'LOSS',
          '-8 ELO',
          false,
        ),
      ],
    );
  }

  Widget _buildHistoryItem(
    bool isDark,
    Color primary,
    String title,
    String venue,
    String date,
    String status,
    String eloChange,
    bool isWin,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1c1c1e) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.03),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2c2c2f) : const Color(0xFFf5f6f7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isWin ? Iconsax.cup_copy : Iconsax.judge_copy,
              color: primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  '$venue • $date',
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 11,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isWin
                      ? primary.withOpacity(0.2)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: isWin ? (isDark ? primary : primary) : Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                eloChange,
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isWin ? primary : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsMenu(
    BuildContext context,
    bool isDark,
    Color primary,
    Color surfaceContainer,
  ) {
    final settings = [
      {'icon': Iconsax.user_edit_copy, 'label': 'แก้ไขโปรไฟล์'},
      {'icon': Iconsax.card_copy, 'label': 'การสมัครสมาชิก'},
      {'icon': Iconsax.notification_bing_copy, 'label': 'การแจ้งเตือน'},
      {'icon': Iconsax.info_circle_copy, 'label': 'ความช่วยเหลือ'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1c1c1e)
            : surfaceContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: settings
            .map(
              (s) => ListTile(
                leading: Icon(
                  s['icon'] as IconData,
                  size: 20,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
                title: Text(
                  s['label'] as String,
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: isDark ? Colors.white24 : Colors.black12,
                ),
                onTap: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Iconsax.logout_copy, size: 18),
        label: const Text('ออกจากระบบ'),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark
              ? Colors.red.withOpacity(0.1)
              : const Color(0xFFFFF1F0),
          foregroundColor: Colors.red,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: isDark
                ? const BorderSide(color: Colors.red, width: 0.5)
                : BorderSide.none,
          ),
          textStyle: GoogleFonts.ibmPlexSansThai(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
