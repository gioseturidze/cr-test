import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../models/auth_token/auth_token_model.dart';
import '../models/user/user_model.dart';

abstract class TokenStorageServiceInterface {
  Future<void> saveToken(AuthTokenModel token);
  Future<void> saveUser(UserModel user);
  Future<AuthTokenModel?> getToken();
  Future<UserModel?> getUser();
  Future<void> clear();
}

@LazySingleton(as: TokenStorageServiceInterface)
class TokenStorageService implements TokenStorageServiceInterface {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  final FlutterSecureStorage _storage;

  TokenStorageService() : _storage = const FlutterSecureStorage();

  @override
  Future<void> saveToken(AuthTokenModel token) async {
    await _storage.write(key: _tokenKey, value: jsonEncode(token.toJson()));
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await _storage.write(key: _userKey, value: jsonEncode(user.toJson()));
  }

  @override
  Future<AuthTokenModel?> getToken() async {
    final raw = await _storage.read(key: _tokenKey);
    if (raw == null) return null;
    return AuthTokenModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<UserModel?> getUser() async {
    final raw = await _storage.read(key: _userKey);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }
}
