import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:ui';
import 'dart:math' as import_math;
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/auth_interceptor.dart';
import 'match_results_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/match_model.dart';
import '../providers/match_provider.dart';

class MatchDetailsScreen extends ConsumerStatefulWidget {
  final String matchId;
  const MatchDetailsScreen({super.key, required this.matchId});

  @override
  ConsumerState<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends ConsumerState<MatchDetailsScreen> {
  bool _isJoining = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = isDark
        ? DesignTokens.accentLime
        : DesignTokens.primary;

    final matchAsync = ref.watch(matchDetailsProvider(widget.matchId));

    return matchAsync.when(
      loading: () => Scaffold(
        backgroundColor: isDark ? const Color(0xFF131315) : colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Iconsax.arrow_left_copy, color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: isDark ? const Color(0xFF131315) : colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Iconsax.arrow_left_copy, color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล: $err'),
        ),
      ),
      data: (match) {
        if (match == null) {
          return Scaffold(
            backgroundColor: isDark ? const Color(0xFF131315) : colorScheme.surface,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Iconsax.arrow_left_copy, color: isDark ? Colors.white : Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: const Center(
              child: Text('ไม่พบข้อมูลแมตช์นี้'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF131315) : colorScheme.surface,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context, isDark, colorScheme, primaryColor),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildHeroImage(context, isDark, match),
                    Transform.translate(
                      offset: const Offset(0, -32),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleCard(context, isDark, primaryColor, match),
                            const SizedBox(height: 32),
                            _buildLogisticsSection(context, isDark, primaryColor, match),
                            const SizedBox(height: 32),
                            _buildHighlightsGrid(context, isDark, primaryColor, match),
                            const SizedBox(height: 32),
                            _buildSquadSection(context, isDark, primaryColor, match),
                            const SizedBox(height: 32),
                            _buildHostNote(context, isDark, primaryColor, match),
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
          bottomNavigationBar: _buildStickyBottomBar(context, isDark, primaryColor, match),
        );
      },
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
          color: isDark ? Colors.white : Colors.black,
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

  Widget _buildHeroImage(BuildContext context, bool isDark, MatchModel match) {
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    final isHost = currentUserId == match.hostId;
    final matchImageUrl = match.imageUrl ?? match.court?.imageUrl;

    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            matchImageUrl ?? 'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?q=80&w=2670&auto=format&fit=crop',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: isDark ? DesignTokens.darkSurface : const Color(0xFFD1D5D7),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.accentLime),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: isDark ? DesignTokens.darkSurface : const Color(0xFFD1D5D7),
              child: const Center(
                child: Icon(Iconsax.image_copy, color: Colors.white24, size: 48),
              ),
            ),
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
          // Edit Match Image overlay for Host
          if (isHost)
            Positioned(
              bottom: 48,
              right: 24,
              child: Material(
                color: Colors.black.withOpacity(0.6),
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white, size: 24),
                  onPressed: () => _pickAndUploadImage(context, match.id),
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
    MatchModel match,
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
            match.title,
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
                text: match.skillLevel,
                color: primaryColor,
                isDark: isDark,
              ),
              if (match.shuttlecockType != null && match.shuttlecockType!.isNotEmpty)
                _buildTag(
                  text: match.shuttlecockType!,
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
    MatchModel match,
  ) {
    final dateStr = DateFormat('d MMM yyyy').format(match.dateTime);
    
    final timeFormat = DateFormat('HH:mm');
    final startTime = timeFormat.format(match.dateTime);
    final endTime = timeFormat.format(match.dateTime.add(Duration(minutes: (match.durationHours * 60).toInt())));
    final durationStr = match.durationHours % 1 == 0 
        ? '${match.durationHours.toInt()} ชม.' 
        : '${match.durationHours} ชม.';
    final timeStr = '$startTime - $endTime ($durationStr)';

    return Column(
      children: [
        _buildLogisticRow(
          icon: Iconsax.calendar_1_copy,
          title: dateStr,
          isDark: isDark,
          primaryColor: primaryColor,
        ),
        const SizedBox(height: 20),
        _buildLogisticRow(
          icon: Iconsax.clock_copy,
          title: timeStr,
          isDark: isDark,
          primaryColor: primaryColor,
          isSubtitle: true,
        ),
        const SizedBox(height: 20),
        _buildLogisticRow(
          icon: Iconsax.location_copy,
          title: match.court?.name ?? 'ไม่ระบุคอร์ท',
          subtitle: match.court?.location ?? 'ไม่ระบุสถานที่',
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
    MatchModel match,
  ) {
    final priceStr = match.estimatedCost % 1 == 0 
        ? match.estimatedCost.toInt().toString() 
        : match.estimatedCost.toString();

    final List<Widget> amenityWidgets = [];
    final items = match.amenities.isNotEmpty ? match.amenities : (match.court?.amenities ?? []);
    for (final amenity in items) {
      IconData icon = Icons.check_circle_outline;
      String label = amenity;
      final lower = amenity.toLowerCase();
      if (lower.contains('air') || lower.contains('แอร์')) {
        icon = Icons.ac_unit;
        label = 'แอร์';
      } else if (lower.contains('rubber') || lower.contains('ยาง')) {
        icon = Icons.layers;
        label = 'พื้นยาง';
      } else if (lower.contains('park') || lower.contains('จอด')) {
        icon = Icons.local_parking;
        label = 'ที่จอดรถ';
      } else if (lower.contains('shower') || lower.contains('อาบ') || lower.contains('น้ำ')) {
        icon = Icons.shower;
        label = 'ห้องน้ำ';
      }
      amenityWidgets.add(_buildAmenityIcon(icon, label, isDark));
    }
    if (amenityWidgets.isEmpty) {
      amenityWidgets.add(Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          'ไม่มีบริการพิเศษ', 
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 12, 
            color: isDark ? Colors.white30 : Colors.black26,
          ),
        ),
      ));
    }

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
                        priceStr,
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
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: amenityWidgets,
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
    MatchModel match,
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
            if (match.availableSlots == 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Text(
                  'เต็มแล้ว',
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (match.availableSlots == 1 ? Colors.red : Colors.green).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: (match.availableSlots == 1 ? Colors.red : Colors.green).withOpacity(0.3)),
                ),
                child: Text(
                  match.availableSlots == 1 ? 'เหลือที่เดียว!' : 'เหลือ ${match.availableSlots} ที่',
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: match.availableSlots == 1 ? Colors.red.shade400 : Colors.green.shade400,
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
            ...?(match.participants?.map((participant) {
              final profile = participant.playerProfile;
              final isHost = participant.playerId == match.hostId;
              final name = profile?.fullName ?? profile?.username ?? 'ผู้เล่น';
              final avatar = profile?.avatarUrl;
              return _buildSquadPlayer(
                imageUrl: avatar,
                name: name,
                isHost: isHost,
                primaryColor: primaryColor,
                isDark: isDark,
              );
            })),
            // Fill the rest with empty slots up to totalSlots
            ...List.generate(
              import_math.max(0, match.totalSlots - (match.participants?.length ?? 0)),
              (index) => _buildEmptySquadSlot(isDark),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatarPlaceholder(String name, bool isDark) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      color: isDark ? const Color(0xFF2C2C2E) : Colors.grey.shade200,
      child: Center(
        child: Text(
          initial,
          style: GoogleFonts.ibmPlexSansThai(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildSquadPlayer({
    required String? imageUrl,
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
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildAvatarPlaceholder(name, isDark),
                      )
                    : _buildAvatarPlaceholder(name, isDark),
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

  Widget _buildHostNote(
    BuildContext context,
    bool isDark,
    Color primaryColor,
    MatchModel match,
  ) {
    if (match.hostsNote == null || match.hostsNote!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

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
                match.hostsNote!,
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

  Future<void> _executeCancelMatch(BuildContext context, MatchModel match) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    setState(() {
      _isJoining = true;
    });
    try {
      final success = await ref.read(matchServiceProvider).cancelMatch(match.id);
      if (success) {
        ref.invalidate(matchesProvider);
        if (mounted) {
          messenger.showSnackBar(
            const SnackBar(content: Text('ยกเลิกแมตช์สำเร็จ!')),
          );
          navigator.pop(); // Go back to explore matches
        }
      } else {
        if (mounted) {
          messenger.showSnackBar(
            const SnackBar(content: Text('เกิดข้อผิดพลาดในการยกเลิกแมตช์')),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isJoining = false;
        });
      }
    }
  }

  Future<void> _pickAndUploadImage(BuildContext context, String matchId) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    if (!context.mounted) return;

    // Show full-screen loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        final isDark = Theme.of(dialogContext).brightness == Brightness.dark;
        return PopScope(
          canPop: false,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.accentLime),
                  ),
                  const SizedBox(height: 20),
                  DefaultTextStyle(
                    style: GoogleFonts.ibmPlexSansThai(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    child: const Text('กำลังอัปโหลดรูปภาพ...'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    final messenger = ScaffoldMessenger.of(context);
    final matchService = ref.read(matchServiceProvider);

    try {
      // 1. Upload to Supabase Storage
      final publicUrl = await matchService.uploadMatchImage(filePath: image.path);
      if (publicUrl == null) {
        throw Exception('Failed to upload image to storage');
      }

      // 2. Update image_url in matches table
      final success = await matchService.updateMatchImageUrl(
        matchId: matchId,
        imageUrl: publicUrl,
      );

      if (!success) {
        throw Exception('Failed to update match image URL in database');
      }

      // 3. Invalidate/Refresh matches
      ref.invalidate(matchDetailsProvider(matchId));
      ref.invalidate(matchesProvider);

      if (mounted) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('อัปโหลดรูปภาพสำเร็จ!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาดในการอัปโหลด: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // Close full-screen loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Widget _buildStickyBottomBar(
    BuildContext context,
    bool isDark,
    Color primaryColor,
    MatchModel match,
  ) {
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    final isAlreadyJoined = match.participants?.any((p) => p.playerId == currentUserId) ?? false;
    final isHost = currentUserId == match.hostId;
    final isFull = match.availableSlots <= 0;

    String buttonText = 'Join Match';
    String? subtitleText = '(${match.estimatedCost.toInt()} THB เก็บที่สนาม)';
    IconData? icon = Icons.bolt;
    bool isEnabled = true;

    if (isHost) {
      buttonText = 'ยกเลิกแมตช์';
      subtitleText = null;
      icon = null;
      isEnabled = true;
    } else if (isAlreadyJoined) {
      buttonText = 'เข้าร่วมแล้ว';
      subtitleText = null;
      icon = Icons.check_circle;
      isEnabled = false;
    } else if (isFull) {
      buttonText = 'แมตช์เต็มแล้ว';
      subtitleText = null;
      icon = Icons.block;
      isEnabled = false;
    }

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
              onPressed: !isEnabled || _isJoining
                  ? null
                  : () {
                      if (isHost) {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
                            title: Text(
                              'ยกเลิกแมตช์',
                              style: GoogleFonts.ibmPlexSansThai(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            content: Text(
                              'คุณแน่ใจหรือไม่ว่าต้องการยกเลิกแมตช์นี้? การดำเนินการนี้ไม่สามารถย้อนกลับได้',
                              style: GoogleFonts.ibmPlexSansThai(
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                child: Text(
                                  'ยกเลิก',
                                  style: GoogleFonts.ibmPlexSansThai(
                                    color: isDark ? Colors.white60 : Colors.black54,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext); // Close dialog
                                  _executeCancelMatch(context, match);
                                },
                                child: Text(
                                  'ยืนยันยกเลิก',
                                  style: GoogleFonts.ibmPlexSansThai(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        runWithAuth(context, ref, () async {
                          final messenger = ScaffoldMessenger.of(context);
                          setState(() {
                            _isJoining = true;
                          });
                          try {
                            final success = await ref.read(matchServiceProvider).joinMatch(match.id);
                            if (success) {
                              // Refresh match details
                              ref.invalidate(matchDetailsProvider(match.id));
                              // Also refresh matches list in explore
                              ref.invalidate(matchesProvider);
                              if (mounted) {
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('เข้าร่วมแมตช์สำเร็จ!')),
                                );
                              }
                            } else {
                              if (mounted) {
                                messenger.showSnackBar(
                                  const SnackBar(content: Text('เกิดข้อผิดพลาดในการเข้าร่วมแมตช์')),
                                );
                              }
                            }
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isJoining = false;
                              });
                            }
                          }
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: isHost
                    ? Colors.red.shade600
                    : (isEnabled
                        ? primaryColor
                        : (isDark ? Colors.white12 : Colors.grey.shade300)),
                foregroundColor: isHost
                    ? Colors.white
                    : (isEnabled
                        ? (isDark ? Colors.black : Colors.white)
                        : (isDark ? Colors.white30 : Colors.black38)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    DesignTokens.borderRadiusXl,
                  ),
                ),
                elevation: 0,
              ),
              child: _isJoining
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              buttonText,
                              style: GoogleFonts.ibmPlexSansThai(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (icon != null) ...[
                              const SizedBox(width: 8),
                              Icon(icon, size: 22),
                            ],
                          ],
                        ),
                        if (subtitleText != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitleText,
                            style: GoogleFonts.ibmPlexSansThai(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: (isDark ? Colors.black : Colors.white).withOpacity(
                                0.8,
                              ),
                            ),
                          ),
                        ],
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
