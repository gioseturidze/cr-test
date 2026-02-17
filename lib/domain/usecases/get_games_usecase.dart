import 'package:injectable/injectable.dart';

import '../../data/models/game_model.dart';
import '../../data/repositories/games_repository.dart';

abstract class GetGamesUseCaseInterface {
  Future<List<GameModel>> call();
}

@Injectable(as: GetGamesUseCaseInterface)
class GetGamesUseCase implements GetGamesUseCaseInterface {
  final GamesRepository _gamesRepository;

  GetGamesUseCase({required GamesRepository gamesRepository})
      : _gamesRepository = gamesRepository;

  @override
  Future<List<GameModel>> call() {
    return _gamesRepository.getGames();
  }
}
