import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/animations_screen.dart';
import '../screens/business_examples_screen.dart';
import '../screens/social_examples_screen.dart';
import '../screens/ecommerce_examples_screen.dart';
import '../screens/dashboard_examples_screen.dart';
import '../screens/forms_examples_screen.dart';
import '../screens/triggers_screen.dart';
import '../widgets/app_shell.dart';

/// Application routes
class AppRoutes {
  static const String home = '/';
  static const String triggers = '/triggers';
  static const String animations = '/animations';
  static const String business = '/business';
  static const String social = '/social';
  static const String ecommerce = '/ecommerce';
  static const String dashboard = '/dashboard';
  static const String forms = '/forms';
}

/// Application router configuration
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          path: AppRoutes.triggers,
          name: 'triggers',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const TriggersScreen(),
            transitionsBuilder: _slideTransition,
          ),
        ),
        GoRoute(
          path: AppRoutes.animations,
          name: 'animations',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AnimationsScreen(),
            transitionsBuilder: _slideTransition,
          ),
        ),
        GoRoute(
          path: AppRoutes.business,
          name: 'business',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const BusinessExamplesScreen(),
            transitionsBuilder: _slideTransition,
          ),
        ),
        GoRoute(
          path: AppRoutes.social,
          name: 'social',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SocialExamplesScreen(),
            transitionsBuilder: _slideTransition,
          ),
        ),
        GoRoute(
          path: AppRoutes.ecommerce,
          name: 'ecommerce',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const EcommerceExamplesScreen(),
            transitionsBuilder: _slideTransition,
          ),
        ),
        GoRoute(
          path: AppRoutes.dashboard,
          name: 'dashboard',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const DashboardExamplesScreen(),
            transitionsBuilder: _slideTransition,
          ),
        ),
        GoRoute(
          path: AppRoutes.forms,
          name: 'forms',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const FormsExamplesScreen(),
            transitionsBuilder: _slideTransition,
          ),
        ),
      ],
    ),
  ],
);

Widget _fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(opacity: animation, child: child);
}

Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(0.02, 0.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end).chain(
    CurveTween(curve: Curves.easeOutCubic),
  );
  return SlideTransition(
    position: animation.drive(tween),
    child: FadeTransition(opacity: animation, child: child),
  );
}
