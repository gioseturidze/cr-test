import 'dart:async';
import 'dart:math';

import 'package:injectable/injectable.dart';

import '../../data/models/odds_model.dart';

abstract class OddsSimulatorInterface {
  Stream<Map<String, OddsModel>> get oddsStream;
  void start(List<String> gameIds, Map<String, OddsModel> initialOdds);
  void stop();
  void dispose();
}

@Injectable(as: OddsSimulatorInterface)
class OddsSimulator implements OddsSimulatorInterface {
  final Random _random;
  Timer? _timer;
  final _controller = StreamController<Map<String, OddsModel>>.broadcast();

  @override
  Stream<Map<String, OddsModel>> get oddsStream => _controller.stream;

  OddsSimulator({@factoryParam Random? random}) : _random = random ?? Random();

  @override
  void start(List<String> gameIds, Map<String, OddsModel> initialOdds) {
    _timer?.cancel();
    var currentOdds = Map<String, OddsModel>.from(initialOdds);
    _controller.add(currentOdds);

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final gameId = gameIds[_random.nextInt(gameIds.length)];
      final odds = currentOdds[gameId];
      if (odds == null) return;

      currentOdds = Map<String, OddsModel>.from(currentOdds);
      currentOdds[gameId] = OddsModel(
        homeWin: _coefficient(odds.homeWin),
        draw: _coefficient(odds.draw),
        awayWin: _coefficient(odds.awayWin),
        overUnder: _coefficient(odds.overUnder),
      );
      _controller.add(currentOdds);
    });
  }

  double _coefficient(double value) {
    final delta = (_random.nextDouble() - 0.5) * 0.2;
    return double.parse((value + delta).clamp(1.01, 20.0).toStringAsFixed(2));
  }

  @override
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    stop();
    _controller.close();
  }
}
