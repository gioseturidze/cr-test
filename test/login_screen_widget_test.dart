import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sports_betting/l10n/app_localizations.dart';
import 'package:sports_betting/presentation/screens/login/bloc/auth_bloc.dart';
import 'package:sports_betting/presentation/screens/login/login_screen.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  tearDown(() {
    mockAuthBloc.close();
  });

  Widget buildScreen() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const LoginScreen(),
      ),
    );
  }

  group('LoginScreen', () {
    testWidgets('shows username errorText when state has usernameError', (tester) async {
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([
          const AuthState.validationError(usernameError: 'Please enter your username'),
        ]),
        initialState: const AuthState.initial(),
      );

      await tester.pumpWidget(buildScreen());
      await tester.pump();

      expect(find.text('Please enter your username'), findsOneWidget);
    });

    testWidgets('shows password errorText when state has passwordError', (tester) async {
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([
          const AuthState.validationError(
            passwordError: 'Password must be at least 4 characters',
          ),
        ]),
        initialState: const AuthState.initial(),
      );

      await tester.pumpWidget(buildScreen());
      await tester.pump();

      expect(find.text('Password must be at least 4 characters'), findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([const AuthState.loading()]),
        initialState: const AuthState.initial(),
      );

      await tester.pumpWidget(buildScreen());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows SnackBar with message on error state', (tester) async {
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([const AuthState.error('Invalid credentials')]),
        initialState: const AuthState.initial(),
      );

      await tester.pumpWidget(buildScreen());
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}