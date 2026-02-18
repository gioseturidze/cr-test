import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../data/models/game/game_model.dart';
import '../../../../data/models/odds/odds_model.dart';
import '../../../../domain/services/odds_simulator_interface.dart';
import '../../../../domain/usecases/get_games_usecase.dart';

part 'betting_bloc.freezed.dart';
part 'betting_event.dart';
part 'betting_state.dart';

@injectable
class BettingBloc extends Bloc<BettingEvent, BettingState> {
  final GetGamesUseCaseInterface _getGamesUseCase;
  final OddsSimulatorInterface _oddsSimulator;
  StreamSubscription<Map<String, OddsModel>>? _oddsSubscription;

  BettingBloc({
    required GetGamesUseCaseInterface getGamesUseCase,
    required OddsSimulatorInterface oddsSimulator,
  })  : _getGamesUseCase = getGamesUseCase,
        _oddsSimulator = oddsSimulator,
        super(const BettingState.initial()) {
    on<LoadGames>(_onLoadGames);
    on<OddsUpdated>(_onOddsUpdated);
    on<ToggleGameExpanded>(_onToggleGameExpanded);
  }

  Future<void> _onLoadGames(
    LoadGames event,
    Emitter<BettingState> emit,
  ) async {
    emit(const BettingState.loading());
    try {
      final games = await _getGamesUseCase();
      final oddsMap = {for (final game in games) game.id: game.odds};

      emit(BettingState.loaded(
        games: games,
        liveOdds: oddsMap,
      ));

      _oddsSubscription?.cancel();
      _oddsSubscription = _oddsSimulator.oddsStream.listen((updatedOdds) {
        add(BettingEvent.oddsUpdated(updatedOdds));
      });

      _oddsSimulator.start(
        games.map((g) => g.id).toList(),
        oddsMap,
      );
    } on GamesLoadException catch (e) {
      emit(BettingState.error(e.message));
    }
  }

  void _onOddsUpdated(
    OddsUpdated event,
    Emitter<BettingState> emit,
  ) {
    final currentState = state;
    if (currentState is BettingLoaded) {
      emit(currentState.copyWith(liveOdds: event.odds));
    }
  }

  void _onToggleGameExpanded(
    ToggleGameExpanded event,
    Emitter<BettingState> emit,
  ) {
    final currentState = state;
    if (currentState is BettingLoaded) {
      final expanded = currentState.expandedGameIds.contains(event.gameId)
          ? <String>{}
          : {event.gameId};
      emit(currentState.copyWith(expandedGameIds: expanded));
    }
  }

  @override
  Future<void> close() {
    _oddsSubscription?.cancel();
    _oddsSimulator.stop();
    return super.close();
  }
}
