import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:my_money/core/routing/route_name.dart';
import 'package:my_money/presentation/features/auth/service/auth_service.dart';
import 'package:my_money/presentation/features/auth/view/login_screen.dart';
import 'package:my_money/presentation/features/home/view/home_screen.dart';
import 'package:my_money/presentation/features/main/view/main_screen.dart';
import 'package:my_money/presentation/features/profile/view/profile_screen.dart';
import 'package:my_money/presentation/features/splash/view/splash_screen.dart';
import 'package:my_money/presentation/features/statistic/view/statistic_screen.dart';
import 'package:my_money/presentation/features/transaction/view/add_expense_screen.dart';
import 'package:my_money/presentation/features/transaction/view/transaction_screen.dart';
import 'package:my_money/service_locator.dart';

class AppRouter {
  final AuthService _authService = getIt.get<AuthService>();

  GoRouter appRouter() => GoRouter(
    initialLocation: RouteName.SPLASH_SCREEN,
    debugLogDiagnostics: true,
    refreshListenable: _authService,
    redirect: _appRedirect,
    routes: [
      GoRoute(
        path: RouteName.SPLASH_SCREEN,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.LOGIN_SCREEN,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteName.ADD_EXPENSE_SCREEN,
        builder: (context, state) => const AddExpenseScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(child: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.HOME_SCREEN,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.TRANSACTION_SCREEN,
                builder: (context, state) => const TransactionScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.STATISTIC_SCREEN,
                builder: (context, state) => const StatisticScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteName.PROFILE_SCREEN,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],               
      ),
    ],
  );

  Future<String?> _appRedirect(BuildContext context, GoRouterState state) async {
    final isLoggedIn = _authService.isLoggedIn;
    final isLoading = _authService.isLoading;
    final isLoginScreen = state.matchedLocation == RouteName.LOGIN_SCREEN;
    final isSplashScreen = state.matchedLocation == RouteName.SPLASH_SCREEN;

    if (isLoading) {
      return null;
    }


    if (isLoggedIn && isSplashScreen) {
      return RouteName.HOME_SCREEN;
    } else if (!isLoggedIn && isSplashScreen) {
      return RouteName.LOGIN_SCREEN;
    } else if (!isLoggedIn && !isLoginScreen) {
      return RouteName.LOGIN_SCREEN;
    }

    if (isLoggedIn && isLoginScreen) {
      return RouteName.HOME_SCREEN;
    }

    return null;
  }
}
