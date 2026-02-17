// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'betting_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BettingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BettingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BettingEvent()';
}


}

/// @nodoc
class $BettingEventCopyWith<$Res>  {
$BettingEventCopyWith(BettingEvent _, $Res Function(BettingEvent) __);
}


/// Adds pattern-matching-related methods to [BettingEvent].
extension BettingEventPatterns on BettingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadGames value)?  loadGames,TResult Function( OddsUpdated value)?  oddsUpdated,TResult Function( ToggleGameExpanded value)?  toggleGameExpanded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadGames() when loadGames != null:
return loadGames(_that);case OddsUpdated() when oddsUpdated != null:
return oddsUpdated(_that);case ToggleGameExpanded() when toggleGameExpanded != null:
return toggleGameExpanded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadGames value)  loadGames,required TResult Function( OddsUpdated value)  oddsUpdated,required TResult Function( ToggleGameExpanded value)  toggleGameExpanded,}){
final _that = this;
switch (_that) {
case LoadGames():
return loadGames(_that);case OddsUpdated():
return oddsUpdated(_that);case ToggleGameExpanded():
return toggleGameExpanded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadGames value)?  loadGames,TResult? Function( OddsUpdated value)?  oddsUpdated,TResult? Function( ToggleGameExpanded value)?  toggleGameExpanded,}){
final _that = this;
switch (_that) {
case LoadGames() when loadGames != null:
return loadGames(_that);case OddsUpdated() when oddsUpdated != null:
return oddsUpdated(_that);case ToggleGameExpanded() when toggleGameExpanded != null:
return toggleGameExpanded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadGames,TResult Function( Map<String, OddsModel> odds)?  oddsUpdated,TResult Function( String gameId)?  toggleGameExpanded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadGames() when loadGames != null:
return loadGames();case OddsUpdated() when oddsUpdated != null:
return oddsUpdated(_that.odds);case ToggleGameExpanded() when toggleGameExpanded != null:
return toggleGameExpanded(_that.gameId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadGames,required TResult Function( Map<String, OddsModel> odds)  oddsUpdated,required TResult Function( String gameId)  toggleGameExpanded,}) {final _that = this;
switch (_that) {
case LoadGames():
return loadGames();case OddsUpdated():
return oddsUpdated(_that.odds);case ToggleGameExpanded():
return toggleGameExpanded(_that.gameId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadGames,TResult? Function( Map<String, OddsModel> odds)?  oddsUpdated,TResult? Function( String gameId)?  toggleGameExpanded,}) {final _that = this;
switch (_that) {
case LoadGames() when loadGames != null:
return loadGames();case OddsUpdated() when oddsUpdated != null:
return oddsUpdated(_that.odds);case ToggleGameExpanded() when toggleGameExpanded != null:
return toggleGameExpanded(_that.gameId);case _:
  return null;

}
}

}

/// @nodoc


class LoadGames implements BettingEvent {
  const LoadGames();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadGames);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BettingEvent.loadGames()';
}


}




/// @nodoc


class OddsUpdated implements BettingEvent {
  const OddsUpdated(final  Map<String, OddsModel> odds): _odds = odds;
  

 final  Map<String, OddsModel> _odds;
 Map<String, OddsModel> get odds {
  if (_odds is EqualUnmodifiableMapView) return _odds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_odds);
}


/// Create a copy of BettingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OddsUpdatedCopyWith<OddsUpdated> get copyWith => _$OddsUpdatedCopyWithImpl<OddsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OddsUpdated&&const DeepCollectionEquality().equals(other._odds, _odds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_odds));

@override
String toString() {
  return 'BettingEvent.oddsUpdated(odds: $odds)';
}


}

/// @nodoc
abstract mixin class $OddsUpdatedCopyWith<$Res> implements $BettingEventCopyWith<$Res> {
  factory $OddsUpdatedCopyWith(OddsUpdated value, $Res Function(OddsUpdated) _then) = _$OddsUpdatedCopyWithImpl;
@useResult
$Res call({
 Map<String, OddsModel> odds
});




}
/// @nodoc
class _$OddsUpdatedCopyWithImpl<$Res>
    implements $OddsUpdatedCopyWith<$Res> {
  _$OddsUpdatedCopyWithImpl(this._self, this._then);

  final OddsUpdated _self;
  final $Res Function(OddsUpdated) _then;

/// Create a copy of BettingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? odds = null,}) {
  return _then(OddsUpdated(
null == odds ? _self._odds : odds // ignore: cast_nullable_to_non_nullable
as Map<String, OddsModel>,
  ));
}


}

/// @nodoc


class ToggleGameExpanded implements BettingEvent {
  const ToggleGameExpanded(this.gameId);
  

 final  String gameId;

/// Create a copy of BettingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleGameExpandedCopyWith<ToggleGameExpanded> get copyWith => _$ToggleGameExpandedCopyWithImpl<ToggleGameExpanded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleGameExpanded&&(identical(other.gameId, gameId) || other.gameId == gameId));
}


@override
int get hashCode => Object.hash(runtimeType,gameId);

@override
String toString() {
  return 'BettingEvent.toggleGameExpanded(gameId: $gameId)';
}


}

/// @nodoc
abstract mixin class $ToggleGameExpandedCopyWith<$Res> implements $BettingEventCopyWith<$Res> {
  factory $ToggleGameExpandedCopyWith(ToggleGameExpanded value, $Res Function(ToggleGameExpanded) _then) = _$ToggleGameExpandedCopyWithImpl;
@useResult
$Res call({
 String gameId
});




}
/// @nodoc
class _$ToggleGameExpandedCopyWithImpl<$Res>
    implements $ToggleGameExpandedCopyWith<$Res> {
  _$ToggleGameExpandedCopyWithImpl(this._self, this._then);

  final ToggleGameExpanded _self;
  final $Res Function(ToggleGameExpanded) _then;

/// Create a copy of BettingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? gameId = null,}) {
  return _then(ToggleGameExpanded(
null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BettingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BettingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BettingState()';
}


}

/// @nodoc
class $BettingStateCopyWith<$Res>  {
$BettingStateCopyWith(BettingState _, $Res Function(BettingState) __);
}


/// Adds pattern-matching-related methods to [BettingState].
extension BettingStatePatterns on BettingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BettingInitial value)?  initial,TResult Function( BettingLoading value)?  loading,TResult Function( BettingLoaded value)?  loaded,TResult Function( BettingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BettingInitial() when initial != null:
return initial(_that);case BettingLoading() when loading != null:
return loading(_that);case BettingLoaded() when loaded != null:
return loaded(_that);case BettingError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BettingInitial value)  initial,required TResult Function( BettingLoading value)  loading,required TResult Function( BettingLoaded value)  loaded,required TResult Function( BettingError value)  error,}){
final _that = this;
switch (_that) {
case BettingInitial():
return initial(_that);case BettingLoading():
return loading(_that);case BettingLoaded():
return loaded(_that);case BettingError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BettingInitial value)?  initial,TResult? Function( BettingLoading value)?  loading,TResult? Function( BettingLoaded value)?  loaded,TResult? Function( BettingError value)?  error,}){
final _that = this;
switch (_that) {
case BettingInitial() when initial != null:
return initial(_that);case BettingLoading() when loading != null:
return loading(_that);case BettingLoaded() when loaded != null:
return loaded(_that);case BettingError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<GameModel> games,  Map<String, OddsModel> liveOdds,  Set<String> expandedGameIds)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BettingInitial() when initial != null:
return initial();case BettingLoading() when loading != null:
return loading();case BettingLoaded() when loaded != null:
return loaded(_that.games,_that.liveOdds,_that.expandedGameIds);case BettingError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<GameModel> games,  Map<String, OddsModel> liveOdds,  Set<String> expandedGameIds)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case BettingInitial():
return initial();case BettingLoading():
return loading();case BettingLoaded():
return loaded(_that.games,_that.liveOdds,_that.expandedGameIds);case BettingError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<GameModel> games,  Map<String, OddsModel> liveOdds,  Set<String> expandedGameIds)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case BettingInitial() when initial != null:
return initial();case BettingLoading() when loading != null:
return loading();case BettingLoaded() when loaded != null:
return loaded(_that.games,_that.liveOdds,_that.expandedGameIds);case BettingError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class BettingInitial implements BettingState {
  const BettingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BettingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BettingState.initial()';
}


}




/// @nodoc


class BettingLoading implements BettingState {
  const BettingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BettingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BettingState.loading()';
}


}




/// @nodoc


class BettingLoaded implements BettingState {
  const BettingLoaded({required final  List<GameModel> games, required final  Map<String, OddsModel> liveOdds, final  Set<String> expandedGameIds = const {}}): _games = games,_liveOdds = liveOdds,_expandedGameIds = expandedGameIds;
  

 final  List<GameModel> _games;
 List<GameModel> get games {
  if (_games is EqualUnmodifiableListView) return _games;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_games);
}

 final  Map<String, OddsModel> _liveOdds;
 Map<String, OddsModel> get liveOdds {
  if (_liveOdds is EqualUnmodifiableMapView) return _liveOdds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_liveOdds);
}

 final  Set<String> _expandedGameIds;
@JsonKey() Set<String> get expandedGameIds {
  if (_expandedGameIds is EqualUnmodifiableSetView) return _expandedGameIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_expandedGameIds);
}


/// Create a copy of BettingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BettingLoadedCopyWith<BettingLoaded> get copyWith => _$BettingLoadedCopyWithImpl<BettingLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BettingLoaded&&const DeepCollectionEquality().equals(other._games, _games)&&const DeepCollectionEquality().equals(other._liveOdds, _liveOdds)&&const DeepCollectionEquality().equals(other._expandedGameIds, _expandedGameIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_games),const DeepCollectionEquality().hash(_liveOdds),const DeepCollectionEquality().hash(_expandedGameIds));

@override
String toString() {
  return 'BettingState.loaded(games: $games, liveOdds: $liveOdds, expandedGameIds: $expandedGameIds)';
}


}

/// @nodoc
abstract mixin class $BettingLoadedCopyWith<$Res> implements $BettingStateCopyWith<$Res> {
  factory $BettingLoadedCopyWith(BettingLoaded value, $Res Function(BettingLoaded) _then) = _$BettingLoadedCopyWithImpl;
@useResult
$Res call({
 List<GameModel> games, Map<String, OddsModel> liveOdds, Set<String> expandedGameIds
});




}
/// @nodoc
class _$BettingLoadedCopyWithImpl<$Res>
    implements $BettingLoadedCopyWith<$Res> {
  _$BettingLoadedCopyWithImpl(this._self, this._then);

  final BettingLoaded _self;
  final $Res Function(BettingLoaded) _then;

/// Create a copy of BettingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? games = null,Object? liveOdds = null,Object? expandedGameIds = null,}) {
  return _then(BettingLoaded(
games: null == games ? _self._games : games // ignore: cast_nullable_to_non_nullable
as List<GameModel>,liveOdds: null == liveOdds ? _self._liveOdds : liveOdds // ignore: cast_nullable_to_non_nullable
as Map<String, OddsModel>,expandedGameIds: null == expandedGameIds ? _self._expandedGameIds : expandedGameIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

/// @nodoc


class BettingError implements BettingState {
  const BettingError(this.message);
  

 final  String message;

/// Create a copy of BettingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BettingErrorCopyWith<BettingError> get copyWith => _$BettingErrorCopyWithImpl<BettingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BettingError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BettingState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $BettingErrorCopyWith<$Res> implements $BettingStateCopyWith<$Res> {
  factory $BettingErrorCopyWith(BettingError value, $Res Function(BettingError) _then) = _$BettingErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$BettingErrorCopyWithImpl<$Res>
    implements $BettingErrorCopyWith<$Res> {
  _$BettingErrorCopyWithImpl(this._self, this._then);

  final BettingError _self;
  final $Res Function(BettingError) _then;

/// Create a copy of BettingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(BettingError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
