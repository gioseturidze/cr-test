import 'package:injectable/injectable.dart';

import '../../data/repositories/auth_repository.dart';

abstract class LogoutUseCaseInterface {
  Future<void> call();
}

@Injectable(as: LogoutUseCaseInterface)
class LogoutUseCase implements LogoutUseCaseInterface {
  final AuthRepository _authRepository;

  LogoutUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<void> call() {
    return _authRepository.logout();
  }
}