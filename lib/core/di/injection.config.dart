// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:math' as _i407;

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sports_betting/core/router/app_router.dart' as _i364;
import 'package:sports_betting/data/repositories/auth_repository.dart' as _i795;
import 'package:sports_betting/data/repositories/games_repository.dart'
    as _i573;
import 'package:sports_betting/data/repositories/mock_games_repository.dart'
    as _i747;
import 'package:sports_betting/data/services/biometric_service.dart' as _i68;
import 'package:sports_betting/data/services/odds_simulator.dart' as _i880;
import 'package:sports_betting/data/services/token_storage_service.dart'
    as _i367;
import 'package:sports_betting/domain/usecases/biometric_login_usecase.dart'
    as _i725;
import 'package:sports_betting/domain/usecases/get_games_usecase.dart' as _i197;
import 'package:sports_betting/domain/usecases/login_usecase.dart' as _i146;
import 'package:sports_betting/domain/usecases/restore_session_usecase.dart'
    as _i862;
import 'package:sports_betting/presentation/screens/betting/bloc/betting_bloc.dart'
    as _i944;
import 'package:sports_betting/presentation/screens/login/bloc/auth_bloc.dart'
    as _i238;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i364.AppRouter>(() => _i364.AppRouter());
    gh.factoryParam<_i880.OddsSimulatorInterface, _i407.Random?, dynamic>(
      (random, _) => _i880.OddsSimulator(random: random),
    );
    gh.lazySingleton<_i367.TokenStorageServiceInterface>(
      () => _i367.TokenStorageService(),
    );
    gh.factory<_i68.BiometricServiceInterface>(() => _i68.BiometricService());
    gh.lazySingleton<_i795.AuthRepository>(
      () => _i795.AuthRepositoryImpl(
        biometricService: gh<_i68.BiometricServiceInterface>(),
        tokenStorageService: gh<_i367.TokenStorageServiceInterface>(),
      ),
    );
    gh.lazySingleton<_i573.GamesRepository>(() => _i747.MockGamesRepository());
    gh.factory<_i862.RestoreSessionUseCaseInterface>(
      () => _i862.RestoreSessionUseCase(
        authRepository: gh<_i795.AuthRepository>(),
      ),
    );
    gh.factory<_i725.BiometricLoginUseCaseInterface>(
      () => _i725.BiometricLoginUseCase(
        authRepository: gh<_i795.AuthRepository>(),
      ),
    );
    gh.factory<_i146.LoginUseCaseInterface>(
      () => _i146.LoginUseCase(authRepository: gh<_i795.AuthRepository>()),
    );
    gh.factory<_i197.GetGamesUseCaseInterface>(
      () => _i197.GetGamesUseCase(gamesRepository: gh<_i573.GamesRepository>()),
    );
    gh.singleton<_i238.AuthBloc>(
      () => _i238.AuthBloc(
        loginUseCase: gh<_i146.LoginUseCaseInterface>(),
        biometricLoginUseCase: gh<_i725.BiometricLoginUseCaseInterface>(),
        restoreSessionUseCase: gh<_i862.RestoreSessionUseCaseInterface>(),
        authRepository: gh<_i795.AuthRepository>(),
      ),
    );
    gh.factory<_i944.BettingBloc>(
      () => _i944.BettingBloc(
        getGamesUseCase: gh<_i197.GetGamesUseCaseInterface>(),
        oddsSimulator: gh<_i880.OddsSimulatorInterface>(),
      ),
    );
    return this;
  }
}
