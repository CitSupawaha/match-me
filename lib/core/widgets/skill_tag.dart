import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

enum SkillLevel {
  beginner,
  intermediate,
  advanced,
}

class SkillTag extends StatelessWidget {
  final SkillLevel level;

  const SkillTag({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    Color containerColor;
    Color textColor;
    String label;

    switch (level) {
      case SkillLevel.beginner:
        containerColor = Theme.of(context).colorScheme.surfaceContainer;
        textColor = Theme.of(context).colorScheme.onSurfaceVariant;
        label = 'Beginner';
        break;
      case SkillLevel.intermediate:
        containerColor = Theme.of(context).colorScheme.secondaryContainer;
        textColor = Theme.of(context).colorScheme.onSecondaryContainer;
        label = 'Intermediate';
        break;
      case SkillLevel.advanced:
        containerColor = Theme.of(context).colorScheme.primary;
        textColor = Theme.of(context).colorScheme.onPrimary;
        label = 'Advanced';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(DesignTokens.borderRadiusFull),
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
      ),
    );
  }
}
