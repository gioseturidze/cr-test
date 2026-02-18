// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameModel {

 String get id; String get homeTeam; String get awayTeam; String get league; DateTime get startTime; OddsModel get odds;
/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameModelCopyWith<GameModel> get copyWith => _$GameModelCopyWithImpl<GameModel>(this as GameModel, _$identity);

  /// Serializes this GameModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameModel&&(identical(other.id, id) || other.id == id)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.league, league) || other.league == league)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.odds, odds) || other.odds == odds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,homeTeam,awayTeam,league,startTime,odds);

@override
String toString() {
  return 'GameModel(id: $id, homeTeam: $homeTeam, awayTeam: $awayTeam, league: $league, startTime: $startTime, odds: $odds)';
}


}

/// @nodoc
abstract mixin class $GameModelCopyWith<$Res>  {
  factory $GameModelCopyWith(GameModel value, $Res Function(GameModel) _then) = _$GameModelCopyWithImpl;
@useResult
$Res call({
 String id, String homeTeam, String awayTeam, String league, DateTime startTime, OddsModel odds
});


$OddsModelCopyWith<$Res> get odds;

}
/// @nodoc
class _$GameModelCopyWithImpl<$Res>
    implements $GameModelCopyWith<$Res> {
  _$GameModelCopyWithImpl(this._self, this._then);

  final GameModel _self;
  final $Res Function(GameModel) _then;

/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? homeTeam = null,Object? awayTeam = null,Object? league = null,Object? startTime = null,Object? odds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,league: null == league ? _self.league : league // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,odds: null == odds ? _self.odds : odds // ignore: cast_nullable_to_non_nullable
as OddsModel,
  ));
}
/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OddsModelCopyWith<$Res> get odds {
  
  return $OddsModelCopyWith<$Res>(_self.odds, (value) {
    return _then(_self.copyWith(odds: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameModel].
extension GameModelPatterns on GameModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameModel value)  $default,){
final _that = this;
switch (_that) {
case _GameModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameModel value)?  $default,){
final _that = this;
switch (_that) {
case _GameModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String homeTeam,  String awayTeam,  String league,  DateTime startTime,  OddsModel odds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameModel() when $default != null:
return $default(_that.id,_that.homeTeam,_that.awayTeam,_that.league,_that.startTime,_that.odds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String homeTeam,  String awayTeam,  String league,  DateTime startTime,  OddsModel odds)  $default,) {final _that = this;
switch (_that) {
case _GameModel():
return $default(_that.id,_that.homeTeam,_that.awayTeam,_that.league,_that.startTime,_that.odds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String homeTeam,  String awayTeam,  String league,  DateTime startTime,  OddsModel odds)?  $default,) {final _that = this;
switch (_that) {
case _GameModel() when $default != null:
return $default(_that.id,_that.homeTeam,_that.awayTeam,_that.league,_that.startTime,_that.odds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameModel implements GameModel {
  const _GameModel({required this.id, required this.homeTeam, required this.awayTeam, required this.league, required this.startTime, required this.odds});
  factory _GameModel.fromJson(Map<String, dynamic> json) => _$GameModelFromJson(json);

@override final  String id;
@override final  String homeTeam;
@override final  String awayTeam;
@override final  String league;
@override final  DateTime startTime;
@override final  OddsModel odds;

/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameModelCopyWith<_GameModel> get copyWith => __$GameModelCopyWithImpl<_GameModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameModel&&(identical(other.id, id) || other.id == id)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.league, league) || other.league == league)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.odds, odds) || other.odds == odds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,homeTeam,awayTeam,league,startTime,odds);

@override
String toString() {
  return 'GameModel(id: $id, homeTeam: $homeTeam, awayTeam: $awayTeam, league: $league, startTime: $startTime, odds: $odds)';
}


}

/// @nodoc
abstract mixin class _$GameModelCopyWith<$Res> implements $GameModelCopyWith<$Res> {
  factory _$GameModelCopyWith(_GameModel value, $Res Function(_GameModel) _then) = __$GameModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String homeTeam, String awayTeam, String league, DateTime startTime, OddsModel odds
});


@override $OddsModelCopyWith<$Res> get odds;

}
/// @nodoc
class __$GameModelCopyWithImpl<$Res>
    implements _$GameModelCopyWith<$Res> {
  __$GameModelCopyWithImpl(this._self, this._then);

  final _GameModel _self;
  final $Res Function(_GameModel) _then;

/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? homeTeam = null,Object? awayTeam = null,Object? league = null,Object? startTime = null,Object? odds = null,}) {
  return _then(_GameModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,homeTeam: null == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String,awayTeam: null == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String,league: null == league ? _self.league : league // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,odds: null == odds ? _self.odds : odds // ignore: cast_nullable_to_non_nullable
as OddsModel,
  ));
}

/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OddsModelCopyWith<$Res> get odds {
  
  return $OddsModelCopyWith<$Res>(_self.odds, (value) {
    return _then(_self.copyWith(odds: value));
  });
}
}

// dart format on
