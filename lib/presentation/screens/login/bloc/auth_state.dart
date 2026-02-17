part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(UserModel user) = AuthAuthenticated;
  const factory AuthState.error(String message) = AuthError;
  const factory AuthState.validationError({
    String? usernameError,
    String? passwordError,
  }) = AuthValidationError;
}
