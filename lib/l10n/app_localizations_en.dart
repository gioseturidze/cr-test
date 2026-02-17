// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sports Betting';

  @override
  String get signIn => 'Sign In';

  @override
  String get usernameHint => 'Username';

  @override
  String get passwordHint => 'Password';

  @override
  String get useBiometrics => 'Use Biometrics';

  @override
  String get biometricReason => 'Authenticate to access Sports Betting';

  @override
  String get usernameRequired => 'Please enter your username';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get passwordTooShort => 'Password must be at least 4 characters';

  @override
  String get invalidCredentials => 'Invalid credentials';

  @override
  String get emptyCredentials => 'Username and password are required';

  @override
  String get biometricUnavailable =>
      'Biometric authentication is not available';

  @override
  String get biometricFailed => 'Biometric authentication failed';

  @override
  String get gamesLoadFailed => 'Failed to load games';

  @override
  String get retry => 'Retry';

  @override
  String get matchResult => 'Match Result';

  @override
  String get totals => 'Totals';

  @override
  String get home => 'Home';

  @override
  String get draw => 'Draw';

  @override
  String get away => 'Away';

  @override
  String get overUnder => 'Over/Under 2.5';

  @override
  String get logout => 'Logout';

  @override
  String get refresh => 'Refresh';

  @override
  String get sessionExpired => 'Session expired. Please sign in again.';
}
