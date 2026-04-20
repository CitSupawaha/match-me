import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/presentation/widgets/tonal_container.dart';

class CourtCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String distance;
  final double rating;

  const CourtCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.distance,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return TonalContainer(
      level: TonalLevel.lowest,
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: EdgeInsets.zero,
      borderRadius: DesignTokens.borderRadiusXl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(DesignTokens.borderRadiusXl),
              ),
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(DesignTokens.borderRadiusXl),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Iconsax.gallery_copy,
                      color: Theme.of(context).colorScheme.outlineVariant,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),
          // Info Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Iconsax.star_copy, color: Color(0xFFCCFF00), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: GoogleFonts.ibmPlexSansThai(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Iconsax.location_copy, color: Colors.grey, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 12,
                        color: Colors.grey,
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
  }
}
