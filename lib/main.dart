import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injection.dart';
import 'presentation/screens/login/bloc/auth_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  getIt<AuthBloc>().add(const AuthEvent.checkAuthStatus());
  runApp(const App());
}
