import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/screens/betting/betting_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
@singleton
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: BettingRoute.page, guards: [AuthGuard()]),
      ];
}
