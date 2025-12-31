import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/router.dart';

/// Main application shell with navigation
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWide = MediaQuery.sizeOf(context).width >= 800;
    final currentPath = GoRouterState.of(context).uri.path;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            _NavigationRail(currentPath: currentPath),
            Expanded(child: widget.child),
          ],
        ),
      );
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _BottomNavBar(currentPath: currentPath),
    );
  }
}

class _NavigationRail extends StatelessWidget {
  const _NavigationRail({required this.currentPath});

  final String currentPath;

  int _getSelectedIndex() {
    switch (currentPath) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.triggers:
        return 1;
      case AppRoutes.animations:
        return 2;
      case AppRoutes.business:
        return 3;
      case AppRoutes.social:
        return 4;
      case AppRoutes.ecommerce:
        return 5;
      case AppRoutes.dashboard:
        return 6;
      case AppRoutes.forms:
        return 7;
      default:
        return 0;
    }
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final routes = [
      AppRoutes.home,
      AppRoutes.triggers,
      AppRoutes.animations,
      AppRoutes.business,
      AppRoutes.social,
      AppRoutes.ecommerce,
      AppRoutes.dashboard,
      AppRoutes.forms,
    ];
    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : colorScheme.surfaceContainerLow,
        border: Border(
          right: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: NavigationRail(
        extended: MediaQuery.sizeOf(context).width >= 1100,
        minExtendedWidth: 200,
        backgroundColor: Colors.transparent,
        selectedIndex: _getSelectedIndex(),
        onDestinationSelected: (index) => _onDestinationSelected(context, index),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary, colorScheme.tertiary],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.widgets_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'v2.6.0',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.touch_app_outlined),
            selectedIcon: Icon(Icons.touch_app_rounded),
            label: Text('Triggers'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.animation_outlined),
            selectedIcon: Icon(Icons.animation_rounded),
            label: Text('Animations'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.business_center_outlined),
            selectedIcon: Icon(Icons.business_center_rounded),
            label: Text('Business'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.forum_outlined),
            selectedIcon: Icon(Icons.forum_rounded),
            label: Text('Social'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag_rounded),
            label: Text('E-Commerce'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics_rounded),
            label: Text('Dashboard'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment_rounded),
            label: Text('Forms'),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentPath});

  final String currentPath;

  int _getSelectedIndex() {
    switch (currentPath) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.triggers:
      case AppRoutes.animations:
        return 1;
      case AppRoutes.business:
      case AppRoutes.social:
      case AppRoutes.ecommerce:
      case AppRoutes.dashboard:
      case AppRoutes.forms:
        return 2;
      default:
        return 0;
    }
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final routes = [AppRoutes.home, AppRoutes.triggers, AppRoutes.business];
    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _getSelectedIndex(),
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.auto_awesome_outlined),
          selectedIcon: Icon(Icons.auto_awesome_rounded),
          label: 'Features',
        ),
        NavigationDestination(
          icon: Icon(Icons.apps_rounded),
          selectedIcon: Icon(Icons.apps_rounded),
          label: 'Examples',
        ),
      ],
    );
  }
}
