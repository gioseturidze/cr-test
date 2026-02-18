part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginRequested({
    required String username,
    required String password,
    required String usernameRequiredError,
    required String passwordRequiredError,
    required String passwordTooShortError,
  }) = LoginRequested;

  const factory AuthEvent.biometricLoginRequested({
    required String biometricReason,
  }) = BiometricLoginRequested;

  const factory AuthEvent.logoutRequested() = LogoutRequested;

  const factory AuthEvent.checkAuthStatus() = CheckAuthStatus;
}
