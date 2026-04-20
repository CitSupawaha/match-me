import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../l10n/generated/app_localizations.dart';

enum NavTab { home, match, host, profile }

class AppBottomNav extends StatelessWidget {
  final NavTab activeTab;
  final ValueChanged<NavTab>? onTabChanged;

  const AppBottomNav({
    super.key,
    required this.activeTab,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final accentColor = isDark
        ? Theme.of(context).colorScheme.secondaryContainer
        : Theme.of(context).colorScheme.primary;

    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: (isDark ? const Color(0xFF131315) : Colors.white).withOpacity(0.9),
        border: Border.all(
          color: (isDark ? const Color(0xFF2C2C2F) : Colors.black).withOpacity(0.1),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            tab: NavTab.home,
            icon: Iconsax.home_2_copy,
            activeIcon: Iconsax.home_2,
            label: l10n.home,
            accentColor: accentColor,
            isDark: isDark,
          ),
          _buildNavItem(
            context,
            tab: NavTab.match,
            icon: Icons.sports_tennis,
            activeIcon: Icons.sports_tennis,
            label: l10n.match,
            accentColor: accentColor,
            isDark: isDark,
          ),
          _buildNavItem(
            context,
            tab: NavTab.host,
            icon: Iconsax.add_circle_copy,
            activeIcon: Iconsax.add_circle,
            label: l10n.host,
            accentColor: accentColor,
            isDark: isDark,
          ),
          _buildNavItem(
            context,
            tab: NavTab.profile,
            icon: Iconsax.user_copy,
            activeIcon: Iconsax.user,
            label: l10n.profile,
            accentColor: accentColor,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required NavTab tab,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required Color accentColor,
    required bool isDark,
  }) {
    final isSelected = activeTab == tab;
    final color = isSelected
        ? accentColor
        : (isDark ? const Color(0xFFA2ABAE) : const Color(0xFF595C5D));
    final displayIcon = isSelected ? activeIcon : icon;

    return GestureDetector(
      onTap: () => onTabChanged?.call(tab),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(displayIcon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.ibmPlexSansThai(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                color: color,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
