import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../l10n/generated/app_localizations.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({super.key, required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = isDark
        ? const Color(0xFFCCFF00)
        : const Color(0xFF006A3C);
    final onSurface = isDark ? Colors.white : const Color(0xFF2C2F30);

    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.ibmPlexSansThai(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
                color: onSurface,
              ),
            ),
          ),
          if (onViewAll != null)
            InkWell(
              onTap: onViewAll,
              child: Row(
                children: [
                  Text(
                    l10n.viewAll,
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Iconsax.arrow_right_3_copy,
                    size: 16,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
