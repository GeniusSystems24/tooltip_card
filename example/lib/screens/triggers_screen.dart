import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

/// Screen showcasing all 7 trigger modes
class TriggersScreen extends StatelessWidget {
  const TriggersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.tertiary.withValues(alpha: 0.15),
                    colorScheme.primary.withValues(alpha: 0.08),
                  ],
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
                            color: colorScheme.tertiary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.touch_app_rounded,
                            color: colorScheme.tertiary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trigger Modes',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '7 ways to activate tooltips',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.onSurface.withValues(alpha: 0.6),
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
            ),
          ),

          // Desktop Triggers Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: _SectionHeader(
                icon: Icons.mouse_rounded,
                title: 'Desktop Triggers',
                subtitle: 'Optimized for mouse and keyboard',
                color: colorScheme.primary,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              delegate: SliverChildListDelegate([
                _TriggerCard(
                  mode: WhenContentVisible.pressButton,
                  icon: Icons.touch_app_rounded,
                  title: 'Press / Tap',
                  description: 'Single tap or click to show',
                  instruction: 'Tap this card',
                  color: colorScheme.primary,
                ),
                _TriggerCard(
                  mode: WhenContentVisible.hoverButton,
                  icon: Icons.mouse_rounded,
                  title: 'Hover',
                  description: 'Mouse hover to show',
                  instruction: 'Hover over this card',
                  color: colorScheme.primary,
                ),
                _TriggerCard(
                  mode: WhenContentVisible.doubleTapButton,
                  icon: Icons.ads_click_rounded,
                  title: 'Double Tap',
                  description: 'Double-click to show',
                  instruction: 'Double-tap this card',
                  color: colorScheme.primary,
                ),
                _TriggerCard(
                  mode: WhenContentVisible.secondaryTapButton,
                  icon: Icons.mouse_outlined,
                  title: 'Right Click',
                  description: 'Context menu trigger',
                  instruction: 'Right-click this card',
                  color: colorScheme.primary,
                ),
              ]),
            ),
          ),

          // Touch Triggers Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 12),
              child: _SectionHeader(
                icon: Icons.smartphone_rounded,
                title: 'Touch Triggers',
                subtitle: 'Designed for mobile devices',
                color: colorScheme.tertiary,
                badge: 'NEW',
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              delegate: SliverChildListDelegate([
                _TriggerCard(
                  mode: WhenContentVisible.longPressButton,
                  icon: Icons.pan_tool_alt_rounded,
                  title: 'Long Press',
                  description: 'Press and hold ~500ms',
                  instruction: 'Long press this card',
                  color: colorScheme.tertiary,
                  isNew: true,
                ),
                _TriggerCard(
                  mode: WhenContentVisible.longPressUpButton,
                  icon: Icons.back_hand_rounded,
                  title: 'Long Press Up',
                  description: 'Release after long press',
                  instruction: 'Long press then release',
                  color: colorScheme.tertiary,
                  isNew: true,
                ),
                _TriggerCard(
                  mode: WhenContentVisible.forcePressButton,
                  icon: Icons.compress_rounded,
                  title: 'Force Press',
                  description: '3D Touch / Haptic Touch',
                  instruction: 'Force press (iOS)',
                  color: colorScheme.tertiary,
                  isNew: true,
                ),
              ]),
            ),
          ),

          // Comparison Table
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _ComparisonTable(),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.badge,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (badge != null) ...[
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge!,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TriggerCard extends StatelessWidget {
  const _TriggerCard({
    required this.mode,
    required this.icon,
    required this.title,
    required this.description,
    required this.instruction,
    required this.color,
    this.isNew = false,
  });

  final WhenContentVisible mode;
  final IconData icon;
  final String title;
  final String description;
  final String instruction;
  final Color color;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TooltipCard.builder(
      whenContentVisible: mode,
      placementSide: TooltipCardPlacementSide.top,
      beakEnabled: true,
      modalBarrierEnabled: isNew,
      barrierBlur: isNew ? 4 : 0,
      hoverOpenDelay: const Duration(milliseconds: 300),
      builder: (ctx, close) => TooltipCardContent(
        icon: Icon(icon),
        iconColor: color,
        title: '$title Activated!',
        subtitle: description,
        primaryAction: FilledButton(
          onPressed: close,
          child: const Text('Got it'),
        ),
        onClose: close,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? colorScheme.surfaceContainerHigh
              : colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (isNew) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'NEW',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    instruction,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final triggers = [
      ('pressButton', 'Tap', 'All', 'Simple interactions'),
      ('hoverButton', 'Hover', 'Desktop/Web', 'Help icons, info tips'),
      ('doubleTapButton', 'Double Tap', 'All', 'Secondary actions'),
      ('secondaryTapButton', 'Right Click', 'Desktop', 'Context menus'),
      ('longPressButton', 'Long Press', 'Mobile', 'Touch-first design'),
      ('longPressUpButton', 'Long Press Up', 'Mobile', 'Preview on hold'),
      ('forcePressButton', 'Force Press', 'iOS', '3D Touch devices'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.surfaceContainerHigh
            : colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.table_chart_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Trigger Comparison',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: colorScheme.primary.withValues(alpha: 0.05),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Trigger',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Platform',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Best For',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...triggers.asMap().entries.map((entry) {
            final index = entry.key;
            final (_, name, platform, bestFor) = entry.value;
            final isLast = index == triggers.length - 1;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                        bottom: BorderSide(
                          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                        ),
                      ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        platform,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSecondaryContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Text(
                      bestFor,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
