# CLAUDE.md — Sports Betting App

## Стек
- `flutter_bloc` — state management
- `auto_route` + `auto_route_generator` — навигация с кодогенерацией
- `get_it` + `injectable` + `injectable_generator` — DI
- `freezed` + `freezed_annotation` — immutable models, events, states
- `local_auth` — биометрия
- `flutter_localizations` + `intl` — локализация (EN + RU)
- `scroll_to_index` — авто-скролл аккордеона
- `build_runner` — кодогенерация

---

## Архитектура

### DI — GetIt + injectable
- Все зависимости регистрируются через GetIt с аннотациями `@injectable` / `@singleton` / `@lazySingleton`.
- Новые сервисы, репозитории, use cases, блоки — всегда регистрировать в GetIt, не создавать вручную.

### Репозитории — через абстракции
- Каждый репозиторий имеет **абстрактный класс** (интерфейс) в domain layer.
- Конкретная реализация — в data layer.
- Use cases и блоки зависят от абстракции, не от конкретного класса.
- Mock-данные — отдельная реализация (`MockGamesRepository implements GamesRepository`), а не внутри абстракции.

### Use cases — через абстракции
- Каждый use case имеет абстрактный интерфейс.
- Конкретная реализация зависит от абстракции репозитория.

### Кастомные exceptions
- Не использовать `throw Exception('...')` — создавать кастомные exception-классы.
- В блоках использовать `on ConcreteException catch (e)` вместо голого `catch (e)`.
- Маппить exception → пользовательское сообщение в блоке.

### Роутинг — auto_route
- `AppRouter` не должен знать о блоках напрямую.
- Навигационные гарды — через `AutoRouteGuard`.

---

## BLoC-паттерны

### Events и States — через `part`
- Events и states в отдельных файлах, подключённых через `part` к файлу блока.
- Генерируется один freezed файл на блок.

```dart
// auth_bloc.dart
part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';
```

### Scope блоков — по функциональности
- BlocProvider размещать на уровне фичи, а не в корне приложения.
- Глобальный scope — только для блоков, которые нужны везде (AuthBloc).

### Валидация — в блоке, не в UI
- Валидация полей выполняется в блоке.
- В UI использовать `InputDecoration.errorText`, передавая ошибку из state.
- Не использовать `Form` + `validator` — state-driven подход.

---

## UI-принципы

### Условные виджеты — через Builder, не тернарники
- Для сложных условных виджетов (loading/content) — выносить в отдельный Builder-виджет или метод, не использовать вложенные тернарные выражения.

### Стили — из темы, не хардкод
- Не хардкодить цвета (`Color(0xFF...)`) в виджетах — брать из `Theme.of(context)`.
- Дублирующиеся стили выносить в тему или в переменные.

### Авто-скролл
- Использовать `scroll_to_index` для автоматической прокрутки к раскрытому аккордеону.

### Локализация
- Все строки UI — в `.arb` файлах (EN + RU).
- Сервисы, принимающие текст для отображения пользователю (например `BiometricService.authenticate(title:)`), должны принимать его параметром для поддержки локализации.

---

## Прочее

### Одноразовые приватные методы
- Если приватный метод вызывается ровно один раз — инлайнить в место вызова.
