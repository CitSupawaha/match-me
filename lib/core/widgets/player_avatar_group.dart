import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/design_tokens.dart';

class PlayerAvatarGroup extends StatelessWidget {
  final List<String> imageUrls;
  final bool isWinner;
  final double size;
  final int extraCount;

  const PlayerAvatarGroup({
    super.key,
    required this.imageUrls,
    this.isWinner = false,
    this.size = 48,
    this.extraCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty && extraCount == 0) {
      return _buildEmptyState(context);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (int i = 0; i < imageUrls.length; i++)
          Padding(
            padding: EdgeInsets.only(left: i * (size * 0.6)),
            child: _buildAvatar(imageUrls[i], context),
          ),
        if (extraCount > 0)
          Padding(
            padding: EdgeInsets.only(left: imageUrls.length * (size * 0.6)),
            child: _buildExtraCount(context),
          ),
      ],
    );
  }

  Widget _buildAvatar(String url, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isWinner
              ? isDark
                    ? DesignTokens.accentLime
                    : DesignTokens.primary
              : (isDark ? DesignTokens.darkSurfaceVariant : Colors.white),
          width: isWinner ? 3 : 2,
        ),
        boxShadow: isWinner
            ? [
                BoxShadow(
                  color: isDark
                      ? DesignTokens.accentLime.withOpacity(
                          isDark ? 0.5 : 0.3,
                        )
                      : DesignTokens.primary.withOpacity(
                          isDark ? 0.5 : 0.3,
                        ),
                  blurRadius: isDark ? 12 : 0,
                  spreadRadius: isDark ? 2 : 1,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: Icon(
              Iconsax.user_copy,
              color: Theme.of(context).colorScheme.outline,
              size: size * 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExtraCount(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border.all(
          color: isDark ? DesignTokens.darkSurfaceVariant : Colors.white,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '+$extraCount',
          style: TextStyle(
            fontSize: size * 0.35,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: Icon(
        Iconsax.user_add_copy,
        size: size * 0.5,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
