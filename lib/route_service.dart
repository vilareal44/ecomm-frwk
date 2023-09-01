import 'dart:async';

import 'package:ecomm/app/bloc/app_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RouteService {
  late final List<RouteBase> _routes;

  late List<String> doesNotRequireAuthPaths;

  final String signinPath = '/sign-in';
  final String signupPath = '/sign-up';
  final String forgotPasswordPath = '/forgot-password';
  final String homePath = '/home';

  RouteService({required List<RouteBase> routes}) : _routes = routes {
    doesNotRequireAuthPaths = [
      signinPath,
      signupPath,
      forgotPasswordPath,
    ];
  }

  GoRouter getRouter(AppBloc appBloc) {
    return GoRouter(
      initialLocation: '/home',
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshStream(appBloc.stream),
      redirect: (context, state) => _topLevelRouteRedirect(
        context,
        state,
        appBloc,
      ),
      routes: _routes,
    );
  }

  Future<String?> _topLevelRouteRedirect(
    BuildContext context,
    GoRouterState state,
    AppBloc appBloc,
  ) async {
    const homePath = '/home';
    const signInPath = '/sign-in';
    const signUpPath = '/sign-up';
    const forgotPasswordPath = '/forgot-password';
    final doesNotRequireAuthPaths = [
      signInPath,
      signUpPath,
      forgotPasswordPath
    ];

    final loggedIn = appBloc.state.status == AppStatus.authenticated;
    final location = state.uri.toString();
    final isLoggingIn = location.startsWith(signInPath);
    final isSigningUp = location.startsWith(signUpPath);

    final isAuthNotRequired =
        doesNotRequireAuthPaths.any((e) => location.startsWith(e));
    final isAuthRequired = !isAuthNotRequired;

    if (!loggedIn) {
      if (isAuthRequired) {
        final fromp = '?from=$location';
        return '$signInPath$fromp';
      }
    } else {
      if (isLoggingIn || isSigningUp) {
        return state.uri.queryParameters['from'] ?? homePath;
      }
    }

    return null;
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
