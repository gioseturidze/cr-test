import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../core/di/injection.dart';
import '../../../core/router/app_router.dart';
import '../../../data/models/odds/odds_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../screens/login/bloc/auth_bloc.dart';
import 'bloc/betting_bloc.dart';
import 'widgets/game_tile.dart';

@RoutePage()
class BettingScreen extends StatelessWidget {
  const BettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BettingBloc>()..add(const BettingEvent.loadGames()),
      child: const _BettingView(),
    );
  }
}

class _BettingView extends StatefulWidget {
  const _BettingView();

  @override
  State<_BettingView> createState() => _BettingViewState();
}

class _BettingViewState extends State<_BettingView> {
  static const _expandAnimationDuration = Duration(milliseconds: 300);
  final AutoScrollController _scrollController = AutoScrollController();
  Map<String, OddsModel> _previousOdds = {};
  final Set<String> _unseenOddsUpdates = {};
  int? _pendingScrollIndex;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<BettingBloc>().add(const BettingEvent.loadGames());
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(const AuthEvent.logoutRequested());
              context.router.replaceAll([const LoginRoute()]);
            },
          ),
        ],
      ),
      body: BlocConsumer<BettingBloc, BettingState>(
        listener: (context, state) {
          if (state is BettingLoaded) {
            for (final gameId in state.liveOdds.keys) {
              final prev = _previousOdds[gameId];
              final curr = state.liveOdds[gameId];
              if (prev != null && curr != null && prev != curr) {
                if (!state.expandedGameIds.contains(gameId)) {
                  _unseenOddsUpdates.add(gameId);
                }
              }
              if (state.expandedGameIds.contains(gameId)) {
                _unseenOddsUpdates.remove(gameId);
              }
            }
            _previousOdds = state.liveOdds;
            if (_pendingScrollIndex != null) {
              final index = _pendingScrollIndex!;
              _pendingScrollIndex = null;
              Future.delayed(_expandAnimationDuration, () {
                if (mounted) {
                  _scrollController.scrollToIndex(
                    index,
                    preferPosition: AutoScrollPosition.begin,
                  );
                }
              });
            }
          }
        },
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<BettingBloc>()
                        .add(const BettingEvent.loadGames()),
                    child: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            ),
            loaded: (games, liveOdds, expandedGameIds) {
              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.viewPaddingOf(context).bottom + 16,
                  top: 8,
                ),
                itemCount: games.length,
                itemBuilder: (context, index) {
                  final game = games[index];
                  final currentOdds = liveOdds[game.id] ?? game.odds;
                  final prevOdds = _previousOdds[game.id];

                  return AutoScrollTag(
                    key: ValueKey(game.id),
                    controller: _scrollController,
                    index: index,
                    child: GameTile(
                      game: game,
                      liveOdds: currentOdds,
                      previousOdds: prevOdds,
                      isExpanded: expandedGameIds.contains(game.id),
                      hasUnseenUpdate: _unseenOddsUpdates.contains(game.id),
                      onToggle: () {
                        if (!expandedGameIds.contains(game.id)) {
                          _pendingScrollIndex = index;
                        }
                        context
                            .read<BettingBloc>()
                            .add(BettingEvent.toggleGameExpanded(game.id));
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
