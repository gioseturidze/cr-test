import 'package:injectable/injectable.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

abstract class BiometricLoginUseCaseInterface {
  Future<UserModel> call({required String biometricReason});
}

@Injectable(as: BiometricLoginUseCaseInterface)
class BiometricLoginUseCase implements BiometricLoginUseCaseInterface {
  final AuthRepository _authRepository;

  BiometricLoginUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<UserModel> call({required String biometricReason}) {
    return _authRepository.loginWithBiometrics(biometricReason: biometricReason);
  }
}
