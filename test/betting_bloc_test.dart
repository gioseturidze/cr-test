import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:sports_betting/core/exceptions/app_exceptions.dart';
import 'package:sports_betting/data/models/game_model.dart';
import 'package:sports_betting/data/models/odds_model.dart';
import 'package:sports_betting/domain/services/odds_simulator_interface.dart';
import 'package:sports_betting/domain/usecases/get_games_usecase.dart';
import 'package:sports_betting/presentation/screens/betting/bloc/betting_bloc.dart';

class MockGetGamesUseCase extends Mock implements GetGamesUseCaseInterface {}

class MockOddsSimulator extends Mock implements OddsSimulator {}

void main() {
  late MockGetGamesUseCase mockGetGamesUseCase;
  late MockOddsSimulator mockOddsSimulator;
  late StreamController<Map<String, OddsModel>> oddsStreamController;

  final testGames = [
    GameModel(
      id: 'game_1',
      homeTeam: 'Team A',
      awayTeam: 'Team B',
      league: 'Test League',
      startTime: DateTime(2026, 1, 1, 18, 0),
      odds: const OddsModel(
          homeWin: 2.0, draw: 3.0, awayWin: 4.0, overUnder: 1.8),
    ),
    GameModel(
      id: 'game_2',
      homeTeam: 'Team C',
      awayTeam: 'Team D',
      league: 'Test League',
      startTime: DateTime(2026, 1, 1, 20, 0),
      odds: const OddsModel(
          homeWin: 1.5, draw: 3.5, awayWin: 5.0, overUnder: 1.9),
    ),
  ];

  final initialOdds = {
    'game_1': const OddsModel(
        homeWin: 2.0, draw: 3.0, awayWin: 4.0, overUnder: 1.8),
    'game_2': const OddsModel(
        homeWin: 1.5, draw: 3.5, awayWin: 5.0, overUnder: 1.9),
  };

  setUp(() {
    mockGetGamesUseCase = MockGetGamesUseCase();
    mockOddsSimulator = MockOddsSimulator();
    oddsStreamController = StreamController<Map<String, OddsModel>>.broadcast();

    when(() => mockOddsSimulator.oddsStream)
        .thenAnswer((_) => oddsStreamController.stream);
    when(() => mockOddsSimulator.start(any(), any())).thenReturn(null);
    when(() => mockOddsSimulator.stop()).thenReturn(null);
  });

  tearDown(() {
    oddsStreamController.close();
  });

  BettingBloc buildBloc() => BettingBloc(
        getGamesUseCase: mockGetGamesUseCase,
        oddsSimulator: mockOddsSimulator,
      );

  group('BettingBloc', () {
    test('initial state is BettingInitial', () {
      final bloc = buildBloc();
      expect(bloc.state, const BettingState.initial());
      bloc.close();
    });

    blocTest<BettingBloc, BettingState>(
      'emits [loading, loaded] on successful game load',
      build: () {
        when(() => mockGetGamesUseCase())
            .thenAnswer((_) async => testGames);
        return buildBloc();
      },
      act: (bloc) => bloc.add(const BettingEvent.loadGames()),
      expect: () => [
        const BettingState.loading(),
        BettingState.loaded(games: testGames, liveOdds: initialOdds),
      ],
      verify: (_) {
        verify(() => mockOddsSimulator.start(
              ['game_1', 'game_2'],
              initialOdds,
            )).called(1);
      },
    );

    blocTest<BettingBloc, BettingState>(
      'emits [loading, error] on failed game load',
      build: () {
        when(() => mockGetGamesUseCase())
            .thenThrow(const GamesLoadException('Network error'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const BettingEvent.loadGames()),
      expect: () => [
        const BettingState.loading(),
        isA<BettingError>(),
      ],
    );

    blocTest<BettingBloc, BettingState>(
      'toggles game expansion',
      build: buildBloc,
      seed: () => BettingState.loaded(
        games: testGames,
        liveOdds: initialOdds,
      ),
      act: (bloc) =>
          bloc.add(const BettingEvent.toggleGameExpanded('game_1')),
      expect: () => [
        BettingState.loaded(
          games: testGames,
          liveOdds: initialOdds,
          expandedGameIds: {'game_1'},
        ),
      ],
    );

    blocTest<BettingBloc, BettingState>(
      'collapses expanded game',
      build: buildBloc,
      seed: () => BettingState.loaded(
        games: testGames,
        liveOdds: initialOdds,
        expandedGameIds: {'game_1'},
      ),
      act: (bloc) =>
          bloc.add(const BettingEvent.toggleGameExpanded('game_1')),
      expect: () => [
        BettingState.loaded(
          games: testGames,
          liveOdds: initialOdds,
          expandedGameIds: <String>{},
        ),
      ],
    );

    blocTest<BettingBloc, BettingState>(
      'updates odds when OddsUpdated event is received',
      build: buildBloc,
      seed: () => BettingState.loaded(
        games: testGames,
        liveOdds: initialOdds,
      ),
      act: (bloc) {
        final updatedOdds = Map<String, OddsModel>.from(initialOdds);
        updatedOdds['game_1'] = const OddsModel(
            homeWin: 2.1, draw: 3.1, awayWin: 3.9, overUnder: 1.85);
        bloc.add(BettingEvent.oddsUpdated(updatedOdds));
      },
      expect: () => [
        isA<BettingLoaded>().having(
          (s) => s.liveOdds['game_1']!.homeWin,
          'updated homeWin',
          2.1,
        ),
      ],
    );
  });
}
