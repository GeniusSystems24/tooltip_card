import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';
import 'business_examples_screen.dart';
import 'social_examples_screen.dart';
import 'ecommerce_examples_screen.dart';
import 'dashboard_examples_screen.dart';
import 'forms_examples_screen.dart';

/// Home screen with navigation to different example categories
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = [
      _Category(
        title: 'Business & Enterprise',
        subtitle: 'Data grids, invoices, employee management',
        icon: Icons.business_center_rounded,
        color: Colors.blue,
        screen: const BusinessExamplesScreen(),
      ),
      _Category(
        title: 'Social & Communication',
        subtitle: 'Chat, profiles, notifications, teams',
        icon: Icons.forum_rounded,
        color: Colors.purple,
        screen: const SocialExamplesScreen(),
      ),
      _Category(
        title: 'E-Commerce',
        subtitle: 'Products, cart, orders, payments',
        icon: Icons.shopping_bag_rounded,
        color: Colors.orange,
        screen: const EcommerceExamplesScreen(),
      ),
      _Category(
        title: 'Dashboard & Analytics',
        subtitle: 'Charts, KPIs, reports, metrics',
        icon: Icons.analytics_rounded,
        color: Colors.teal,
        screen: const DashboardExamplesScreen(),
      ),
      _Category(
        title: 'Forms & Validation',
        subtitle: 'Input help, validation, wizards',
        icon: Icons.assignment_rounded,
        color: Colors.pink,
        screen: const FormsExamplesScreen(),
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorScheme.primary, colorScheme.tertiary],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.widgets_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'TooltipCard',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'v2.4.2',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TooltipCard.builder(
                          placementSide: TooltipCardPlacementSide.bottomEnd,
                          beakEnabled: true,
                          flyoutBackgroundColor: Colors.white,
                          beakColor: Colors.white,
                          builder: (ctx, close) => Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fluent UI Inspired',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Beautiful tooltips with smart\npositioning and animations',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Explore real-world examples',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap on any category to see interactive demos',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Categories Grid
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index < categories.length) {
                  return _CategoryCard(category: categories[index]);
                }
                return null;
              }, childCount: categories.length),
            ),
          ),

          // Features Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Key Features',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FeatureChip(
                        label: '12 Placements',
                        icon: Icons.grid_view_rounded,
                      ),
                      _FeatureChip(
                        label: 'Smart Positioning',
                        icon: Icons.auto_fix_high_rounded,
                      ),
                      _FeatureChip(
                        label: 'Modal Barrier',
                        icon: Icons.blur_on_rounded,
                      ),
                      _FeatureChip(
                        label: 'RTL Support',
                        icon: Icons.format_textdirection_r_to_l_rounded,
                      ),
                      _FeatureChip(
                        label: 'Accessibility',
                        icon: Icons.accessibility_new_rounded,
                      ),
                      _FeatureChip(
                        label: 'Material 3',
                        icon: Icons.palette_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Footer
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: colorScheme.outline.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Made with Flutter',
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Category {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget screen;

  _Category({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.screen,
  });
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final _Category category;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      placementSide: TooltipCardPlacementSide.top,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.hoverButton,
      hoverOpenDelay: const Duration(milliseconds: 500),
      builder: (ctx, close) => Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Tap to explore ${category.title.toLowerCase()} examples',
          style: const TextStyle(fontSize: 13),
        ),
      ),
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => category.screen),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(category.icon, color: category.color, size: 28),
                ),
                const Spacer(),
                Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  category.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: category.color,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: category.color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
