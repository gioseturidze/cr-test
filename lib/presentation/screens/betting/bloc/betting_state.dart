part of 'betting_bloc.dart';

@freezed
sealed class BettingState with _$BettingState {
  const factory BettingState.initial() = BettingInitial;

  const factory BettingState.loading() = BettingLoading;

  const factory BettingState.loaded({
    required List<GameModel> games,
    required Map<String, OddsModel> liveOdds,
    @Default({}) Set<String> expandedGameIds,
  }) = BettingLoaded;

  const factory BettingState.error(String message) = BettingError;
}
