import 'package:injectable/injectable.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

abstract class LoginUseCaseInterface {
  Future<UserModel> call(String username, String password);
}

@Injectable(as: LoginUseCaseInterface)
class LoginUseCase implements LoginUseCaseInterface {
  final AuthRepository _authRepository;

  LoginUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<UserModel> call(String username, String password) {
    return _authRepository.login(username, password);
  }
}
