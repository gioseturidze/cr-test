part of 'betting_bloc.dart';

@freezed
sealed class BettingEvent with _$BettingEvent {
  const factory BettingEvent.loadGames() = LoadGames;

  const factory BettingEvent.oddsUpdated(Map<String, OddsModel> odds) =
      OddsUpdated;

  const factory BettingEvent.toggleGameExpanded(String gameId) =
      ToggleGameExpanded;
}
