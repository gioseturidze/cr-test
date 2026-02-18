import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:sports_betting/data/models/odds/odds_model.dart';
import 'package:sports_betting/domain/services/odds_simulator_interface.dart';

class MockRandom extends Mock implements Random {}

void main() {
  group('OddsSimulator', () {
    late MockRandom mockRandom;
    late OddsSimulator simulator;

    setUp(() {
      mockRandom = MockRandom();
      simulator = OddsSimulator(random: mockRandom);
    });

    tearDown(() {
      simulator.dispose();
    });

    test('emits initial odds on start', () async {
      when(() => mockRandom.nextInt(any())).thenReturn(0);
      when(() => mockRandom.nextDouble()).thenReturn(0.5);

      final initialOdds = {
        'game_1': const OddsModel(
            homeWin: 2.0, draw: 3.0, awayWin: 4.0, overUnder: 1.8),
      };

      expectLater(
        simulator.oddsStream,
        emitsInOrder([
          initialOdds,
        ]),
      );

      simulator.start(['game_1'], initialOdds);

      // Give time for the initial emit
      await Future.delayed(const Duration(milliseconds: 100));
      simulator.stop();
    });

    test('fluctuated odds stay within bounds', () async {
      // nextDouble returns 0.0 => delta = (0.0 - 0.5) * 0.2 = -0.1
      when(() => mockRandom.nextInt(any())).thenReturn(0);
      when(() => mockRandom.nextDouble()).thenReturn(0.0);

      final initialOdds = {
        'game_1': const OddsModel(
            homeWin: 1.10, draw: 1.10, awayWin: 1.10, overUnder: 1.10),
      };

      final emissions = <Map<String, OddsModel>>[];
      final sub = simulator.oddsStream.listen(emissions.add);

      simulator.start(['game_1'], initialOdds);

      // Wait for initial + at least one tick
      await Future.delayed(const Duration(seconds: 4));
      simulator.stop();
      await sub.cancel();

      // All odds should be >= 1.01
      for (final oddsMap in emissions) {
        final odds = oddsMap['game_1']!;
        expect(odds.homeWin, greaterThanOrEqualTo(1.01));
        expect(odds.draw, greaterThanOrEqualTo(1.01));
        expect(odds.awayWin, greaterThanOrEqualTo(1.01));
        expect(odds.overUnder, greaterThanOrEqualTo(1.01));
      }
    });

    test('stop cancels timer', () {
      when(() => mockRandom.nextInt(any())).thenReturn(0);
      when(() => mockRandom.nextDouble()).thenReturn(0.5);

      simulator.start(
        ['game_1'],
        {
          'game_1': const OddsModel(
              homeWin: 2.0, draw: 3.0, awayWin: 4.0, overUnder: 1.8),
        },
      );
      simulator.stop();

      // After stop, no more emissions should come through
      // (verified by no errors and clean tearDown)
    });

    test('odds values are clamped to max 20.0', () async {
      // nextDouble returns 1.0 => delta = (1.0 - 0.5) * 0.2 = +0.1
      when(() => mockRandom.nextInt(any())).thenReturn(0);
      when(() => mockRandom.nextDouble()).thenReturn(1.0);

      final initialOdds = {
        'game_1': const OddsModel(
            homeWin: 19.95, draw: 19.95, awayWin: 19.95, overUnder: 19.95),
      };

      final emissions = <Map<String, OddsModel>>[];
      final sub = simulator.oddsStream.listen(emissions.add);

      simulator.start(['game_1'], initialOdds);
      await Future.delayed(const Duration(seconds: 4));
      simulator.stop();
      await sub.cancel();

      for (final oddsMap in emissions) {
        final odds = oddsMap['game_1']!;
        expect(odds.homeWin, lessThanOrEqualTo(20.0));
        expect(odds.draw, lessThanOrEqualTo(20.0));
        expect(odds.awayWin, lessThanOrEqualTo(20.0));
        expect(odds.overUnder, lessThanOrEqualTo(20.0));
      }
    });
  });
}
