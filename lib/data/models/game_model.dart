import 'package:freezed_annotation/freezed_annotation.dart';
import 'odds_model.dart';

part 'game_model.freezed.dart';
part 'game_model.g.dart';

@freezed
abstract class GameModel with _$GameModel {
  const factory GameModel({
    required String id,
    required String homeTeam,
    required String awayTeam,
    required String league,
    required DateTime startTime,
    required OddsModel odds,
  }) = _GameModel;

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);
}
