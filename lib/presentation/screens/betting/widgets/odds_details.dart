import 'package:flutter/material.dart';

import '../../../../data/models/odds/odds_model.dart';
import '../../../../l10n/app_localizations.dart';
import 'odds_badge.dart';

class OddsDetails extends StatelessWidget {
  final OddsModel odds;
  final OddsModel? previousOdds;

  const OddsDetails({
    super.key,
    required this.odds,
    this.previousOdds,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sectionTitleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.matchResult, style: sectionTitleStyle),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OddsBadge(
                  label: l10n.home,
                  odds: odds.homeWin,
                  previousOdds: previousOdds?.homeWin,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OddsBadge(
                  label: l10n.draw,
                  odds: odds.draw,
                  previousOdds: previousOdds?.draw,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OddsBadge(
                  label: l10n.away,
                  odds: odds.awayWin,
                  previousOdds: previousOdds?.awayWin,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(l10n.totals, style: sectionTitleStyle),
          const SizedBox(height: 8),
          OddsBadge(
            label: l10n.overUnder,
            odds: odds.overUnder,
            previousOdds: previousOdds?.overUnder,
          ),
        ],
      ),
    );
  }
}
