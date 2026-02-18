import 'package:injectable/injectable.dart';

import '../../core/exceptions/app_exceptions.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';
import '../services/biometric_service.dart';
import '../services/token_storage_service.dart';

abstract class AuthRepository {
  UserModel? get currentUser;
  Future<UserModel> login(String username, String password);
  Future<UserModel> loginWithBiometrics({required String biometricReason});
  Future<UserModel?> restoreSession();
  Future<void> logout();
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final BiometricServiceInterface _biometricService;
  final TokenStorageServiceInterface _tokenStorageService;

  UserModel? _currentUser;

  AuthRepositoryImpl({
    required BiometricServiceInterface biometricService,
    required TokenStorageServiceInterface tokenStorageService,
  })  : _biometricService = biometricService,
        _tokenStorageService = tokenStorageService;

  @override
  UserModel? get currentUser => _currentUser;

  Future<void> _persistSession(UserModel user) async {
    final now = DateTime.now();
    final token = AuthTokenModel(
      accessToken: 'access_${now.microsecondsSinceEpoch}',
      refreshToken: 'refresh_${now.microsecondsSinceEpoch}',
      expiresAt: now.add(const Duration(hours: 1)),
    );
    await _tokenStorageService.saveToken(token);
    await _tokenStorageService.saveUser(user);
  }

  @override
  Future<UserModel> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = UserModel(
      id: 'user_${username.hashCode.abs()}',
      username: username,
      displayName: username[0].toUpperCase() + username.substring(1),
    );

    await _persistSession(_currentUser!);

    return _currentUser!;
  }

  @override
  Future<UserModel> loginWithBiometrics({required String biometricReason}) async {
    final isAvailable = await _biometricService.isAvailable();
    if (!isAvailable) {
      throw const BiometricUnavailableException();
    }

    final authenticated = await _biometricService.authenticate(title: biometricReason);
    if (!authenticated) {
      throw const BiometricAuthFailedException();
    }

    _currentUser = const UserModel(
      id: 'user_biometric',
      username: 'biometric_user',
      displayName: 'Biometric User',
    );

    await _persistSession(_currentUser!);

    return _currentUser!;
  }

  @override
  Future<UserModel?> restoreSession() async {
    final token = await _tokenStorageService.getToken();
    if (token == null) return null;

    if (token.expiresAt.isBefore(DateTime.now())) {
      final refreshedToken = AuthTokenModel(
        accessToken: 'access_refreshed_${DateTime.now().microsecondsSinceEpoch}',
        refreshToken: token.refreshToken,
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
      );
      await _tokenStorageService.saveToken(refreshedToken);
    }

    final user = await _tokenStorageService.getUser();
    if (user == null) {
      await _tokenStorageService.clear();
      throw const SessionExpiredException();
    }

    _currentUser = user;
    return _currentUser;
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
    await _tokenStorageService.clear();
  }
}
