import 'package:flutter/material.dart';

class OddsBadge extends StatelessWidget {
  final String label;
  final double odds;
  final double? previousOdds;

  const OddsBadge({
    super.key,
    required this.label,
    required this.odds,
    this.previousOdds,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final direction = _getDirection();
    final directionColor = _getDirectionColor(direction, colorScheme);
    final labelStyle = textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurface.withValues(alpha: 0.7),
    );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: previousOdds ?? odds, end: odds),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: directionColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: directionColor.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: labelStyle),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (direction != 0)
                    Icon(
                      direction > 0
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: directionColor,
                      size: 18,
                    ),
                  Text(
                    value.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: directionColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  int _getDirection() {
    if (previousOdds == null) return 0;
    if (odds > previousOdds!) return 1;
    if (odds < previousOdds!) return -1;
    return 0;
  }

  Color _getDirectionColor(int direction, ColorScheme colorScheme) {
    if (direction > 0) return colorScheme.primary;
    if (direction < 0) return colorScheme.error;
    return colorScheme.secondary;
  }
}
