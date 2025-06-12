import 'package:booking_reserv/features/auth/presentation/auth_screen.dart';
import 'package:booking_reserv/features/book/presentation/book_screen.dart';
import 'package:booking_reserv/features/favorites/presentation/favorites_screen.dart';
import 'package:booking_reserv/features/home/presentation/home_screen.dart';
import 'package:booking_reserv/features/navigation/presentation/navigation_screen.dart';
import 'package:booking_reserv/features/profile/presentation/profile_screen.dart';
import 'package:booking_reserv/features/registration/presentation/registration_screen.dart';
import 'package:booking_reserv/features/book/presentation/booking_details_screen.dart'; // Добавляем импорт
import 'package:booking_reserv/features/reservation/presentation/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter createRouter(bool hasSeenOnBoarding) {
    return GoRouter(
      initialLocation: LoginScreen.routeName,
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
            _route(
              BookingDetailsScreen.routeName,
              (BuildContext context, GoRouterState state) =>
                  BookingDetailsScreen(
                booking: state.extra as Booking, // Получаем Booking из extra
              ),
            ),
          ],
        ),
        _route(
          LoginScreen.routeName,
          (BuildContext context, GoRouterState state) => LoginScreen(),
        ),
        _route(
          RegistrationScreen.routeName,
          (BuildContext context, GoRouterState state) => RegistrationScreen(),
        ),
        _route(
          ReservationScreen.routeName,
          (BuildContext context, GoRouterState state) => ReservationScreen(),
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
