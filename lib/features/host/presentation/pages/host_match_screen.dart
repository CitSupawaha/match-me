import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../l10n/generated/app_localizations.dart';

class HostMatchScreen extends ConsumerStatefulWidget {
  const HostMatchScreen({super.key});

  @override
  ConsumerState<HostMatchScreen> createState() => _HostMatchScreenState();
}

class _HostMatchScreenState extends ConsumerState<HostMatchScreen> {
  double _selectedDuration = 2.0; // hours
  int _selectedSkill = 1;
  int _availableSlots = 3;
  int _selectedShuttle = 1;
  final Set<int> _selectedAmenities = {1};
  final _matchNameController = TextEditingController();
  final _costController = TextEditingController(text: '450');
  final _noteController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now().add(const Duration(hours: 2));
  _Court? _selectedCourt;
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final List<_Court> _courts = [
    _Court(
      name: 'Kinetic Central',
      location: 'ถนนพระราม 9, กรุงเทพฯ',
      imageUrl:
          'https://images.unsplash.com/photo-1599586120429-48281b6f0ece?q=80&w=2070&auto=format&fit=crop',
      amenities: ['แอร์', 'ยางพารา'],
      isTopRated: true,
    ),
    _Court(
      name: 'Shuttle Hub',
      location: 'ซอยสุขุมวิท 71, กรุงเทพฯ',
      imageUrl:
          'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?q=80&w=2070&auto=format&fit=crop',
      amenities: ['ที่จอดรถ', 'พาร์เก้'],
    ),
    _Court(
      name: 'Ace Arena',
      location: 'ย่านหมอชิต, กรุงเทพฯ',
      imageUrl:
          'https://images.unsplash.com/photo-1613918431703-a4473852033c?q=80&w=2070&auto=format&fit=crop',
      amenities: ['แอร์', 'ห้องน้ำ'],
    ),
    _Court(
      name: 'Sky Court',
      location: 'สีลม, กรุงเทพฯ',
      imageUrl:
          'https://images.unsplash.com/photo-1599474924187-334a4ae5bd3c?q=80&w=2070&auto=format&fit=crop',
      amenities: ['ที่จอดรถ'],
    ),
  ];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void dispose() {
    _matchNameController.dispose();
    _costController.dispose();
    _noteController.dispose();
    super.dispose();
  }

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
      body: CustomScrollView(
        slivers: [
          // --- App Bar (same pattern as HomeScreen / ExploreScreen) ---
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: (isDark ? const Color(0xFF131315) : Colors.white)
                .withOpacity(0.9),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 60,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : DesignTokens.onSurface,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              l10n.hostMatch,
              style: GoogleFonts.ibmPlexSansThai(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: -0.5,
                color: primaryColor,
              ),
            ),
          ),

          // --- Form Content ---
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ============= SECTION 1: Basic Info =============
                SectionHeader(title: l10n.basicInfo),
                const SizedBox(height: 16),

                // Match Name
                _buildLabel(l10n.matchName, isDark),
                const SizedBox(height: 6),
                _buildTextField(
                  controller: _matchNameController,
                  hintText: l10n.matchNameHint,
                  isDark: isDark,
                  colorScheme: colorScheme,
                ),
                const SizedBox(height: 20),

                // Date & Time
                _buildLabel(l10n.dateTime, isDark),
                const SizedBox(height: 6),
                _buildDateTimePicker(isDark, colorScheme, primaryColor),
                const SizedBox(height: 20),

                // Duration
                _buildLabel(l10n.duration, isDark),
                const SizedBox(height: 10),
                _buildDurationPicker(isDark, colorScheme, primaryColor),
                const SizedBox(height: 24),

                // Upload Photos
                _buildLabel(l10n.uploadPhotos, isDark),
                const SizedBox(height: 10),
                _buildUploadSection(isDark, colorScheme, primaryColor, l10n),
                const SizedBox(height: 32),

                // ============= SECTION 2: Location Map =============
                SectionHeader(title: l10n.locationMap),
                const SizedBox(height: 16),
                _buildLocationMap(isDark, colorScheme, primaryColor, l10n),
                const SizedBox(height: 32),

                // ============= SECTION 3: Player Specs =============
                SectionHeader(title: l10n.playerSpecs),
                const SizedBox(height: 16),

                // Skill Level
                _buildLabel(l10n.skillLevel, isDark),
                const SizedBox(height: 10),
                _buildSkillChips(isDark, l10n),
                const SizedBox(height: 24),

                // Available Slots
                _buildSlotsCounter(isDark, colorScheme, primaryColor, l10n),
                const SizedBox(height: 32),

                // ============= SECTION 4: Key Details =============
                SectionHeader(title: l10n.keyDetails),
                const SizedBox(height: 16),

                // Shuttlecock Type
                _buildLabel(l10n.shuttlecockType, isDark),
                const SizedBox(height: 10),
                _buildShuttleChips(isDark, primaryColor),
                const SizedBox(height: 24),

                // Cost
                _buildLabel(l10n.estCost, isDark),
                const SizedBox(height: 6),
                _buildCostField(isDark, colorScheme, primaryColor, l10n),
                const SizedBox(height: 24),

                // Amenities
                _buildLabel(l10n.amenities, isDark),
                const SizedBox(height: 10),
                _buildAmenityChips(isDark, colorScheme, primaryColor, l10n),
                const SizedBox(height: 32),

                // ============= SECTION 5: Host's Note =============
                SectionHeader(title: l10n.hostsNote),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _noteController,
                  hintText: l10n.hostsNoteHint,
                  isDark: isDark,
                  colorScheme: colorScheme,
                  maxLines: 4,
                ),
              ]),
            ),
          ),
        ],
      ),

      // --- Sticky CTA (uses same lime accent pattern) ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surface.withOpacity(0),
              colorScheme.surface,
              colorScheme.surface,
            ],
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? DesignTokens.accentLime
                : DesignTokens.primary,
            foregroundColor: isDark ? Colors.black : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.borderRadiusXl),
            ),
            elevation: 0,
          ),
          icon: const Icon(Icons.bolt, size: 22),
          label: Text(
            l10n.createMatch,
            style: GoogleFonts.ibmPlexSansThai(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  // ==================== Shared Helpers ====================

  /// Uppercase label — same pattern as Stitch HTML labels
  Widget _buildLabel(String text, bool isDark) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.ibmPlexSansThai(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: isDark
            ? DesignTokens.onSurfaceVariantDark
            : DesignTokens.onSurfaceVariant,
      ),
    );
  }

  /// Text field with consistent theming
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDark,
    required ColorScheme colorScheme,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.ibmPlexSansThai(
        color: isDark ? Colors.white : DesignTokens.onSurface,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.ibmPlexSansThai(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.3),
        ),
        filled: true,
        fillColor: isDark
            ? DesignTokens.darkSurfaceVariant
            : colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }

  /// Date/Time picker row — opens custom bottom sheet
  Widget _buildDateTimePicker(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
  ) {
    final formattedDate = DateFormat('MMM dd, HH:mm').format(_selectedDateTime);

    return GestureDetector(
      onTap: () =>
          _showDateTimePickerBottomSheet(isDark, colorScheme, primaryColor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isDark
              ? DesignTokens.darkSurfaceVariant
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
        ),
        child: Row(
          children: [
            Icon(Iconsax.calendar_1, color: primaryColor, size: 20),
            const SizedBox(width: 12),
            Text(
              formattedDate,
              style: GoogleFonts.ibmPlexSansThai(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: isDark ? Colors.white : DesignTokens.onSurface,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.expand_more,
              color: isDark
                  ? DesignTokens.onSurfaceVariantDark
                  : DesignTokens.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// Duration picker row — opens custom bottom sheet
  Widget _buildDurationPicker(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
  ) {
    String formatDuration(double hours) {
      if (hours == hours.toInt().toDouble()) {
        return '${hours.toInt()} hr';
      }
      final wholeHours = hours.toInt();
      if (wholeHours == 0) return '30 min';
      return '$wholeHours hr 30 min';
    }

    return GestureDetector(
      onTap: () =>
          _showDurationPickerBottomSheet(isDark, colorScheme, primaryColor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isDark
              ? DesignTokens.darkSurfaceVariant
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
        ),
        child: Row(
          children: [
            Icon(Iconsax.timer_1, color: primaryColor, size: 20),
            const SizedBox(width: 12),
            Text(
              formatDuration(_selectedDuration),
              style: GoogleFonts.ibmPlexSansThai(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: isDark ? Colors.white : DesignTokens.onSurface,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.expand_more,
              color: isDark
                  ? DesignTokens.onSurfaceVariantDark
                  : DesignTokens.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== Bottom Sheet Implementation ====================

  /// Shared helper to show a modern themed bottom sheet
  Future<void> _showStyledBottomSheet({
    required Widget child,
    required String title,
    required VoidCallback onDone,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? DesignTokens.darkSurface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.borderRadiusXl),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: (isDark ? Colors.white : Colors.black).withOpacity(
                    0.1,
                  ),
                  borderRadius: BorderRadius.circular(
                    DesignTokens.borderRadiusFull,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : DesignTokens.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onDone();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: GoogleFonts.ibmPlexSansThai(
                        fontWeight: FontWeight.w900,
                        color: isDark
                            ? DesignTokens.accentLime
                            : DesignTokens.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              child,
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  void _showDateTimePickerBottomSheet(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
  ) {
    _showStyledBottomSheet(
      title: 'Select Date & Time',
      onDone: () {}, // State updates live in the picker
      child: SizedBox(
        height: 200,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            brightness: isDark ? Brightness.dark : Brightness.light,
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: GoogleFonts.ibmPlexSansThai(
                fontSize: 18,
                color: isDark ? Colors.white : DesignTokens.onSurface,
              ),
            ),
          ),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: _selectedDateTime,
            minimumDate: DateTime.now().subtract(const Duration(minutes: 5)),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() => _selectedDateTime = newDateTime);
            },
          ),
        ),
      ),
    );
  }

  void _showDurationPickerBottomSheet(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
  ) {
    final options = List.generate(24, (i) => (i + 1) * 0.5);
    final initialIndex = options.indexOf(_selectedDuration);

    String formatDuration(double hours) {
      if (hours == hours.toInt().toDouble()) {
        return '${hours.toInt()} hr';
      }
      final wholeHours = hours.toInt();
      if (wholeHours == 0) return '30 min';
      return '$wholeHours hr 30 min';
    }

    _showStyledBottomSheet(
      title: 'Match Duration',
      onDone: () {},
      child: SizedBox(
        height: 200,
        child: CupertinoPicker(
          itemExtent: 44,
          scrollController: FixedExtentScrollController(
            initialItem: initialIndex,
          ),
          onSelectedItemChanged: (int index) {
            setState(() => _selectedDuration = options[index]);
          },
          children: options.map((h) {
            return Center(
              child: Text(
                formatDuration(h),
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 18,
                  color: isDark ? Colors.white : DesignTokens.onSurface,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Location map card
  Widget _buildLocationMap(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
    AppLocalizations l10n,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(DesignTokens.borderRadiusXl),
      child: GestureDetector(
        onTap: () => _showCourtSelectorBottomSheet(
          isDark,
          colorScheme,
          primaryColor,
          l10n,
        ),
        child: Container(
          height: 240,
          decoration: BoxDecoration(
            color: isDark
                ? DesignTokens.darkSurfaceVariant
                : colorScheme.surfaceContainerHighest,
          ),
          child: Stack(
            children: [
              // Map placeholder
              Positioned.fill(
                child: _selectedCourt != null
                    ? Image.network(
                        _selectedCourt!.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: isDark
                              ? DesignTokens.darkSurface
                              : const Color(0xFFD1D5D7),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.white24,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: isDark
                            ? DesignTokens.darkSurface
                            : const Color(0xFFD1D5D7),
                        child: Center(
                          child: Icon(
                            Iconsax.map_1,
                            size: 48,
                            color: (isDark ? Colors.white : Colors.black)
                                .withOpacity(0.1),
                          ),
                        ),
                      ),
              ),

              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),

              // Court selector pill
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? DesignTokens.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(
                      DesignTokens.borderRadiusFull,
                    ),
                    boxShadow: DesignTokens.softLift,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.stadium, color: primaryColor, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _selectedCourt?.name ?? l10n.selectCourt,
                          style: GoogleFonts.ibmPlexSansThai(
                            fontSize: 14,
                            fontWeight: _selectedCourt != null
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isDark
                                ? Colors.white
                                : DesignTokens.onSurface,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: isDark
                            ? DesignTokens.onSurfaceVariantDark
                            : DesignTokens.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom info
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (_selectedCourt != null
                              ? l10n.currentSelection
                              : 'No selection')
                          .toUpperCase(),
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedCourt?.name ?? 'Where are we playing?',
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    if (_selectedCourt != null)
                      Text(
                        _selectedCourt!.location,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Selection Modules ====================

  void _showCourtSelectorBottomSheet(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
    AppLocalizations l10n,
  ) {
    _showStyledBottomSheet(
      title: 'เลือกสนาม',
      onDone: () {},
      child: Column(
        children: [
          // Search Bar
          TextField(
            style: GoogleFonts.ibmPlexSansThai(
              color: isDark ? Colors.white : DesignTokens.onSurface,
            ),
            decoration: InputDecoration(
              hintText: 'ค้นหาชื่อสนามหรือทำเล...',
              prefixIcon: Icon(
                Iconsax.search_normal,
                size: 20,
                color: primaryColor,
              ),
              filled: true,
              fillColor: isDark
                  ? DesignTokens.darkSurfaceVariant
                  : colorScheme.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  DesignTokens.borderRadiusFull,
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Court List
          SizedBox(
            height: 400,
            child: ListView.separated(
              itemCount: _courts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final court = _courts[index];
                return _buildCourtItem(court, isDark, primaryColor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourtItem(_Court court, bool isDark, Color primaryColor) {
    final isSelected = _selectedCourt?.name == court.name;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedCourt = court);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? DesignTokens.darkSurfaceVariant : Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.borderRadiusXl),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : (isDark ? Colors.white : Colors.black).withOpacity(0.05),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: DesignTokens.softLift,
        ),
        child: Row(
          children: [
            // Court Image
            ClipRRect(
              borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
              child: Image.network(
                court.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: isDark ? DesignTokens.darkSurface : Colors.black12,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 20,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        court.name,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: isDark ? Colors.white : DesignTokens.onSurface,
                        ),
                      ),
                      if (court.isTopRated) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: DesignTokens.accentLime,
                            borderRadius: BorderRadius.circular(
                              DesignTokens.borderRadiusFull,
                            ),
                          ),
                          child: Text(
                            'TOP',
                            style: GoogleFonts.ibmPlexSansThai(
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    court.location,
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 12,
                      color: (isDark ? Colors.white : Colors.black).withOpacity(
                        0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: court.amenities.map((a) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            a == 'แอร์' ? Icons.ac_unit : Icons.grid_view,
                            size: 12,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            a,
                            style: GoogleFonts.ibmPlexSansThai(
                              fontSize: 10,
                              color: isDark
                                  ? Colors.white70
                                  : DesignTokens.onSurfaceVariant,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // Select Button Icon
            Icon(
              isSelected ? Icons.check_circle : Icons.add_circle_outline,
              color: isSelected
                  ? primaryColor
                  : (isDark ? Colors.white30 : Colors.black12),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  /// Single photo upload section
  Widget _buildUploadSection(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
    AppLocalizations l10n,
  ) {
    if (_selectedImage == null) {
      // Empty state
      return GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: isDark
                ? DesignTokens.darkSurfaceVariant
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
            border: Border.all(
              color: primaryColor.withOpacity(0.2),
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.camera_copy, color: primaryColor, size: 40),
              const SizedBox(height: 12),
              Text(
                l10n.addPhoto,
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : DesignTokens.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Selected image state
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
            image: DecorationImage(
              image: FileImage(File(_selectedImage!.path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Overlay for actions
        Positioned(
          top: 12,
          right: 12,
          child: Row(
            children: [
              _buildImageAction(icon: Iconsax.edit_2_copy, onTap: _pickImage),
              const SizedBox(width: 8),
              _buildImageAction(
                icon: Icons.close,
                onTap: _removeImage,
                isDelete: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageAction({
    required IconData icon,
    required VoidCallback onTap,
    bool isDelete = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDelete ? Colors.red.withOpacity(0.9) : Colors.black87,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  /// Skill level chips using AppChip
  Widget _buildSkillChips(bool isDark, AppLocalizations l10n) {
    final labels = [
      l10n.levelBeginner,
      l10n.levelIntermediate,
      l10n.levelAdvanced,
    ];
    return Wrap(
      spacing: 8,
      children: List.generate(labels.length, (i) {
        return AppChip(
          label: labels[i],
          isSelected: _selectedSkill == i,
          onTap: () => setState(() => _selectedSkill = i),
        );
      }),
    );
  }

  /// Available slots counter using AppCard
  Widget _buildSlotsCounter(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
    AppLocalizations l10n,
  ) {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.availableSlots,
                style: GoogleFonts.ibmPlexSansThai(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: isDark ? Colors.white : DesignTokens.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.excludingYourself,
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 12,
                  color: isDark
                      ? DesignTokens.onSurfaceVariantDark
                      : DesignTokens.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Minus
              GestureDetector(
                onTap: () {
                  if (_availableSlots > 1) {
                    setState(() => _availableSlots--);
                  }
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? DesignTokens.darkSurfaceVariant
                        : colorScheme.surfaceContainerHighest,
                  ),
                  child: Icon(
                    Icons.remove,
                    color: isDark ? Colors.white : DesignTokens.onSurface,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Count
              Text(
                '$_availableSlots',
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 20),
              // Plus
              GestureDetector(
                onTap: () => setState(() => _availableSlots++),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? DesignTokens.accentLime
                        : DesignTokens.primary,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    color: isDark ? Colors.black : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Shuttlecock type chips
  Widget _buildShuttleChips(bool isDark, Color primaryColor) {
    final labels = ['RSL Silver', 'RSL Tourney', 'Yonex'];
    return Wrap(
      spacing: 10,
      children: List.generate(labels.length, (i) {
        final isSelected = _selectedShuttle == i;
        return GestureDetector(
          onTap: () => setState(() => _selectedShuttle = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? primaryColor.withOpacity(0.1)
                  : (isDark ? DesignTokens.darkSurfaceVariant : Colors.white),
              borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
              border: Border.all(
                color: isSelected
                    ? primaryColor
                    : (isDark ? Colors.white : Colors.black).withOpacity(0.1),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Text(
              labels[i],
              style: GoogleFonts.ibmPlexSansThai(
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                fontSize: 13,
                color: isSelected
                    ? primaryColor
                    : (isDark ? Colors.white : DesignTokens.onSurface),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Cost input field
  Widget _buildCostField(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? DesignTokens.darkSurfaceVariant
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
      ),
      child: Row(
        children: [
          Text(
            '฿',
            style: GoogleFonts.ibmPlexSansThai(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _costController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.ibmPlexSansThai(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : DesignTokens.onSurface,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark
                    ? DesignTokens.darkSurfaceVariant
                    : colorScheme.surfaceContainerHighest,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          Text(
            l10n.perPerson.toUpperCase(),
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? DesignTokens.onSurfaceVariantDark
                  : DesignTokens.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Amenity toggle chips
  Widget _buildAmenityChips(
    bool isDark,
    ColorScheme colorScheme,
    Color primaryColor,
    AppLocalizations l10n,
  ) {
    final items = [
      (Icons.ac_unit, l10n.airCon),
      (Icons.air, l10n.fan),
      (Icons.layers, l10n.rubberFloor),
      (Icons.deck, l10n.woodFloor),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final index = items.indexOf(item) + 1;
        final isSelected = _selectedAmenities.contains(index);
        return AppChip(
          label: item.$2,
          icon: item.$1,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedAmenities.remove(index);
              } else {
                _selectedAmenities.add(index);
              }
            });
          },
        );
      }).toList(),
    );
  }
}

class _Court {
  final String name;
  final String location;
  final String imageUrl;
  final List<String> amenities;
  final bool isTopRated;

  _Court({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.amenities,
    this.isTopRated = false,
  });
}
