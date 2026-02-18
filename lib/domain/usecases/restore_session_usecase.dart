import 'package:injectable/injectable.dart';

import '../../data/models/user/user_model.dart';
import '../../data/repositories/auth_repository.dart';

abstract class RestoreSessionUseCaseInterface {
  Future<UserModel?> call();
}

@Injectable(as: RestoreSessionUseCaseInterface)
class RestoreSessionUseCase implements RestoreSessionUseCaseInterface {
  final AuthRepository _authRepository;

  RestoreSessionUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<UserModel?> call() {
    return _authRepository.restoreSession();
  }
}
