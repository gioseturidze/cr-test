// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameModel _$GameModelFromJson(Map<String, dynamic> json) => _GameModel(
  id: json['id'] as String,
  homeTeam: json['homeTeam'] as String,
  awayTeam: json['awayTeam'] as String,
  league: json['league'] as String,
  startTime: DateTime.parse(json['startTime'] as String),
  odds: OddsModel.fromJson(json['odds'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GameModelToJson(_GameModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'league': instance.league,
      'startTime': instance.startTime.toIso8601String(),
      'odds': instance.odds,
    };
