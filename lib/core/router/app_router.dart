import 'package:booking_reserv/features/auth/presentation/auth_screen.dart';
import 'package:booking_reserv/features/book/presentation/book_screen.dart';
import 'package:booking_reserv/features/favorites/presentation/favorites_screen.dart';
import 'package:booking_reserv/features/home/presentation/home_screen.dart';
import 'package:booking_reserv/features/navigation/presentation/navigation_screen.dart';
import 'package:booking_reserv/features/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter createRouter(bool hasSeeonOnBoarding) {
    return GoRouter(
      initialLocation: AuthScreen.routeName,
      routes: [
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) =>
              NavigationScreen(child: child),
          routes: <RouteBase>[
            _route(
              HomeScreen.routeName,
              (BuildContext context, GoRouterState state) => HomeScreen(),
            ),
            _route(
              FavoritesScreen.routeName,
              (BuildContext context, GoRouterState state) => FavoritesScreen(),
            ),
            _route(
              BookScreen.routeName,
              (BuildContext context, GoRouterState state) => BookScreen(),
            ),
            _route(
              ProfileScreen.routeName,
              (BuildContext context, GoRouterState state) => ProfileScreen(),
            ),
          ],
        ),
        _route(
          AuthScreen.routeName,
          (BuildContext context, GoRouterState state) => AuthScreen(),
        ),
      ],
    );
  }

  static GoRoute _route(
    String path,
    Widget Function(BuildContext, GoRouterState) builder,
  ) {
    return GoRoute(
      path: path,
      name: path,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<dynamic>(
          key: state.pageKey,
          child: builder(context, state),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }
}
