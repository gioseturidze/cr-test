import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:sports_betting/core/exceptions/app_exceptions.dart';
import 'package:sports_betting/data/models/user_model.dart';
import 'package:sports_betting/domain/usecases/login_usecase.dart';
import 'package:sports_betting/domain/usecases/biometric_login_usecase.dart';
import 'package:sports_betting/domain/usecases/logout_usecase.dart';
import 'package:sports_betting/domain/usecases/restore_session_usecase.dart';
import 'package:sports_betting/presentation/screens/login/bloc/auth_bloc.dart';

class MockLoginUseCase extends Mock implements LoginUseCaseInterface {}

class MockBiometricLoginUseCase extends Mock implements BiometricLoginUseCaseInterface {}

class MockRestoreSessionUseCase extends Mock implements RestoreSessionUseCaseInterface {}

class MockLogoutUseCase extends Mock implements LogoutUseCaseInterface {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockBiometricLoginUseCase mockBiometricLoginUseCase;
  late MockRestoreSessionUseCase mockRestoreSessionUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  const testUser = UserModel(
    id: 'user_1',
    username: 'testuser',
    displayName: 'Test User',
  );

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockBiometricLoginUseCase = MockBiometricLoginUseCase();
    mockRestoreSessionUseCase = MockRestoreSessionUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
  });

  AuthBloc buildBloc() => AuthBloc(
        loginUseCase: mockLoginUseCase,
        biometricLoginUseCase: mockBiometricLoginUseCase,
        restoreSessionUseCase: mockRestoreSessionUseCase,
        logoutUseCase: mockLogoutUseCase,
      );

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      final bloc = buildBloc();
      expect(bloc.state, const AuthState.initial());
      bloc.close();
    });

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] on successful login',
      build: () {
        when(() => mockLoginUseCase('testuser', 'password'))
            .thenAnswer((_) async => testUser);
        return buildBloc();
      },
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        username: 'testuser',
        password: 'password',
        usernameRequiredError: 'Please enter your username',
        passwordRequiredError: 'Please enter your password',
        passwordTooShortError: 'Password must be at least 4 characters',
      )),
      expect: () => [
        const AuthState.loading(),
        const AuthState.authenticated(testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] on failed login',
      build: () {
        when(() => mockLoginUseCase('testuser', 'wrong'))
            .thenThrow(const InvalidCredentialsException());
        return buildBloc();
      },
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        username: 'testuser',
        password: 'wrong',
        usernameRequiredError: 'Please enter your username',
        passwordRequiredError: 'Please enter your password',
        passwordTooShortError: 'Password must be at least 4 characters',
      )),
      expect: () => [
        const AuthState.loading(),
        isA<AuthError>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] on successful biometric login',
      build: () {
        when(() => mockBiometricLoginUseCase(biometricReason: any(named: 'biometricReason')))
            .thenAnswer((_) async => testUser);
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const AuthEvent.biometricLoginRequested(
            biometricReason: 'Authenticate to access Sports Betting',
          )),
      expect: () => [
        const AuthState.loading(),
        const AuthState.authenticated(testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, error] on failed biometric login',
      build: () {
        when(() => mockBiometricLoginUseCase(biometricReason: any(named: 'biometricReason')))
            .thenThrow(const BiometricAuthFailedException());
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const AuthEvent.biometricLoginRequested(
            biometricReason: 'Authenticate to access Sports Betting',
          )),
      expect: () => [
        const AuthState.loading(),
        isA<AuthError>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [initial] on logout',
      build: () {
        when(() => mockLogoutUseCase()).thenAnswer((_) async {});
        return buildBloc();
      },
      seed: () => const AuthState.authenticated(testUser),
      act: (bloc) => bloc.add(const AuthEvent.logoutRequested()),
      expect: () => [const AuthState.initial()],
      verify: (_) {
        verify(() => mockLogoutUseCase()).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [validationError] when username is empty',
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        username: '',
        password: 'password',
        usernameRequiredError: 'Please enter your username',
        passwordRequiredError: 'Please enter your password',
        passwordTooShortError: 'Password must be at least 4 characters',
      )),
      expect: () => [
        isA<AuthValidationError>().having(
          (s) => s.usernameError,
          'usernameError',
          'Please enter your username',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [validationError] when password is empty',
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        username: 'testuser',
        password: '',
        usernameRequiredError: 'Please enter your username',
        passwordRequiredError: 'Please enter your password',
        passwordTooShortError: 'Password must be at least 4 characters',
      )),
      expect: () => [
        isA<AuthValidationError>().having(
          (s) => s.passwordError,
          'passwordError',
          'Please enter your password',
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [validationError] when password is too short',
      build: buildBloc,
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        username: 'testuser',
        password: 'ab',
        usernameRequiredError: 'Please enter your username',
        passwordRequiredError: 'Please enter your password',
        passwordTooShortError: 'Password must be at least 4 characters',
      )),
      expect: () => [
        isA<AuthValidationError>().having(
          (s) => s.passwordError,
          'passwordError',
          'Password must be at least 4 characters',
        ),
      ],
    );
  });
}
