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
                  colors: [
                    colorScheme.primary,
                    colorScheme.tertiary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Icon(
                            Icons.widgets_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'TooltipCard',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.25),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'v2.5.0',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.smartphone_rounded,
                                          size: 12,
                                          color: Colors.greenAccent.shade100,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Touch Ready',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.greenAccent.shade100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TooltipCard.builder(
                          placementSide: TooltipCardPlacementSide.bottomEnd,
                          beakEnabled: true,
                          modalBarrierEnabled: true,
                          barrierBlur: 4,
                          flyoutBackgroundColor:
                              isDark ? colorScheme.surfaceContainerHigh : Colors.white,
                          beakColor:
                              isDark ? colorScheme.surfaceContainerHigh : Colors.white,
                          builder: (ctx, close) => TooltipCardContent(
                            icon: const Icon(Icons.auto_awesome_rounded),
                            iconColor: colorScheme.primary,
                            title: 'Fluent UI Inspired',
                            subtitle:
                                'Beautiful tooltips with smart positioning, 7 trigger modes, and smooth animations.',
                            primaryAction: FilledButton(
                              onPressed: close,
                              child: const Text('Got it'),
                            ),
                            onClose: close,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Explore real-world examples',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tap on any category to see interactive demos with various trigger modes',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.75),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Trigger Modes Showcase
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.touch_app_rounded,
                          color: colorScheme.tertiary,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Trigger Modes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '7 modes',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _TriggerDemo(
                          icon: Icons.touch_app_rounded,
                          label: 'Tap',
                          mode: WhenContentVisible.pressButton,
                          color: colorScheme.primary,
                        ),
                        _TriggerDemo(
                          icon: Icons.mouse_rounded,
                          label: 'Hover',
                          mode: WhenContentVisible.hoverButton,
                          color: colorScheme.primary,
                        ),
                        _TriggerDemo(
                          icon: Icons.ads_click_rounded,
                          label: 'Double',
                          mode: WhenContentVisible.doubleTapButton,
                          color: colorScheme.primary,
                        ),
                        _TriggerDemo(
                          icon: Icons.pan_tool_alt_rounded,
                          label: 'Long Press',
                          mode: WhenContentVisible.longPressButton,
                          color: colorScheme.tertiary,
                          isNew: true,
                        ),
                        _TriggerDemo(
                          icon: Icons.back_hand_rounded,
                          label: 'Long Up',
                          mode: WhenContentVisible.longPressUpButton,
                          color: colorScheme.tertiary,
                          isNew: true,
                        ),
                        _TriggerDemo(
                          icon: Icons.compress_rounded,
                          label: '3D Touch',
                          mode: WhenContentVisible.forcePressButton,
                          color: colorScheme.tertiary,
                          isNew: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Categories Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.category_rounded,
                      color: colorScheme.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Example Categories',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Categories Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.88,
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
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.secondary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.star_rounded,
                          color: colorScheme.secondary,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Key Features',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _FeatureChip(
                        label: '12 Placements',
                        icon: Icons.grid_view_rounded,
                      ),
                      _FeatureChip(
                        label: 'Smart Position',
                        icon: Icons.auto_fix_high_rounded,
                      ),
                      _FeatureChip(
                        label: 'Touch Friendly',
                        icon: Icons.smartphone_rounded,
                        isHighlight: true,
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
                      _FeatureChip(
                        label: 'Beak Arrow',
                        icon: Icons.arrow_drop_up_rounded,
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
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.outline.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flutter_dash,
                        size: 18,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Made with Flutter',
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
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

class _TriggerDemo extends StatelessWidget {
  const _TriggerDemo({
    required this.icon,
    required this.label,
    required this.mode,
    required this.color,
    this.isNew = false,
  });

  final IconData icon;
  final String label;
  final WhenContentVisible mode;
  final Color color;
  final bool isNew;

  String _getModeDescription() {
    switch (mode) {
      case WhenContentVisible.pressButton:
        return 'Single tap to show';
      case WhenContentVisible.hoverButton:
        return 'Mouse hover to show';
      case WhenContentVisible.doubleTapButton:
        return 'Double tap to show';
      case WhenContentVisible.secondaryTapButton:
        return 'Right-click to show';
      case WhenContentVisible.longPressButton:
        return 'Press and hold ~500ms';
      case WhenContentVisible.longPressUpButton:
        return 'Release after long press';
      case WhenContentVisible.forcePressButton:
        return '3D Touch / Haptic Touch';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TooltipCard.builder(
        whenContentVisible: mode,
        placementSide: TooltipCardPlacementSide.bottom,
        beakEnabled: true,
        modalBarrierEnabled: isNew,
        barrierBlur: isNew ? 3 : 0,
        hoverOpenDelay: const Duration(milliseconds: 200),
        builder: (ctx, close) => TooltipCardContent(
          icon: Icon(icon),
          iconColor: color,
          title: '$label Mode',
          subtitle: _getModeDescription(),
          primaryAction: FilledButton(
            onPressed: close,
            child: const Text('Got it'),
          ),
          onClose: close,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (isNew) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'NEW',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final _Category category;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TooltipCard.builder(
      placementSide: TooltipCardPlacementSide.top,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.longPressButton,
      modalBarrierEnabled: true,
      barrierBlur: 4,
      builder: (ctx, close) => TooltipCardContent(
        icon: Icon(category.icon),
        iconColor: category.color,
        title: category.title,
        subtitle: 'Tap to explore examples with different tooltip configurations and use cases.',
        primaryAction: FilledButton(
          onPressed: () {
            close();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => category.screen),
            );
          },
          child: const Text('Open'),
        ),
        secondaryAction: OutlinedButton(
          onPressed: close,
          child: const Text('Cancel'),
        ),
        onClose: close,
      ),
      child: Material(
        color: isDark
            ? colorScheme.surfaceContainerHighest
            : colorScheme.surfaceContainerLow,
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
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(category.icon, color: category.color, size: 26),
                ),
                const Spacer(),
                Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  category.subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: category.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Explore',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: category.color,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: category.color,
                          ),
                        ],
                      ),
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
  const _FeatureChip({
    required this.label,
    required this.icon,
    this.isHighlight = false,
  });

  final String label;
  final IconData icon;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final chipColor = isHighlight ? colorScheme.tertiary : colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: isHighlight
            ? Border.all(color: chipColor.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: chipColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: chipColor,
            ),
          ),
          if (isHighlight) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: chipColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'NEW',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: chipColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
