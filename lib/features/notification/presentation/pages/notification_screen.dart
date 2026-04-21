import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Design Tokens from Stitch Notification Design
    final primaryColor = isDark
        ? const Color(0xFFCCFF00)
        : const Color(0xFF006a3c);
    final surfaceColor = isDark
        ? const Color(0xFF111411)
        : const Color(0xFFf5f6f7);
    final cardColor = isDark ? const Color(0xFF1d211d) : Colors.white;
    final onSurfaceColor = isDark ? const Color(0xFFe2e3e1) : Colors.black87;
    final secondaryTextColor = isDark
        ? const Color(0xFFc1c9be)
        : Colors.black54;

    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: _buildAppBar(context, isDark, onSurfaceColor, primaryColor),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          _buildDateHeader('วันนี้', isDark, onSurfaceColor),
          const SizedBox(height: 16),
          _buildPlayerRequestCard(
            context,
            isDark,
            primaryColor,
            cardColor,
            onSurfaceColor,
            secondaryTextColor,
          ),
          const SizedBox(height: 16),
          _buildStatusCard(
            context,
            isDark,
            title: 'เตรียมตัวให้พร้อม!',
            message: 'แมตช์ของคุณที่ สนามกีฬาแห่งชาติ จะเริ่มในอีก 1 ชม.',
            time: '1 ชม.',
            icon: Iconsax.clock_copy,
            iconColor: primaryColor,
            cardColor: isDark ? const Color(0xFF191c19) : Colors.white,
            onSurface: onSurfaceColor,
            secondaryText: secondaryTextColor,
          ),
          const SizedBox(height: 24),
          _buildDateHeader('เมื่อวาน', isDark, onSurfaceColor),
          const SizedBox(height: 16),
          _buildStatusCard(
            context,
            isDark,
            title: 'ผลการแข่งขัน',
            message:
                'คุณได้รับ ELO +15 จากแมตช์ล่าสุด คะแนนรวมของคุณตอนนี้คือ 1420',
            time: '20:45',
            icon: Iconsax.trend_up_copy,
            iconColor: isDark
                ? const Color(0xFF89d997)
                : const Color(0xFF006a3c),
            cardColor: isDark ? const Color(0xFF191c19) : Colors.white,
            onSurface: onSurfaceColor,
            secondaryText: secondaryTextColor,
          ),
          const SizedBox(height: 16),
          _buildSimpleInviteCard(
            context,
            isDark,
            title: 'คำเชิญใหม่',
            message: 'ทีม "Smash Bros" เชิญคุณเข้าร่วมการแข่งขันสุดสัปดาห์นี้',
            time: 'เมื่อวาน',
            cardColor: isDark
                ? const Color(0xFF1d211d).withOpacity(0.5)
                : Colors.white,
            onSurface: onSurfaceColor,
            secondaryText: secondaryTextColor,
          ),
          const SizedBox(height: 100), // Bottom nav space
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    bool isDark,
    Color onSurface,
    Color primary,
  ) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,

      title: Text(
        'การแจ้งเตือน',
        style: GoogleFonts.ibmPlexSansThai(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: onSurface,
        ),
      ),
    );
  }

  Widget _buildDateHeader(String title, bool isDark, Color onSurface) {
    return Text(
      title,
      style: GoogleFonts.ibmPlexSansThai(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: onSurface,
      ),
    );
  }

  Widget _buildPlayerRequestCard(
    BuildContext context,
    bool isDark,
    Color primary,
    Color cardColor,
    Color onSurface,
    Color secondaryText,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primary.withOpacity(0.2), width: 2),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDVyis-s1OjUhegw8zUrGhiLtlANgWR0SEpgKVT2TpefQArp0Wv8tmLZFMyeCJASmfjIW4IdAGr_kG0wfAdhwTnNsWpQ1W8_3WJNYuOvA3WV8vS6tR0MEl_dQ1VHeduPIA8uVffn6vjD0NAVhRiIUr-elwy3alSQHsVe5Vhyil4KwRTL5dGg6LS2q5ZrPLELulNg4idJqvdQDMJY0PQmGIwvtgwj8PjRvqlB7-VAU_1AzXM-0iwK1B5eAinN5xZQSs4rYIIWvrGzKc',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'คำขอเข้าร่วม',
                          style: GoogleFonts.ibmPlexSansThai(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: primary,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          '10 นาทีที่แล้ว',
                          style: GoogleFonts.ibmPlexSansThai(
                            fontSize: 11,
                            color: secondaryText.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'คุณลินา',
                            style: GoogleFonts.ibmPlexSansThai(
                              fontWeight: FontWeight.bold,
                              color: isDark ? const Color(0xFF89d997) : primary,
                            ),
                          ),
                          TextSpan(
                            text: ' ขอเข้าร่วมแมตช์ ',
                            style: GoogleFonts.ibmPlexSansThai(
                              color: onSurface,
                            ),
                          ),
                          TextSpan(
                            text: 'Casual Friday',
                            style: GoogleFonts.ibmPlexSansThai(
                              fontWeight: FontWeight.bold,
                              color: onSurface,
                            ),
                          ),
                        ],
                      ),
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 16,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildBadge(
                          context,
                          'ELO 1250',
                          isDark,
                          icon: Icons.grade,
                          iconColor: primary,
                        ),
                        const SizedBox(width: 8),
                        _buildBadge(
                          context,
                          'Beginner',
                          isDark,
                          color: isDark
                              ? const Color(0xFF3d4b3d)
                              : const Color(0xFFe2e3e2).withOpacity(0.5),
                          textColor: isDark
                              ? const Color(0xFFd1e8ce)
                              : Colors.black87,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'ปฏิเสธ',
                  isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100]!,
                  onSurface,
                  Iconsax.close_circle_copy,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  'ตอบรับ',
                  primary,
                  isDark ? const Color(0xFF111411) : Colors.white,
                  Iconsax.tick_circle_copy,
                  isBold: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    BuildContext context,
    bool isDark, {
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color iconColor,
    required Color cardColor,
    required Color onSurface,
    required Color secondaryText,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.03)
              : Colors.black.withOpacity(0.03),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: iconColor.withOpacity(0.1), width: 1),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 11,
                        color: secondaryText.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 13,
                    color: secondaryText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleInviteCard(
    BuildContext context,
    bool isDark, {
    required String title,
    required String message,
    required String time,
    required Color cardColor,
    required Color onSurface,
    required Color secondaryText,
  }) {
    return Opacity(
      opacity: 0.6,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.03)
                : Colors.black.withOpacity(0.03),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Iconsax.sms_copy, color: secondaryText, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: onSurface,
                        ),
                      ),
                      Text(
                        time,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 11,
                          color: secondaryText.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 13,
                      color: secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(
    BuildContext context,
    String text,
    bool isDark, {
    IconData? icon,
    Color? iconColor,
    Color? color,
    Color? textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color ?? (isDark ? const Color(0xFF282b28) : Colors.grey[100]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: iconColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: textColor ?? (isDark ? Colors.white70 : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    Color bgColor,
    Color textColor,
    IconData icon, {
    bool isBold = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isBold
            ? [
                BoxShadow(
                  color: bgColor.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
