import 'package:flutter/material.dart';
import '../../theme/design_tokens.dart';

enum TonalLevel {
  surface,
  low,
  lowest,
  high,
}

class TonalContainer extends StatelessWidget {
  final Widget child;
  final TonalLevel level;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final List<BoxShadow>? shadow;

  const TonalContainer({
    super.key,
    required this.child,
    this.level = TonalLevel.low,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color backgroundColor;
    final colorScheme = Theme.of(context).colorScheme;
    
    switch (level) {
      case TonalLevel.surface:
        backgroundColor = colorScheme.surface;
        break;
      case TonalLevel.low:
        backgroundColor = isDark ? DesignTokens.darkSurface : DesignTokens.surfaceContainer;
        break;
      case TonalLevel.lowest:
        backgroundColor = isDark ? DesignTokens.darkBackground : Colors.white;
        break;
      case TonalLevel.high:
        backgroundColor = isDark ? DesignTokens.darkSurfaceVariant : DesignTokens.surfaceContainer;
        break;
    }

    // In dark mode, we've already set the backgroundColor above

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? DesignTokens.borderRadiusMd),
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}
