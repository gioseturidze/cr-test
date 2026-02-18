import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sports_betting/data/models/game_model.dart';
import 'package:sports_betting/data/models/odds_model.dart';
import 'package:sports_betting/l10n/app_localizations.dart';
import 'package:sports_betting/presentation/screens/betting/widgets/game_tile.dart';

void main() {
  final testGame = GameModel(
    id: 'game_1',
    homeTeam: 'Liverpool',
    awayTeam: 'Barcelona',
    league: 'Champions League',
    startTime: DateTime(2026, 2, 18, 20, 0),
    odds: const OddsModel(homeWin: 1.80, draw: 3.20, awayWin: 4.50, overUnder: 1.90),
  );

  const testOdds = OddsModel(homeWin: 1.80, draw: 3.20, awayWin: 4.50, overUnder: 1.90);

  Widget buildTile({
    bool isExpanded = false,
    bool hasUnseenUpdate = false,
    OddsModel? previousOdds,
    VoidCallback? onToggle,
  }) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Scaffold(
        body: GameTile(
          game: testGame,
          liveOdds: testOdds,
          previousOdds: previousOdds,
          isExpanded: isExpanded,
          hasUnseenUpdate: hasUnseenUpdate,
          onToggle: onToggle ?? () {},
        ),
      ),
    );
  }

  final circularDotFinder = find.byWidgetPredicate((w) {
    if (w is! Container) return false;
    final dec = w.decoration;
    return dec is BoxDecoration && dec.shape == BoxShape.circle;
  });

  group('GameTile', () {
    testWidgets('shows team names in header', (tester) async {
      await tester.pumpWidget(buildTile());

      expect(find.textContaining('Liverpool'), findsOneWidget);
      expect(find.textContaining('Barcelona'), findsOneWidget);
    });

    testWidgets('arrow is upright when collapsed', (tester) async {
      await tester.pumpWidget(buildTile(isExpanded: false));

      final rotation = tester.widget<AnimatedRotation>(find.byType(AnimatedRotation));
      expect(rotation.turns, 0.0);
    });

    testWidgets('arrow is rotated 180° when expanded', (tester) async {
      await tester.pumpWidget(buildTile(isExpanded: true));

      final rotation = tester.widget<AnimatedRotation>(find.byType(AnimatedRotation));
      expect(rotation.turns, 0.5);
    });

    testWidgets('calls onToggle when tapped', (tester) async {
      var toggled = false;
      await tester.pumpWidget(buildTile(onToggle: () => toggled = true));

      await tester.tap(find.byType(InkWell).first);

      expect(toggled, isTrue);
    });

    testWidgets('unseen update dot shown when collapsed and hasUnseenUpdate is true',
        (tester) async {
      await tester.pumpWidget(
        buildTile(isExpanded: false, hasUnseenUpdate: true),
      );

      expect(circularDotFinder, findsOneWidget);
    });

    testWidgets('unseen update dot hidden when expanded even if hasUnseenUpdate is true',
        (tester) async {
      await tester.pumpWidget(
        buildTile(isExpanded: true, hasUnseenUpdate: true),
      );

      expect(circularDotFinder, findsNothing);
    });

    testWidgets('unseen update dot hidden when hasUnseenUpdate is false', (tester) async {
      await tester.pumpWidget(
        buildTile(isExpanded: false, hasUnseenUpdate: false),
      );

      expect(circularDotFinder, findsNothing);
    });
  });
}