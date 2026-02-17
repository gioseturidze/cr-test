import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/app_router.dart';
import '../../../l10n/app_localizations.dart';
import 'bloc/auth_bloc.dart';
import 'widgets/login_button.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authenticated: (_) {
              context.router.replaceAll([const BettingRoute()]);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: theme.colorScheme.error,
                ),
              );
            },
          );
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sports_soccer,
                  size: 80,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.appTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 40),
                BlocSelector<AuthBloc, AuthState, String?>(
                  selector: (state) =>
                      state is AuthValidationError ? state.usernameError : null,
                  builder: (context, usernameError) {
                    return TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: l10n.usernameHint,
                        prefixIcon: const Icon(Icons.person_outline),
                        errorText: usernameError,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocSelector<AuthBloc, AuthState, String?>(
                  selector: (state) =>
                      state is AuthValidationError ? state.passwordError : null,
                  builder: (context, passwordError) {
                    return TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: l10n.passwordHint,
                        prefixIcon: const Icon(Icons.lock_outline),
                        errorText: passwordError,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                LoginButton(onPressed: _onLogin),
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: _onBiometricLogin,
                  icon: const Icon(Icons.fingerprint),
                  label: Text(l10n.useBiometrics),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    context.read<AuthBloc>().add(
          AuthEvent.loginRequested(
            username: _usernameController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  void _onBiometricLogin() {
    context.read<AuthBloc>().add(
          AuthEvent.biometricLoginRequested(
            biometricReason: AppLocalizations.of(context)!.biometricReason,
          ),
        );
  }
}
