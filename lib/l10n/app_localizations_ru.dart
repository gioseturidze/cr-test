// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Ставки на спорт';

  @override
  String get signIn => 'Войти';

  @override
  String get usernameHint => 'Имя пользователя';

  @override
  String get passwordHint => 'Пароль';

  @override
  String get useBiometrics => 'Биометрия';

  @override
  String get biometricReason => 'Авторизуйтесь для доступа к ставкам';

  @override
  String get usernameRequired => 'Введите имя пользователя';

  @override
  String get passwordRequired => 'Введите пароль';

  @override
  String get passwordTooShort => 'Пароль должен содержать минимум 4 символа';

  @override
  String get invalidCredentials => 'Неверные учётные данные';

  @override
  String get emptyCredentials => 'Имя пользователя и пароль обязательны';

  @override
  String get biometricUnavailable => 'Биометрическая аутентификация недоступна';

  @override
  String get biometricFailed => 'Биометрическая аутентификация не удалась';

  @override
  String get gamesLoadFailed => 'Не удалось загрузить матчи';

  @override
  String get retry => 'Повторить';

  @override
  String get matchResult => 'Результат матча';

  @override
  String get totals => 'Тоталы';

  @override
  String get home => 'Хозяева';

  @override
  String get draw => 'Ничья';

  @override
  String get away => 'Гости';

  @override
  String get overUnder => 'Больше/Меньше 2.5';

  @override
  String get logout => 'Выход';

  @override
  String get refresh => 'Обновить';

  @override
  String get sessionExpired => 'Сессия истекла. Пожалуйста, войдите снова.';
}
