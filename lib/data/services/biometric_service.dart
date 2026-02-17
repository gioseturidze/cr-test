import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

abstract class BiometricServiceInterface {
  Future<bool> isAvailable();
  Future<bool> authenticate({required String title});
}

@Injectable(as: BiometricServiceInterface)
class BiometricService implements BiometricServiceInterface {
  final LocalAuthentication _localAuth;

  BiometricService() : _localAuth = LocalAuthentication();

  BiometricService.withAuth(LocalAuthentication localAuth)
      : _localAuth = localAuth;

  @override
  Future<bool> isAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> authenticate({required String title}) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: title,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}
