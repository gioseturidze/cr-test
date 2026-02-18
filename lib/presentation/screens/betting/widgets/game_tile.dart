import 'package:flutter/material.dart';

import '../../../../data/models/game_model.dart';
import '../../../../data/models/odds_model.dart';
import 'odds_details.dart';

class GameTile extends StatelessWidget {
  final GameModel game;
  final OddsModel liveOdds;
  final OddsModel? previousOdds;
  final bool isExpanded;
  final bool hasUnseenUpdate;
  final VoidCallback onToggle;

  const GameTile({super.key, required this.game, required this.liveOdds, this.previousOdds, required this.isExpanded, this.hasUnseenUpdate = false, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final timeStr = '${game.startTime.hour.toString().padLeft(2, '0')}:${game.startTime.minute.toString().padLeft(2, '0')}';
    final subtleTextStyle = textTheme.bodySmall?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game.league,
                          style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${game.homeTeam} vs ${game.awayTeam}',
                          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(timeStr, style: subtleTextStyle),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _MiniOdds(value: liveOdds.homeWin),
                      const SizedBox(width: 4),
                      _MiniOdds(value: liveOdds.draw),
                      const SizedBox(width: 4),
                      _MiniOdds(value: liveOdds.awayWin),
                    ],
                  ),
                  const SizedBox(width: 8),
                  if (hasUnseenUpdate && !isExpanded)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  AnimatedRotation(turns: isExpanded ? 0.5 : 0, duration: const Duration(milliseconds: 200), child: const Icon(Icons.expand_more)),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: OddsDetails(odds: liveOdds, previousOdds: previousOdds),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

class _MiniOdds extends StatelessWidget {
  final double value;

  const _MiniOdds({required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: colorScheme.onSurface.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(4)),
      child: Text(value.toStringAsFixed(2), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
