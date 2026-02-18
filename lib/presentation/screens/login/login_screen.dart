import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/app_router.dart';
import '../../../l10n/app_localizations.dart';
import 'bloc/auth_bloc.dart';

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
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (prev, curr) =>
                      (prev is AuthLoading) != (curr is AuthLoading),
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: null,
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          context.read<AuthBloc>().add(
                            AuthEvent.loginRequested(
                              username: _usernameController.text.trim(),
                              password: _passwordController.text,
                              usernameRequiredError: l10n.usernameRequired,
                              passwordRequiredError: l10n.passwordRequired,
                              passwordTooShortError: l10n.passwordTooShort,
                            ),
                          );
                        },
                        child: Text(l10n.signIn),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      AuthEvent.biometricLoginRequested(
                        biometricReason: AppLocalizations.of(context)!.biometricReason,
                      ),
                    );
                  },
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
}
