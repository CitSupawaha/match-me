import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:match_me/core/theme/design_tokens.dart';

class StatMetricCard extends StatelessWidget {
  final String label;
  final String? value;
  final String? trend;
  final String? subtitle;
  final IconData? icon;
  final double? progress;
  final bool isChart;
  final Color? color;

  const StatMetricCard({
    super.key,
    required this.label,
    this.value,
    this.trend,
    this.subtitle,
    this.icon,
    this.progress,
    this.isChart = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1D1D20) : Colors.white;
    final borderColor = isDark
        ? const Color(0xFF2C2C2F)
        : const Color(0xFFE0E3E4);
    final onSurface = isDark ? Colors.white : const Color(0xFF2C2F30);
    final onSurfaceVariant = isDark
        ? const Color(0xFFA2ABAE)
        : const Color(0xFF595C5D);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Dynamic scaling based on the reported tight constraints (137.0 x 92.7)
        final isVerticalCompact = screenHeight < 110;
        final padding =
            (isVerticalCompact ? screenWidth * 0.08 : screenWidth * 0.12).clamp(
              8.0,
              16.0,
            );
        final labelSize =
            (isVerticalCompact ? screenWidth * 0.06 : screenWidth * 0.08).clamp(
              7.0,
              10.0,
            );
        final valueSize =
            (isVerticalCompact ? screenWidth * 0.18 : screenWidth * 0.22).clamp(
              18.0,
              32.0,
            );

        return Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor.withOpacity(0.5)),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      label.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: labelSize,
                        fontWeight: FontWeight.bold,
                        color: onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  if (icon != null && !isVerticalCompact)
                    Icon(
                      icon,
                      size: (screenWidth * 0.12).clamp(12.0, 18.0),
                      color: onSurfaceVariant,
                    ),
                ],
              ),
              SizedBox(height: isVerticalCompact ? 2 : 8),
              if (value != null)
                Text(
                  value!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ibmPlexSansThai(
                    fontSize: valueSize,
                    fontWeight: FontWeight.w900,
                    color: onSurface,
                    height: 1.1,
                  ),
                ),

              if (isChart && !isVerticalCompact) ...[
                const SizedBox(height: 8),
                _buildMiniChart(
                  isDark ? DesignTokens.accentLime : DesignTokens.primary,
                ),
              ],

              if (isVerticalCompact)
                const Spacer()
              else
                SizedBox(height: padding),

              if (progress != null) ...[
                _buildProgressBar(
                  progress!,
                  isDark ? DesignTokens.accentLime : DesignTokens.primary,
                ),
                const SizedBox(height: 4),
              ],

              if (trend != null || subtitle != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (trend != null)
                      Text(
                        trend!,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: labelSize,
                          fontWeight: FontWeight.bold,
                          color: isDark ? color : const Color(0xFF006A3C),
                        ),
                      ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: labelSize,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? DesignTokens.accentLime
                              : DesignTokens.primary,
                        ),
                      ),
                  ],
                ),

              // Decorative pattern for extremely small cards
              if (isVerticalCompact &&
                  !isChart &&
                  progress == null &&
                  trend == null) ...[
                const SizedBox(height: 4),
                _buildNetPattern(onSurfaceVariant.withOpacity(0.1)),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildNetPattern(Color color) {
    return Row(
      children: List.generate(
        8,
        (index) => Text('◢◤', style: TextStyle(color: color, fontSize: 8)),
      ),
    );
  }

  Widget _buildProgressBar(double progress, Color color) {
    return Container(
      height: 6,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniChart(Color color) {
    final heights = [0.4, 0.6, 0.3, 0.9, 0.5];
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: heights
            .map(
              (h) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 40 * h,
                  decoration: BoxDecoration(
                    color: color.withOpacity(h == 0.9 ? 1.0 : 0.4),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(2),
                    ),
                    boxShadow: [
                      if (h == 0.9)
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
