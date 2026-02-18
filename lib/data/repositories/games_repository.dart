import 'package:injectable/injectable.dart';

import '../models/game/game_model.dart';
import '../models/odds/odds_model.dart';

abstract class GamesRepository {
  Future<List<GameModel>> getGames();
}

@LazySingleton(as: GamesRepository)
class MockGamesRepository implements GamesRepository {
  @override
  Future<List<GameModel>> getGames() async {
    await Future.delayed(const Duration(milliseconds: 800));

    final now = DateTime.now();

    return [
      GameModel(
        id: 'game_1',
        homeTeam: 'Manchester United',
        awayTeam: 'Liverpool',
        league: 'Premier League',
        startTime: now.add(const Duration(hours: 2)),
        odds: const OddsModel(homeWin: 2.45, draw: 3.20, awayWin: 2.90, overUnder: 1.85),
      ),
      GameModel(
        id: 'game_2',
        homeTeam: 'Real Madrid',
        awayTeam: 'Barcelona',
        league: 'La Liga',
        startTime: now.add(const Duration(hours: 4)),
        odds: const OddsModel(homeWin: 2.10, draw: 3.50, awayWin: 3.30, overUnder: 1.90),
      ),
      GameModel(
        id: 'game_3',
        homeTeam: 'Bayern Munich',
        awayTeam: 'Borussia Dortmund',
        league: 'Bundesliga',
        startTime: now.add(const Duration(hours: 1)),
        odds: const OddsModel(homeWin: 1.75, draw: 3.80, awayWin: 4.20, overUnder: 1.70),
      ),
      GameModel(
        id: 'game_4',
        homeTeam: 'PSG',
        awayTeam: 'Marseille',
        league: 'Ligue 1',
        startTime: now.add(const Duration(hours: 3)),
        odds: const OddsModel(homeWin: 1.50, draw: 4.00, awayWin: 6.50, overUnder: 1.80),
      ),
      GameModel(
        id: 'game_5',
        homeTeam: 'Juventus',
        awayTeam: 'AC Milan',
        league: 'Serie A',
        startTime: now.add(const Duration(hours: 5)),
        odds: const OddsModel(homeWin: 2.30, draw: 3.10, awayWin: 3.20, overUnder: 1.95),
      ),
      GameModel(
        id: 'game_6',
        homeTeam: 'Ajax',
        awayTeam: 'PSV',
        league: 'Eredivisie',
        startTime: now.add(const Duration(hours: 6)),
        odds: const OddsModel(homeWin: 1.90, draw: 3.40, awayWin: 3.80, overUnder: 1.75),
      ),
      GameModel(
        id: 'game_7',
        homeTeam: 'Benfica',
        awayTeam: 'Porto',
        league: 'Primeira Liga',
        startTime: now.add(const Duration(hours: 7)),
        odds: const OddsModel(homeWin: 2.20, draw: 3.30, awayWin: 3.00, overUnder: 1.88),
      ),
      GameModel(
        id: 'game_8',
        homeTeam: 'Celtic',
        awayTeam: 'Rangers',
        league: 'Scottish Premiership',
        startTime: now.add(const Duration(hours: 8)),
        odds: const OddsModel(homeWin: 2.00, draw: 3.60, awayWin: 3.50, overUnder: 1.82),
      ),
    ];
  }
}
