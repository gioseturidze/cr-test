import 'package:auto_route/auto_route.dart';

import '../di/injection.dart';
import '../../presentation/screens/login/bloc/auth_bloc.dart';
import 'app_router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authBloc = getIt<AuthBloc>();
    final isAuthenticated = authBloc.state is AuthAuthenticated;

    if (isAuthenticated) {
      resolver.next();
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
