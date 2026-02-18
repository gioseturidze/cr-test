import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../data/models/user/user_model.dart';
import '../../../../domain/usecases/biometric_login_usecase.dart';
import '../../../../domain/usecases/login_usecase.dart';
import '../../../../domain/usecases/logout_usecase.dart';
import '../../../../domain/usecases/restore_session_usecase.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCaseInterface _loginUseCase;
  final BiometricLoginUseCaseInterface _biometricLoginUseCase;
  final RestoreSessionUseCaseInterface _restoreSessionUseCase;
  final LogoutUseCaseInterface _logoutUseCase;

  AuthBloc({
    required LoginUseCaseInterface loginUseCase,
    required BiometricLoginUseCaseInterface biometricLoginUseCase,
    required RestoreSessionUseCaseInterface restoreSessionUseCase,
    required LogoutUseCaseInterface logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _biometricLoginUseCase = biometricLoginUseCase,
        _restoreSessionUseCase = restoreSessionUseCase,
        _logoutUseCase = logoutUseCase,
        super(const AuthState.initial()) {
    on<LoginRequested>(_onLoginRequested);
    on<BiometricLoginRequested>(_onBiometricLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    final usernameError = event.username.isEmpty ? event.usernameRequiredError : null;
    final passwordError = event.password.isEmpty
        ? event.passwordRequiredError
        : event.password.length < 4
            ? event.passwordTooShortError
            : null;

    if (usernameError != null || passwordError != null) {
      emit(AuthState.validationError(
        usernameError: usernameError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(const AuthState.loading());
    try {
      final user = await _loginUseCase(event.username, event.password);
      emit(AuthState.authenticated(user));
    } on InvalidCredentialsException catch (e) {
      emit(AuthState.error(e.message));
    } on EmptyCredentialsException catch (e) {
      emit(AuthState.error(e.message));
    }
  }

  Future<void> _onBiometricLoginRequested(
    BiometricLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await _biometricLoginUseCase(biometricReason: event.biometricReason);
      emit(AuthState.authenticated(user));
    } on BiometricUnavailableException catch (e) {
      emit(AuthState.error(e.message));
    } on BiometricAuthFailedException catch (e) {
      emit(AuthState.error(e.message));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase();
    emit(const AuthState.initial());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      final user = await _restoreSessionUseCase();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.initial());
      }
    } on SessionExpiredException {
      emit(const AuthState.initial());
    }
  }
}
