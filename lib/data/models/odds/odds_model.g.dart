// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OddsModel _$OddsModelFromJson(Map<String, dynamic> json) => _OddsModel(
  homeWin: (json['homeWin'] as num).toDouble(),
  draw: (json['draw'] as num).toDouble(),
  awayWin: (json['awayWin'] as num).toDouble(),
  overUnder: (json['overUnder'] as num).toDouble(),
);

Map<String, dynamic> _$OddsModelToJson(_OddsModel instance) =>
    <String, dynamic>{
      'homeWin': instance.homeWin,
      'draw': instance.draw,
      'awayWin': instance.awayWin,
      'overUnder': instance.overUnder,
    };
