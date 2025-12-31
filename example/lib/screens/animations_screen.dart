import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

/// Screen showcasing all 9 animation types and controller data feature
class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({super.key});

  @override
  State<AnimationsScreen> createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> {
  final _controller = TooltipCardController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    colorScheme.primary.withValues(alpha: 0.15),
                    colorScheme.secondary.withValues(alpha: 0.08),
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
                            color: colorScheme.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.animation_rounded,
                            color: colorScheme.primary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Animations & Data',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '9 animation types + controller data',
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

          // Animation Types Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: _SectionHeader(
                icon: Icons.movie_filter_rounded,
                title: 'Animation Types',
                subtitle: 'Tap each card to see the animation',
                color: colorScheme.primary,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildListDelegate([
                _AnimationCard(
                  animation: TooltipCardAnimation.fade,
                  icon: Icons.opacity_rounded,
                  title: 'Fade',
                  description: 'Simple opacity',
                  color: Colors.blue,
                ),
                _AnimationCard(
                  animation: TooltipCardAnimation.scale,
                  icon: Icons.zoom_in_rounded,
                  title: 'Scale',
                  description: 'Size transition',
                  color: Colors.purple,
                ),
                _AnimationCard(
                  animation: TooltipCardAnimation.fadeScale,
                  icon: Icons.filter_center_focus_rounded,
                  title: 'Fade + Scale',
                  description: 'Default combo',
                  color: Colors.indigo,
                  isDefault: true,
                ),
                _AnimationCard(
                  animation: TooltipCardAnimation.slideIn,
                  icon: Icons.swipe_rounded,
                  title: 'Slide In',
                  description: 'Direction-aware',
                  color: Colors.teal,
                ),
                _AnimationCard(
                  animation: TooltipCardAnimation.slideFade,
                  icon: Icons.slideshow_rounded,
                  title: 'Slide + Fade',
                  description: 'Smooth entrance',
                  color: Colors.cyan,
                ),
                _AnimationCard(
                  animation: TooltipCardAnimation.bounce,
                  icon: Icons.sports_basketball_rounded,
                  title: 'Bounce',
                  description: 'Playful effect',
                  color: Colors.orange,
                ),
                _AnimationCard(
                  animation: TooltipCardAnimation.elastic,
                  icon: Icons.waves_rounded,
                  title: 'Elastic',
                  description: 'Spring effect',
                  color: Colors.pink,
                ),
                _AnimationCard(
                  animation: TooltipCardAnimation.zoom,
                  icon: Icons.zoom_out_map_rounded,
                  title: 'Zoom',
                  description: 'With overshoot',
                  color: Colors.green,
                ),
                _AnimationCard(
                  animation: TooltipCardAnimation.none,
                  icon: Icons.flash_on_rounded,
                  title: 'None',
                  description: 'Instant',
                  color: Colors.grey,
                ),
              ]),
            ),
          ),

          // Controller Data Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 12),
              child: _SectionHeader(
                icon: Icons.data_object_rounded,
                title: 'Controller Data',
                subtitle: 'Pass data when opening programmatically',
                color: colorScheme.tertiary,
                badge: 'NEW',
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _ControllerDataDemo(controller: _controller),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
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

class _AnimationCard extends StatelessWidget {
  const _AnimationCard({
    required this.animation,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.isDefault = false,
  });

  final TooltipCardAnimation animation;
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TooltipCard.builder(
      animation: animation,
      placementSide: TooltipCardPlacementSide.top,
      beakEnabled: true,
      builder: (ctx, close) => TooltipCardContent(
        icon: Icon(icon),
        iconColor: color,
        title: '$title Animation',
        subtitle: 'Using TooltipCardAnimation.${animation.name}',
        primaryAction: FilledButton(
          onPressed: close,
          child: const Text('Nice!'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (isDefault) ...[
                  const SizedBox(width: 6),
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
                      'DEFAULT',
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
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControllerDataDemo extends StatelessWidget {
  const _ControllerDataDemo({required this.controller});

  final TooltipCardController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final users = [
      {'id': 1, 'name': 'John Doe', 'role': 'Admin', 'color': Colors.blue},
      {'id': 2, 'name': 'Jane Smith', 'role': 'Editor', 'color': Colors.purple},
      {'id': 3, 'name': 'Bob Wilson', 'role': 'Viewer', 'color': Colors.teal},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.surfaceContainerHigh
            : colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Click a user to see dynamic content',
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 16),
          TooltipCard.builder(
            controller: controller,
            placementSide: TooltipCardPlacementSide.top,
            beakEnabled: true,
            animation: TooltipCardAnimation.elastic,
            modalBarrierEnabled: true,
            barrierBlur: 4,
            builder: (ctx, close) {
              final data = controller.dataAs<Map<String, dynamic>>();
              if (data == null) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No data'),
                );
              }
              return TooltipCardContent(
                icon: const Icon(Icons.person_rounded),
                iconColor: data['color'] as Color,
                title: data['name'] as String,
                subtitle: 'Role: ${data['role']}\nID: ${data['id']}',
                primaryAction: FilledButton(
                  onPressed: close,
                  child: const Text('View Profile'),
                ),
                secondaryAction: OutlinedButton(
                  onPressed: close,
                  child: const Text('Close'),
                ),
                onClose: close,
              );
            },
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: users.map((user) {
                return InkWell(
                  onTap: () => controller.open(data: user),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: (user['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (user['color'] as Color).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: user['color'] as Color,
                          child: Text(
                            (user['name'] as String).substring(0, 1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              user['role'] as String,
                              style: TextStyle(
                                fontSize: 11,
                                color: colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Code Example',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '// Open with data\n'
                  'controller.open(data: {\'id\': 1, \'name\': \'John\'});\n\n'
                  '// Access in builder\n'
                  'final data = controller.dataAs<Map>();',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
