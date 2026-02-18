import 'package:freezed_annotation/freezed_annotation.dart';

part 'odds_model.freezed.dart';
part 'odds_model.g.dart';

@freezed
abstract class OddsModel with _$OddsModel {
  const factory OddsModel({
    required double homeWin,
    required double draw,
    required double awayWin,
    required double overUnder,
  }) = _OddsModel;

  factory OddsModel.fromJson(Map<String, dynamic> json) =>
      _$OddsModelFromJson(json);
}
