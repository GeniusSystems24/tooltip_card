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

          // Live Data Update Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 12),
              child: _SectionHeader(
                icon: Icons.sync_rounded,
                title: 'Live Data Updates',
                subtitle: 'Update content while tooltip stays open',
                color: Colors.orange,
                badge: 'NEW',
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _LiveUpdateDemo(),
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

/// Demo for live data updates while tooltip stays open
class _LiveUpdateDemo extends StatefulWidget {
  const _LiveUpdateDemo();

  @override
  State<_LiveUpdateDemo> createState() => _LiveUpdateDemoState();
}

class _LiveUpdateDemoState extends State<_LiveUpdateDemo> {
  final _controller = TooltipCardController();

  final _products = [
    {
      'id': 1,
      'name': 'iPhone 15 Pro',
      'price': 999,
      'stock': 25,
      'color': Colors.blue,
      'icon': Icons.phone_iphone_rounded,
    },
    {
      'id': 2,
      'name': 'MacBook Air M3',
      'price': 1299,
      'stock': 12,
      'color': Colors.grey,
      'icon': Icons.laptop_mac_rounded,
    },
    {
      'id': 3,
      'name': 'AirPods Pro',
      'price': 249,
      'stock': 50,
      'color': Colors.white,
      'icon': Icons.headphones_rounded,
    },
    {
      'id': 4,
      'name': 'iPad Pro',
      'price': 799,
      'stock': 8,
      'color': Colors.blueGrey,
      'icon': Icons.tablet_mac_rounded,
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 18,
                color: Colors.orange,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Open the tooltip, then click other products to update content without closing',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Product tooltip anchor
          Center(
            child: TooltipCard.builder(
              controller: _controller,
              placementSide: TooltipCardPlacementSide.top,
              beakEnabled: true,
              animation: TooltipCardAnimation.fadeScale,
              modalBarrierEnabled: false, // Allow clicking outside
              builder: (ctx, close) {
                final data = _controller.dataAs<Map<String, dynamic>>();
                if (data == null) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Select a product'),
                  );
                }
                return Container(
                  width: 280,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: (data['color'] as Color).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              data['icon'] as IconData,
                              color: data['color'] == Colors.white
                                  ? Colors.grey
                                  : data['color'] as Color,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['name'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${data['price']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: close,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: (data['stock'] as int) > 20
                              ? Colors.green.withValues(alpha: 0.1)
                              : (data['stock'] as int) > 10
                                  ? Colors.orange.withValues(alpha: 0.1)
                                  : Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_rounded,
                              size: 16,
                              color: (data['stock'] as int) > 20
                                  ? Colors.green
                                  : (data['stock'] as int) > 10
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${data['stock']} in stock',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: (data['stock'] as int) > 20
                                    ? Colors.green
                                    : (data['stock'] as int) > 10
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
                          label: const Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.touch_app_rounded,
                      color: colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Product Info Tooltip',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Product buttons grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.5,
            ),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // If tooltip is open, update data. Otherwise, open it.
                    if (_controller.isOpen) {
                      _controller.updateData(product);
                    } else {
                      _controller.open(data: product);
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          product['icon'] as IconData,
                          size: 20,
                          color: product['color'] == Colors.white
                              ? Colors.grey
                              : product['color'] as Color,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            product['name'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Code example
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.08),
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
                    color: Colors.orange.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '// Update data while tooltip is open\n'
                  'if (controller.isOpen) {\n'
                  '  controller.updateData(newProduct);\n'
                  '} else {\n'
                  '  controller.open(data: newProduct);\n'
                  '}\n\n'
                  '// Or simply use open() - it updates if already open\n'
                  'controller.open(data: newProduct);',
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
