# Sports Betting App

A sports betting application with live odds simulation, biometric authentication, persistent session, and clean architecture.

## Architecture

Clean Architecture with three layers + feature-based presentation:

```
lib/
├── core/          # DI (get_it + injectable), router (auto_route + AuthGuard), theme, exceptions
├── data/          # Models (freezed), repositories (implementations), services
├── domain/        # Use cases (abstractions + implementations)
└── presentation/  # Feature screens with BLoC (events + states via part files)
```

Each layer depends only on the one above it: `presentation → domain → data`. All cross-layer dependencies go through abstract interfaces, injected via GetIt.

## Tech Stack

| Category | Library |
|----------|---------|
| State Management | `flutter_bloc` (BLoC pattern with freezed events/states) |
| Routing | `auto_route` + `auto_route_generator` with `AuthGuard` |
| DI | `get_it` + `injectable` + `injectable_generator` |
| Models | `freezed` + `json_serializable` |
| Biometrics | `local_auth` |
| Persistent Auth | `flutter_secure_storage` |
| Localization | `flutter_localizations` + `intl` (EN + RU) |
| Auto-scroll | `scroll_to_index` |
| Code Generation | `build_runner` |
| Testing | `bloc_test`, `mocktail` |

## Features

- Login with username/password or biometric authentication
- Persistent session — token + user saved in secure storage, auto-restored on app restart
- Live betting screen with expandable game tiles (accordion with auto-scroll)
- Real-time odds simulation every 3 seconds with animated updates (color-coded up/down arrows)
- Performance optimizations: `buildWhen` on LoginButton, `BlocSelector` for granular error state selection
- Dark theme designed for betting UI

## Architectural Decisions

### Clean Architecture with abstract interfaces everywhere
Every repository, use case, and service has an abstract interface. BLoC and use cases depend on abstractions, never on concrete classes. This makes testing trivial (mock any dependency via `mocktail`) and allows swapping implementations (e.g. mock repository → real API) without touching consumers.

### GetIt + injectable for DI (not BlocProvider/RepositoryProvider)
Using `get_it` with `injectable` code generation instead of widget-tree-based `RepositoryProvider`. This decouples dependency resolution from the widget tree — services and repositories are available anywhere without `context`, and the `AuthGuard` can access `AuthBloc` directly via `getIt<AuthBloc>()`.

### BLoC scoping: global AuthBloc, feature-scoped BettingBloc
`AuthBloc` is a `@singleton` because auth state is needed globally (guard, multiple screens). `BettingBloc` is `@injectable` (factory) — created per screen lifecycle, so each visit to the betting screen gets a fresh state and a new odds simulator subscription.

### Freezed events/states via `part` files
Events and states live in separate files connected via `part` to the bloc file. A single `.freezed.dart` file is generated per bloc, keeping the code organized while maintaining sealed union types.

### Persistent auth with flutter_secure_storage
Tokens and user data are stored as JSON in secure storage. On app start, `CheckAuthStatus` event triggers session restoration: token expiry is checked, refreshed if needed, and the user is re-authenticated without showing the login screen.

### Validation in BLoC, not in UI
Form validation happens in the bloc via state-driven `validationError` states. The UI reads error strings from state and passes them to `InputDecoration.errorText`. No `Form` widget or `validator` callbacks — single source of truth in the bloc.

### Custom exceptions instead of generic Exception
Each error case has a dedicated exception class (`InvalidCredentialsException`, `BiometricAuthFailedException`, `SessionExpiredException`, etc.). BLoC handlers use typed `on ... catch` blocks, mapping each exception to a user-facing message.

### Router doesn't know about BLoCs
`AppRouter` defines routes declaratively. Auth logic lives in `AuthGuard`, which checks `AuthBloc` state via GetIt. Navigation triggers come from `BlocListener` in the UI, not from the router itself.

## Trade-offs

| Decision | Benefit | Cost |
|----------|---------|------|
| Mock data instead of real API | No backend dependency, instant setup, predictable testing | Need to replace all mock repositories when integrating real API |
| `@singleton` AuthBloc | Single auth state, accessible from guard and any screen | Lives for entire app lifetime, must be explicitly reset on logout |
| Secure storage for tokens | Encrypted, persistent, survives app restarts | Slightly slower than SharedPreferences; no web support in flutter_secure_storage |
| One freezed file per bloc (events + states combined) | Fewer generated files, simpler imports | Larger generated files; events and states coupled to one bloc |
| Dark theme only | Focused design, consistent betting UI look | No light theme option for users who prefer it |
| Odds simulation on all 8 games with single random pick per tick | Simple, lightweight timer | A specific game updates on average every ~24 seconds (3s × 8 games) |

## Assumptions

- **No real backend** — all data is mocked. `AuthRepositoryImpl` accepts any username with 4+ char password. Token refresh is simulated locally.
- **Biometric user is hardcoded** — biometric login always returns the same `UserModel` ("Biometric User") since there's no backend to resolve identity.
- **Token expiry = 1 hour** — mock tokens expire after 1 hour; on restore, expired tokens are silently refreshed (simulating a refresh endpoint).
- **Two locales** — EN and RU only. All user-facing strings are in `.arb` files.
- **iOS/Android only** — `flutter_secure_storage` and `local_auth` target mobile platforms.

## Getting Started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Running Tests

```bash
flutter test
```

### Test Coverage

- **auth_bloc_test.dart** — Login, biometric login, logout, validation flows
- **betting_bloc_test.dart** — Game loading, odds updates, accordion toggle
- **odds_simulator_test.dart** — Odds fluctuation, bounds clamping, timer lifecycle

## Login Credentials

Any username with a password of 4+ characters will authenticate successfully (mock backend).
