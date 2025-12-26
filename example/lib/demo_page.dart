import 'package:flutter/material.dart';
import 'package:tooltip_card/tooltip_card.dart';

/// Modern TooltipCard Demo Page
/// A clean, elegant showcase of TooltipCard features
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildModernTheme(context),
      child: const Scaffold(body: _DemoContent()),
    );
  }

  ThemeData _buildModernTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF0B0E14) // Deep, rich dark background
          : const Color(0xFFF0F4F8), // Crisp, cool light background
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1), // Vibrant Indigo
        primary: const Color(0xFF6366F1),
        secondary: const Color(0xFFEC4899), // Pink splash for accents
        tertiary: const Color(0xFF8B5CF6), // Violet for variety
        brightness: brightness,
        surface: isDark ? const Color(0xFF151922) : Colors.white,
      ),
      fontFamily: 'Inter',
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? const Color(0xFF1A1F2C) : Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.03),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: const Color(0xFF6366F1).withValues(alpha: 0.4),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: Color(0xFF6366F1)),
        ),
      ),
    );
  }
}

class _DemoContent extends StatefulWidget {
  const _DemoContent();

  @override
  State<_DemoContent> createState() => _DemoContentState();
}

class _DemoContentState extends State<_DemoContent> {
  final TooltipCardPublicState _publicState = TooltipCardPublicState.global;
  final TooltipCardController _controller = TooltipCardController();
  bool _isControlledOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        // Modern App Bar
        SliverAppBar.large(
          floating: true,
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary, colorScheme.tertiary],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.widgets_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              const Text('TooltipCard'),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'v2.5.0',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),

        // Content
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Hero Section
              _buildHeroSection(colorScheme, isDark),
              const SizedBox(height: 32),

              // Quick Actions Grid
              _buildSectionHeader('Quick Start', Icons.bolt_rounded),
              const SizedBox(height: 16),
              _buildQuickActionsGrid(colorScheme),
              const SizedBox(height: 40),

              // Placement Section
              _buildSectionHeader('Placement Options', Icons.grid_view_rounded),
              const SizedBox(height: 16),
              _buildPlacementSection(colorScheme, isDark),
              const SizedBox(height: 40),

              // Trigger Modes Section
              _buildSectionHeader('Trigger Modes', Icons.touch_app_rounded),
              const SizedBox(height: 16),
              _buildTriggerModesSection(colorScheme),
              const SizedBox(height: 40),

              // Modal & Effects Section
              _buildSectionHeader('Modal & Effects', Icons.blur_on_rounded),
              const SizedBox(height: 16),
              _buildModalSection(colorScheme, isDark),
              const SizedBox(height: 40),

              // Programmatic Control Section
              _buildSectionHeader('Programmatic Control', Icons.code_rounded),
              const SizedBox(height: 16),
              _buildProgrammaticSection(colorScheme),
              const SizedBox(height: 40),

              // Style Variations Section
              _buildSectionHeader('Style Variations', Icons.palette_rounded),
              const SizedBox(height: 16),
              _buildStyleVariationsSection(colorScheme, isDark),
              const SizedBox(height: 40),

              // Real World Examples Section
              _buildSectionHeader('Real World Examples', Icons.cases_rounded),
              const SizedBox(height: 16),
              _RealWorldExamplesSection(publicState: _publicState),
              const SizedBox(height: 60),

              // Footer
              _buildFooter(colorScheme),
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(ColorScheme colorScheme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF4F46E5),
                  const Color(0xFF7C3AED),
                ] // Indigo to Violet
              : [
                  const Color(0xFFEEF2FF),
                  const Color(0xFFE0E7FF),
                ], // Soft indigo tint
          stops: const [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: isDark ? 0.4 : 0.15),
            blurRadius: 40,
            offset: const Offset(0, 20),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF4F46E5),
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fluent-Inspired Tooltips',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Premium Interaction Design',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Beautiful, customizable tooltip cards with smart positioning, 7 trigger modes (including touch-friendly), modal barriers, and smooth animations.',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface.withValues(alpha: 0.8),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          TooltipCard.builder(
            publicState: _publicState,
            placementSide: TooltipCardPlacementSide.bottom,
            beakEnabled: true,
            modalBarrierEnabled: true,
            barrierBlur: 4,
            builder: (ctx, close) => TooltipCardContent(
              icon: const Icon(Icons.celebration_rounded),
              iconColor: colorScheme.primary,
              title: 'Welcome!',
              subtitle:
                  'This is a TooltipCard in action. It supports rich content, actions, and beautiful animations.',
              primaryAction: FilledButton(
                onPressed: close,
                child: const Text('Got it!'),
              ),
              onClose: close,
            ),
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Try Live Demo'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary.withValues(alpha: 0.15),
                colorScheme.secondary.withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.15),
            ),
          ),
          child: Icon(icon, color: colorScheme.primary, size: 22),
        ),
        const SizedBox(width: 14),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsGrid(ColorScheme colorScheme) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _QuickActionCard(
          icon: Icons.arrow_upward_rounded,
          label: 'Top',
          publicState: _publicState,
          placementSide: TooltipCardPlacementSide.top,
        ),
        _QuickActionCard(
          icon: Icons.arrow_downward_rounded,
          label: 'Bottom',
          publicState: _publicState,
          placementSide: TooltipCardPlacementSide.bottom,
        ),
        _QuickActionCard(
          icon: Icons.arrow_back_rounded,
          label: 'Start',
          publicState: _publicState,
          placementSide: TooltipCardPlacementSide.start,
        ),
        _QuickActionCard(
          icon: Icons.arrow_forward_rounded,
          label: 'End',
          publicState: _publicState,
          placementSide: TooltipCardPlacementSide.end,
        ),
      ],
    );
  }

  Widget _buildPlacementSection(ColorScheme colorScheme, bool isDark) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Compound Placements',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fine-grained control over tooltip positioning',
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _PlacementChip(
                  label: 'Top Start',
                  placement: TooltipCardPlacementSide.topStart,
                  publicState: _publicState,
                ),
                _PlacementChip(
                  label: 'Top End',
                  placement: TooltipCardPlacementSide.topEnd,
                  publicState: _publicState,
                ),
                _PlacementChip(
                  label: 'Bottom Start',
                  placement: TooltipCardPlacementSide.bottomStart,
                  publicState: _publicState,
                ),
                _PlacementChip(
                  label: 'Bottom End',
                  placement: TooltipCardPlacementSide.bottomEnd,
                  publicState: _publicState,
                ),
                _PlacementChip(
                  label: 'Start Top',
                  placement: TooltipCardPlacementSide.startTop,
                  publicState: _publicState,
                ),
                _PlacementChip(
                  label: 'Start Bottom',
                  placement: TooltipCardPlacementSide.startBottom,
                  publicState: _publicState,
                ),
                _PlacementChip(
                  label: 'End Top',
                  placement: TooltipCardPlacementSide.endTop,
                  publicState: _publicState,
                ),
                _PlacementChip(
                  label: 'End Bottom',
                  placement: TooltipCardPlacementSide.endBottom,
                  publicState: _publicState,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTriggerModesSection(ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Desktop/Mouse Triggers
            Row(
              children: [
                Icon(Icons.mouse_rounded, color: colorScheme.primary, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Desktop Triggers',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Optimized for mouse and trackpad interactions',
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _TriggerModeCard(
                  icon: Icons.touch_app_rounded,
                  title: 'Press',
                  description: 'Single tap',
                  publicState: _publicState,
                  whenVisible: WhenContentVisible.pressButton,
                ),
                _TriggerModeCard(
                  icon: Icons.mouse_rounded,
                  title: 'Hover',
                  description: 'Mouse hover',
                  publicState: _publicState,
                  whenVisible: WhenContentVisible.hoverButton,
                ),
                _TriggerModeCard(
                  icon: Icons.ads_click_rounded,
                  title: 'Double Tap',
                  description: 'Double click',
                  publicState: _publicState,
                  whenVisible: WhenContentVisible.doubleTapButton,
                ),
                _TriggerModeCard(
                  icon: Icons.mouse_outlined,
                  title: 'Right Click',
                  description: 'Context menu',
                  publicState: _publicState,
                  whenVisible: WhenContentVisible.secondaryTapButton,
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Touch/Mobile Triggers
            Row(
              children: [
                Icon(
                  Icons.smartphone_rounded,
                  color: colorScheme.tertiary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Touch Triggers',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'NEW',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Designed for touchscreens and mobile devices',
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _TriggerModeCard(
                  icon: Icons.touch_app_rounded,
                  title: 'Long Press',
                  description: 'Hold ~500ms',
                  publicState: _publicState,
                  whenVisible: WhenContentVisible.longPressButton,
                  isTouch: true,
                ),
                _TriggerModeCard(
                  icon: Icons.pan_tool_alt_rounded,
                  title: 'Long Press Up',
                  description: 'Release after hold',
                  publicState: _publicState,
                  whenVisible: WhenContentVisible.longPressUpButton,
                  isTouch: true,
                ),
                _TriggerModeCard(
                  icon: Icons.compress_rounded,
                  title: 'Force Press',
                  description: '3D Touch / Haptic',
                  publicState: _publicState,
                  whenVisible: WhenContentVisible.forcePressButton,
                  isTouch: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalSection(ColorScheme colorScheme, bool isDark) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.blur_circular_rounded, color: colorScheme.primary),
                const SizedBox(width: 10),
                Text(
                  'Modal Barrier with Blur',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Focus attention with a beautiful backdrop blur effect',
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                TooltipCard.builder(
                  publicState: _publicState,
                  modalBarrierEnabled: true,
                  barrierBlur: 6,
                  barrierColor: Colors.black.withValues(alpha: 0.3),
                  placementSide: TooltipCardPlacementSide.bottom,
                  beakEnabled: true,
                  builder: (ctx, close) => _buildModalContent(
                    'Soft Blur',
                    'A subtle blur effect (6px)',
                    colorScheme,
                    close,
                  ),
                  child: _ModalButton(
                    label: 'Soft Blur',
                    icon: Icons.blur_on_rounded,
                    color: colorScheme.primary,
                  ),
                ),
                TooltipCard.builder(
                  publicState: _publicState,
                  modalBarrierEnabled: true,
                  barrierBlur: 16,
                  barrierColor: Colors.black.withValues(alpha: 0.5),
                  placementSide: TooltipCardPlacementSide.bottom,
                  beakEnabled: true,
                  builder: (ctx, close) => _buildModalContent(
                    'Heavy Blur',
                    'Maximum focus effect (16px)',
                    colorScheme,
                    close,
                  ),
                  child: _ModalButton(
                    label: 'Heavy Blur',
                    icon: Icons.blur_circular_rounded,
                    color: colorScheme.tertiary,
                  ),
                ),
                TooltipCard.builder(
                  publicState: _publicState,
                  modalBarrierEnabled: true,
                  barrierDismissible: false,
                  barrierBlur: 8,
                  placementSide: TooltipCardPlacementSide.bottom,
                  beakEnabled: true,
                  builder: (ctx, close) => _buildModalContent(
                    'Non-Dismissible',
                    'Must use the close button',
                    colorScheme,
                    close,
                  ),
                  child: _ModalButton(
                    label: 'Locked',
                    icon: Icons.lock_rounded,
                    color: colorScheme.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalContent(
    String title,
    String description,
    ColorScheme colorScheme,
    VoidCallback close,
  ) {
    return TooltipCardContent(
      icon: const Icon(Icons.layers_rounded),
      iconColor: colorScheme.primary,
      title: title,
      subtitle: description,
      primaryAction: FilledButton(onPressed: close, child: const Text('Close')),
      onClose: close,
    );
  }

  Widget _buildProgrammaticSection(ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TooltipCard.builder(
                  publicState: _publicState,
                  controller: _controller,
                  placementSide: TooltipCardPlacementSide.bottom,
                  beakEnabled: true,
                  onOpenChanged: (isOpen) =>
                      setState(() => _isControlledOpen = isOpen),
                  builder: (ctx, close) => TooltipCardContent(
                    icon: const Icon(Icons.smart_toy_rounded),
                    iconColor: colorScheme.primary,
                    title: 'Controlled Tooltip',
                    subtitle:
                        'This tooltip is controlled programmatically using TooltipCardController.',
                    primaryAction: FilledButton(
                      onPressed: close,
                      child: const Text('Dismiss'),
                    ),
                    onClose: close,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _isControlledOpen
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isControlledOpen
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                          color: _isControlledOpen
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isControlledOpen ? 'Visible' : 'Hidden',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _isControlledOpen
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                _ControlButton(
                  icon: Icons.play_arrow_rounded,
                  label: 'Open',
                  onPressed: () => _controller.open(),
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                _ControlButton(
                  icon: Icons.stop_rounded,
                  label: 'Close',
                  onPressed: () => _controller.close(),
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                _ControlButton(
                  icon: Icons.swap_horiz_rounded,
                  label: 'Toggle',
                  onPressed: () => _controller.toggle(),
                  color: colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyleVariationsSection(ColorScheme colorScheme, bool isDark) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        // Dark Theme Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: const Color(0xFF0F172A), // Deep Slate
          beakColor: const Color(0xFF0F172A),
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          elevation: 12,
          borderWidth: 1,
          borderColor: Colors.white.withValues(alpha: 0.1),
          builder: (ctx, close) => DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: TooltipCardContent(
              icon: const Icon(Icons.dark_mode_rounded),
              iconColor: const Color(0xFF818CF8), // Indigo 400
              title: 'Dark Theme',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              subtitle: 'Elegant dark appearance',
              subtitleStyle: TextStyle(color: Colors.grey.shade400),
              primaryAction: FilledButton(
                onPressed: close,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1), // Indigo 500
                  foregroundColor: Colors.white,
                ),
                child: const Text('Nice!'),
              ),
              onClose: close,
            ),
          ),
          child: const _StyleCard(
            icon: Icons.dark_mode_rounded,
            label: 'Dark',
            color: Color(0xFF0F172A),
            textColor: Colors.white,
          ),
        ),

        // Gradient Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: const Color(0xFF6366F1), // Indigo 500
          beakColor: const Color(0xFF6366F1),
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          elevation: 8,

          builder: (ctx, close) => DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: TooltipCardContent(
              icon: const Icon(Icons.auto_awesome_rounded),
              iconColor: Colors.white,
              title: 'Vibrant',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              subtitle: 'Rich gradient background',
              subtitleStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
              ),
              primaryAction: FilledButton(
                onPressed: close,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6366F1),
                ),
                child: const Text('Beautiful!'),
              ),
              onClose: close,
            ),
          ),
          child: const _StyleCard(
            icon: Icons.gradient_rounded,
            label: 'Gradient',
            color: Color(0xFF6366F1),
            textColor: Colors.white,
          ),
        ),

        // Warning Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: const Color(0xFFFFFBEB), // Amber 50
          beakColor: const Color(0xFFFFFBEB),
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          borderColor: const Color(0xFFFCD34D), // Amber 300
          borderWidth: 1,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.warning_amber_rounded),
            iconColor: const Color(0xFFD97706), // Amber 600
            title: 'Warning',
            subtitle: 'Attention-grabbing warning style',
            primaryAction: FilledButton(
              onPressed: close,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFD97706),
                foregroundColor: Colors.white,
              ),
              child: const Text('Understood'),
            ),
            onClose: close,
          ),
          child: const _StyleCard(
            icon: Icons.warning_amber_rounded,
            label: 'Warning',
            color: Color(0xFFFFFBEB),
            textColor: Color(0xFFD97706),
          ),
        ),

        // Success Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: const Color(0xFFECFDF5), // Emerald 50
          beakColor: const Color(0xFFECFDF5),
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          borderColor: const Color(0xFF6EE7B7), // Emerald 300
          borderWidth: 1,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.check_circle_outline_rounded),
            iconColor: const Color(0xFF059669), // Emerald 600
            title: 'Success',
            subtitle: 'Operation completed successfully',
            primaryAction: FilledButton(
              onPressed: close,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                foregroundColor: Colors.white,
              ),
              child: const Text('Great!'),
            ),
            onClose: close,
          ),
          child: const _StyleCard(
            icon: Icons.check_circle_outline_rounded,
            label: 'Success',
            color: Color(0xFFECFDF5),
            textColor: Color(0xFF059669),
          ),
        ),

        // Info Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: const Color(0xFFEFF6FF), // Blue 50
          beakColor: const Color(0xFFEFF6FF),
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          borderColor: const Color(0xFF93C5FD), // Blue 300
          borderWidth: 1,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.info_outline_rounded),
            iconColor: const Color(0xFF2563EB), // Blue 600
            title: 'Information',
            subtitle: 'Helpful information for users',
            primaryAction: FilledButton(
              onPressed: close,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
              ),
              child: const Text('Got it'),
            ),
            onClose: close,
          ),
          child: const _StyleCard(
            icon: Icons.info_outline_rounded,
            label: 'Info',
            color: Color(0xFFEFF6FF),
            textColor: Color(0xFF2563EB),
          ),
        ),

        // Rounded Style
        TooltipCard.builder(
          publicState: _publicState,
          borderRadius: BorderRadius.circular(28),
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          elevation: 12,

          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.circle_notifications_rounded),
            iconColor: const Color(0xFF8B5CF6), // Violet 500
            title: 'Extra Rounded',
            subtitle: 'Soft, friendly appearance',
            primaryAction: FilledButton(
              onPressed: close,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text('Love it!'),
            ),
            onClose: close,
          ),
          child: const _StyleCard(
            icon: Icons.circle_notifications_rounded,
            label: 'Rounded',
            color: Color(0xFFF5F3FF), // Violet 50
            textColor: Color(0xFF7C3AED), // Violet 600
          ),
        ),

        // Bordered Style
        TooltipCard.builder(
          publicState: _publicState,
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          elevation: 0,
          borderColor: const Color(0xFFE2E8F0), // Slate 200
          borderWidth: 1.5,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.border_style_rounded),
            iconColor: const Color(0xFF475569), // Slate 600
            title: 'Bordered',
            subtitle: 'Clean, unexpected border style',
            primaryAction: OutlinedButton(
              onPressed: close,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF475569),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              child: const Text('Nice'),
            ),
            onClose: close,
          ),
          child: const _StyleCard(
            icon: Icons.border_style_rounded,
            label: 'Bordered',
            color: Colors.white,
            textColor: Color(0xFF475569),
          ),
        ),

        // Error Style
        TooltipCard.builder(
          publicState: _publicState,
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          elevation: 4,
          flyoutBackgroundColor: const Color(0xFFFEF2F2), // Red 50
          beakColor: const Color(0xFFFEF2F2),
          borderColor: const Color(0xFFFECACA), // Red 200
          borderWidth: 1,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.report_gmailerrorred_rounded),
            iconColor: const Color(0xFFDC2626), // Red 600
            title: 'Error Alert',
            subtitle: 'Critical system notification',
            primaryAction: FilledButton(
              onPressed: close,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              child: const Text('Fix Issue'),
            ),
            onClose: close,
          ),
          child: const _StyleCard(
            icon: Icons.report_gmailerrorred_rounded,
            label: 'Error',
            color: Color(0xFFFEF2F2),
            textColor: Color(0xFFDC2626),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(ColorScheme colorScheme) {
    return Center(
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
            'Built with Flutter',
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widgets

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.publicState,
    required this.placementSide,
  });

  final IconData icon;
  final String label;
  final TooltipCardPublicState publicState;
  final TooltipCardPlacementSide placementSide;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: placementSide,
      beakEnabled: true,
      builder: (ctx, close) => TooltipCardContent(
        icon: Icon(icon),
        iconColor: colorScheme.primary,
        title: '$label Placement',
        subtitle: 'Tooltip appears on the $label side of the trigger element.',
        primaryAction: FilledButton(
          onPressed: close,
          child: const Text('Close'),
        ),
        onClose: close,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: colorScheme.primary),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlacementChip extends StatelessWidget {
  const _PlacementChip({
    required this.label,
    required this.placement,
    required this.publicState,
  });

  final String label;
  final TooltipCardPlacementSide placement;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: placement,
      beakEnabled: true,
      builder: (ctx, close) => TooltipCardContent(
        title: label,
        subtitle: 'This tooltip uses the $label placement option.',
        primaryAction: FilledButton(onPressed: close, child: const Text('OK')),
        onClose: close,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _TriggerModeCard extends StatelessWidget {
  const _TriggerModeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.publicState,
    required this.whenVisible,
    this.isTouch = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final TooltipCardPublicState publicState;
  final WhenContentVisible whenVisible;
  final bool isTouch;

  String _getTriggerExplanation() {
    switch (whenVisible) {
      case WhenContentVisible.pressButton:
        return 'A single tap/click opens the tooltip. Best for buttons and interactive elements.';
      case WhenContentVisible.hoverButton:
        return 'Hovering with mouse opens the tooltip. Ideal for desktop info icons and help text.';
      case WhenContentVisible.doubleTapButton:
        return 'Double-tap/double-click opens the tooltip. Good for secondary actions.';
      case WhenContentVisible.secondaryTapButton:
        return 'Right-click (or two-finger tap) opens the tooltip. Perfect for context menus.';
      case WhenContentVisible.longPressButton:
        return 'Press and hold for ~500ms to open. The most natural touch interaction.';
      case WhenContentVisible.longPressUpButton:
        return 'Opens when you release after a long press. Gives feedback before showing content.';
      case WhenContentVisible.forcePressButton:
        return '3D Touch / Haptic Touch on supported iOS devices. Falls back to long press.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = isTouch ? colorScheme.tertiary : colorScheme.primary;

    return TooltipCard.builder(
      publicState: publicState,
      whenContentVisible: whenVisible,
      hoverOpenDelay: const Duration(milliseconds: 100),
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      modalBarrierEnabled: isTouch,
      barrierBlur: isTouch ? 4 : 0,
      builder: (ctx, close) => TooltipCardContent(
        icon: Icon(icon),
        iconColor: accentColor,
        title: '$title Mode',
        subtitle: _getTriggerExplanation(),
        primaryAction: FilledButton(
          onPressed: close,
          child: const Text('Got it'),
        ),
        onClose: close,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? accentColor.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? accentColor.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: accentColor),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  description,
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
  }
}

class _ModalButton extends StatelessWidget {
  const _ModalButton({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StyleCard extends StatelessWidget {
  const _StyleCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withValues(alpha: 0.8), // Slightly darker/lighter
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Real World Examples Section
// ============================================================================

class _RealWorldExamplesSection extends StatelessWidget {
  const _RealWorldExamplesSection({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Data Grid Example
        _ExampleCard(
          title: 'Data Grid',
          subtitle: 'Employee management table with row actions',
          icon: Icons.table_chart_rounded,
          child: _DataGridExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 2. Invoice Example
        _ExampleCard(
          title: 'Invoice Details',
          subtitle: 'Interactive invoice with item breakdown',
          icon: Icons.receipt_long_rounded,
          child: _InvoiceExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 3. User Profile Cards
        _ExampleCard(
          title: 'User Profiles',
          subtitle: 'Team members with contact details',
          icon: Icons.people_rounded,
          child: _UserProfilesExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 4. Product Catalog
        _ExampleCard(
          title: 'Product Catalog',
          subtitle: 'E-commerce product cards with quick view',
          icon: Icons.shopping_bag_rounded,
          child: _ProductCatalogExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 5. Notifications & Status
        _ExampleCard(
          title: 'Notifications & Status',
          subtitle: 'System alerts and status indicators',
          icon: Icons.notifications_rounded,
          child: _NotificationsExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 6. Calendar/Schedule
        _ExampleCard(
          title: 'Calendar & Schedule',
          subtitle: 'Event tooltips with details and actions',
          icon: Icons.calendar_month_rounded,
          child: _CalendarExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 7. Analytics Dashboard
        _ExampleCard(
          title: 'Analytics Dashboard',
          subtitle: 'Interactive charts with data insights',
          icon: Icons.analytics_rounded,
          child: _AnalyticsExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 8. File Manager
        _ExampleCard(
          title: 'File Manager',
          subtitle: 'File previews and quick actions',
          icon: Icons.folder_rounded,
          child: _FileManagerExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 9. Kanban Board
        _ExampleCard(
          title: 'Kanban Board',
          subtitle: 'Task cards with details and assignees',
          icon: Icons.view_kanban_rounded,
          child: _KanbanExample(publicState: publicState),
        ),
        const SizedBox(height: 20),

        // 10. Chat & Messaging
        _ExampleCard(
          title: 'Chat & Messaging',
          subtitle: 'Message actions and reactions',
          icon: Icons.chat_rounded,
          child: _ChatExample(publicState: publicState),
        ),
      ],
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      color: colorScheme.surface, // Ensure surface color for card
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.surfaceContainerLowest.withValues(alpha: 0.5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: colorScheme.secondary, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 1. Data Grid Example
// ============================================================================

class _DataGridExample extends StatelessWidget {
  const _DataGridExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final employees = [
      _Employee(
        'Ahmed Hassan',
        'ahmed@company.com',
        'Engineering',
        'Senior Developer',
        85000,
        'Active',
        const Color(0xFF059669),
      ),
      _Employee(
        'Sara Ali',
        'sara@company.com',
        'Design',
        'UI/UX Lead',
        75000,
        'Active',
        const Color(0xFF059669),
      ),
      _Employee(
        'Mohamed Khaled',
        'mohamed@company.com',
        'Marketing',
        'Marketing Manager',
        70000,
        'On Leave',
        const Color(0xFFD97706),
      ),
      _Employee(
        'Fatima Omar',
        'fatima@company.com',
        'HR',
        'HR Specialist',
        55000,
        'Active',
        const Color(0xFF059669),
      ),
    ];

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Employee',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Department',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                  child: Text(
                    'Actions',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          // Rows
          ...employees.map(
            (emp) => _DataGridRow(employee: emp, publicState: publicState),
          ),
        ],
      ),
    );
  }
}

class _Employee {
  final String name;
  final String email;
  final String department;
  final String position;
  final double salary;
  final String status;
  final Color statusColor;

  _Employee(
    this.name,
    this.email,
    this.department,
    this.position,
    this.salary,
    this.status,
    this.statusColor,
  );
}

class _DataGridRow extends StatelessWidget {
  const _DataGridRow({required this.employee, required this.publicState});

  final _Employee employee;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          // Employee Name with Tooltip
          Expanded(
            flex: 2,
            child: TooltipCard.builder(
              publicState: publicState,
              placementSide: TooltipCardPlacementSide.bottomStart,
              beakEnabled: true,
              whenContentVisible: WhenContentVisible.hoverButton,
              hoverOpenDelay: const Duration(milliseconds: 300),
              builder: (ctx, close) =>
                  _EmployeeDetailsTooltip(employee: employee, onClose: close),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      employee.name[0],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    employee.name,
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              employee.department,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: employee.statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                employee.status,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: employee.statusColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Actions
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.top,
                  beakEnabled: true,
                  whenContentVisible: WhenContentVisible.pressButton,
                  modalBarrierEnabled: true,
                  barrierBlur: 2,
                  builder: (ctx, close) => _RowActionsMenu(onClose: close),
                  child: Icon(
                    Icons.more_vert_rounded,
                    size: 20,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
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

class _EmployeeDetailsTooltip extends StatelessWidget {
  const _EmployeeDetailsTooltip({
    required this.employee,
    required this.onClose,
  });

  final _Employee employee;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    employee.name[0],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        employee.position,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _DetailRow(
              icon: Icons.email_outlined,
              label: 'Email',
              value: employee.email,
            ),
            _DetailRow(
              icon: Icons.business_outlined,
              label: 'Department',
              value: employee.department,
            ),
            _DetailRow(
              icon: Icons.attach_money_rounded,
              label: 'Salary',
              value: '\$${employee.salary.toStringAsFixed(0)}/year',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onClose,
                    icon: const Icon(Icons.email_outlined, size: 16),
                    label: const Text('Email'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onClose,
                    icon: const Icon(Icons.person_outline, size: 16),
                    label: const Text('Profile'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowActionsMenu extends StatelessWidget {
  const _RowActionsMenu({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionMenuItem(
            icon: Icons.edit_outlined,
            label: 'Edit',
            onTap: onClose,
          ),
          _ActionMenuItem(
            icon: Icons.visibility_outlined,
            label: 'View Details',
            onTap: onClose,
          ),
          _ActionMenuItem(
            icon: Icons.email_outlined,
            label: 'Send Email',
            onTap: onClose,
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.2)),
          _ActionMenuItem(
            icon: Icons.delete_outline,
            label: 'Delete',
            onTap: onClose,
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class _ActionMenuItem extends StatelessWidget {
  const _ActionMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? const Color(0xFFDC2626) // Red 600
        : Theme.of(context).colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 13, color: color)),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 2. Invoice Example
// ============================================================================

class _InvoiceExample extends StatelessWidget {
  const _InvoiceExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final items = [
      _InvoiceItem(
        'Website Development',
        'Full-stack development with React & Node.js',
        3,
        1500,
        'Development',
      ),
      _InvoiceItem(
        'UI/UX Design',
        'Complete design system & prototypes',
        1,
        2500,
        'Design',
      ),
      _InvoiceItem(
        'Cloud Hosting',
        'AWS infrastructure setup & 1 year hosting',
        12,
        150,
        'Infrastructure',
      ),
      _InvoiceItem(
        'Maintenance',
        'Monthly maintenance & support',
        6,
        300,
        'Support',
      ),
    ];

    final subtotal = items.fold<double>(0, (sum, item) => sum + item.total);
    final tax = subtotal * 0.15;
    final total = subtotal + tax;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Invoice Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice #INV-2024-0042',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dec 24, 2024',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                TooltipCard.builder(
                  publicState: publicState,
                  placementSide: TooltipCardPlacementSide.bottomEnd,
                  beakEnabled: true,
                  modalBarrierEnabled: true,
                  barrierBlur: 4,
                  builder: (ctx, close) =>
                      _InvoiceStatusTooltip(onClose: close),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED), // Orange 50
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: Color(0xFF9A3412), // Orange 800
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Pending',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9A3412), // Orange 800
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Items
          ...items.map(
            (item) => _InvoiceItemRow(item: item, publicState: publicState),
          ),
          // Totals
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(11),
              ),
            ),
            child: Column(
              children: [
                _TotalRow(
                  label: 'Subtotal',
                  value: '\$${subtotal.toStringAsFixed(2)}',
                ),
                _TotalRow(
                  label: 'Tax (15%)',
                  value: '\$${tax.toStringAsFixed(2)}',
                ),
                const Divider(height: 16),
                _TotalRow(
                  label: 'Total',
                  value: '\$${total.toStringAsFixed(2)}',
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceItem {
  final String name;
  final String description;
  final int quantity;
  final double unitPrice;
  final String category;

  _InvoiceItem(
    this.name,
    this.description,
    this.quantity,
    this.unitPrice,
    this.category,
  );

  double get total => quantity * unitPrice;
}

class _InvoiceItemRow extends StatelessWidget {
  const _InvoiceItemRow({required this.item, required this.publicState});

  final _InvoiceItem item;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outline.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TooltipCard.builder(
              publicState: publicState,
              placementSide: TooltipCardPlacementSide.bottomStart,
              beakEnabled: true,
              whenContentVisible: WhenContentVisible.hoverButton,
              hoverOpenDelay: const Duration(milliseconds: 200),
              builder: (ctx, close) =>
                  _ItemDetailsTooltip(item: item, onClose: close),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    item.category,
                    style: TextStyle(
                      fontSize: 11,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${item.quantity}x',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              '\$${item.unitPrice.toStringAsFixed(0)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              '\$${item.total.toStringAsFixed(2)}',
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemDetailsTooltip extends StatelessWidget {
  const _ItemDetailsTooltip({required this.item, required this.onClose});

  final _InvoiceItem item;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 260,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.category,
                          style: TextStyle(
                            fontSize: 10,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              item.description,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MiniStat(label: 'Qty', value: '${item.quantity}'),
                  _MiniStat(
                    label: 'Unit',
                    value: '\$${item.unitPrice.toStringAsFixed(0)}',
                  ),
                  _MiniStat(
                    label: 'Total',
                    value: '\$${item.total.toStringAsFixed(0)}',
                    isPrimary: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.value,
    this.isPrimary = false,
  });

  final String label;
  final String value;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: isPrimary ? colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}

class _InvoiceStatusTooltip extends StatelessWidget {
  const _InvoiceStatusTooltip({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Invoice Status',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          const _StatusOption(
            icon: Icons.hourglass_empty,
            label: 'Pending',
            color: Colors.amber,
            isSelected: true,
          ),
          const _StatusOption(
            icon: Icons.check_circle_outline,
            label: 'Paid',
            color: Colors.green,
          ),
          const _StatusOption(
            icon: Icons.cancel_outlined,
            label: 'Cancelled',
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onClose,
              child: const Text('Update Status'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  const _StatusOption({
    required this.icon,
    required this.label,
    required this.color,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? color.withValues(alpha: 0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? color : Colors.transparent),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? color : null,
              fontWeight: isSelected ? FontWeight.w600 : null,
            ),
          ),
          const Spacer(),
          if (isSelected) Icon(Icons.check, size: 18, color: color),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: colorScheme.onSurface.withValues(alpha: isTotal ? 1 : 0.7),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 13,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? colorScheme.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. User Profiles Example
// ============================================================================

class _UserProfilesExample extends StatelessWidget {
  const _UserProfilesExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final users = [
      _User(
        'Nour Ibrahim',
        'CTO',
        'nour@startup.io',
        '+971 50 123 4567',
        'https://linkedin.com/in/nour',
        const Color(0xFF6366F1), // Indigo 500
      ),
      _User(
        'Layla Ahmed',
        'Product Manager',
        'layla@startup.io',
        '+971 50 234 5678',
        'https://linkedin.com/in/layla',
        const Color(0xFFEC4899), // Pink 500
      ),
      _User(
        'Youssef Mahmoud',
        'Lead Designer',
        'youssef@startup.io',
        '+971 50 345 6789',
        'https://linkedin.com/in/youssef',
        const Color(0xFF0F766E), // Teal 700
      ),
      _User(
        'Hana Kareem',
        'DevOps Engineer',
        'hana@startup.io',
        '+971 50 456 7890',
        'https://linkedin.com/in/hana',
        const Color(0xFF8B5CF6), // Violet 500
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: users
          .map((user) => _UserCard(user: user, publicState: publicState))
          .toList(),
    );
  }
}

class _User {
  final String name;
  final String role;
  final String email;
  final String phone;
  final String linkedin;
  final Color color;

  _User(
    this.name,
    this.role,
    this.email,
    this.phone,
    this.linkedin,
    this.color,
  );
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user, required this.publicState});

  final _User user;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.pressButton,
      modalBarrierEnabled: true,
      barrierBlur: 6,
      builder: (ctx, close) => _UserProfileTooltip(user: user, onClose: close),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: user.color.withValues(alpha: 0.2),
              child: Text(
                user.name[0],
                style: TextStyle(
                  color: user.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  user.role,
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
  }
}

class _UserProfileTooltip extends StatelessWidget {
  const _UserProfileTooltip({required this.user, required this.onClose});

  final _User user;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [user.color.withValues(alpha: 0.8), user.color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Text(
                    user.name[0],
                    style: TextStyle(
                      color: user.color,
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.role,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _ContactRow(icon: Icons.email_outlined, value: user.email),
                _ContactRow(icon: Icons.phone_outlined, value: user.phone),
                const _ContactRow(
                  icon: Icons.link_rounded,
                  value: 'LinkedIn Profile',
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onClose,
                        icon: const Icon(Icons.chat_bubble_outline, size: 16),
                        label: const Text('Message'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: onClose,
                        icon: const Icon(Icons.video_call_outlined, size: 16),
                        label: const Text('Call'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. Product Catalog Example
// ============================================================================

class _ProductCatalogExample extends StatelessWidget {
  const _ProductCatalogExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final products = [
      _Product(
        'MacBook Pro 16"',
        'Apple M3 Pro, 18GB RAM, 512GB SSD',
        2499,
        4.9,
        128,
        'Electronics',
        const Color(0xFF1E293B), // Slate 800
      ),
      _Product(
        'iPhone 15 Pro',
        '256GB, Natural Titanium',
        1199,
        4.8,
        256,
        'Electronics',
        const Color(0xFF2563EB), // Blue 600
      ),
      _Product(
        'AirPods Pro 2',
        'Active Noise Cancellation, USB-C',
        249,
        4.7,
        512,
        'Audio',
        const Color(0xFF0D9488), // Teal 600
      ),
      _Product(
        'Apple Watch Ultra 2',
        'GPS + Cellular, 49mm',
        799,
        4.9,
        89,
        'Wearables',
        const Color(0xFFEA580C), // Orange 600
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: products
          .map(
            (product) =>
                _ProductCard(product: product, publicState: publicState),
          )
          .toList(),
    );
  }
}

class _Product {
  final String name;
  final String description;
  final double price;
  final double rating;
  final int reviews;
  final String category;
  final Color color;

  _Product(
    this.name,
    this.description,
    this.price,
    this.rating,
    this.reviews,
    this.category,
    this.color,
  );
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.publicState});

  final _Product product;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.hoverButton,
      hoverOpenDelay: const Duration(milliseconds: 400),
      builder: (ctx, close) =>
          _ProductQuickView(product: product, onClose: close),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Placeholder
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: product.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.devices_rounded,
                  size: 40,
                  color: product.color,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: Colors.amber.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  '${product.rating}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' (${product.reviews})',
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '\$${product.price.toStringAsFixed(0)}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductQuickView extends StatelessWidget {
  const _ProductQuickView({required this.product, required this.onClose});

  final _Product product;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  product.color.withValues(alpha: 0.1),
                  product.color.withValues(alpha: 0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.devices_rounded,
                    size: 60,
                    color: product.color,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.category,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: Colors.amber.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rating}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' (${product.reviews} reviews)',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${product.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onClose,
                        icon: const Icon(
                          Icons.favorite_border_rounded,
                          size: 16,
                        ),
                        label: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: FilledButton.icon(
                        onPressed: onClose,
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 16,
                        ),
                        label: const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 5. Notifications Example
// ============================================================================

class _NotificationsExample extends StatelessWidget {
  const _NotificationsExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _NotificationBadge(
          icon: Icons.cloud_done_rounded,
          label: 'Synced',
          color: const Color(0xFF059669), // Emerald 600
          publicState: publicState,
          tooltipTitle: 'All Changes Synced',
          tooltipMessage:
              'Your data was last synced 2 minutes ago. All changes are saved to the cloud.',
        ),
        _NotificationBadge(
          icon: Icons.warning_rounded,
          label: '3 Warnings',
          color: const Color(0xFFD97706), // Amber 600
          publicState: publicState,
          tooltipTitle: 'System Warnings',
          tooltipMessage:
              'There are 3 warnings that need your attention. Click to view details.',
          hasAction: true,
        ),
        _NotificationBadge(
          icon: Icons.error_rounded,
          label: '1 Error',
          color: const Color(0xFFDC2626), // Red 600
          publicState: publicState,
          tooltipTitle: 'Critical Error',
          tooltipMessage:
              'Database connection failed. Please check your network settings.',
          hasAction: true,
        ),
        _NotificationBadge(
          icon: Icons.update_rounded,
          label: 'Update Available',
          color: const Color(0xFF2563EB), // Blue 600
          publicState: publicState,
          tooltipTitle: 'Version 2.5.0 Available',
          tooltipMessage:
              'A new version is available with performance improvements and bug fixes.',
          hasAction: true,
        ),
        _NotificationBadge(
          icon: Icons.security_rounded,
          label: 'Secured',
          color: const Color(0xFF0D9488), // Teal 600
          publicState: publicState,
          tooltipTitle: 'Connection Secure',
          tooltipMessage:
              'Your connection is encrypted with TLS 1.3. All data transfers are secure.',
        ),
      ],
    );
  }
}

class _NotificationBadge extends StatelessWidget {
  const _NotificationBadge({
    required this.icon,
    required this.label,
    required this.color,
    required this.publicState,
    required this.tooltipTitle,
    required this.tooltipMessage,
    this.hasAction = false,
  });

  final IconData icon;
  final String label;
  final Color color;
  final TooltipCardPublicState publicState;
  final String tooltipTitle;
  final String tooltipMessage;
  final bool hasAction;

  @override
  Widget build(BuildContext context) {
    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.hoverButton,
      hoverOpenDelay: const Duration(milliseconds: 200),
      flyoutBackgroundColor: color.withValues(alpha: 0.05),
      beakColor: color.withValues(alpha: 0.05),
      builder: (ctx, close) => _NotificationTooltip(
        title: tooltipTitle,
        message: tooltipMessage,
        color: color,
        hasAction: hasAction,
        onClose: close,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTooltip extends StatelessWidget {
  const _NotificationTooltip({
    required this.title,
    required this.message,
    required this.color,
    required this.hasAction,
    required this.onClose,
  });

  final String title;
  final String message;
  final Color color;
  final bool hasAction;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.notifications_active_rounded,
                    size: 18,
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w600, color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            if (hasAction) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onClose,
                  style: FilledButton.styleFrom(backgroundColor: color),
                  child: const Text('View Details'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 6. Calendar/Schedule Example
// ============================================================================

class _CalendarExample extends StatelessWidget {
  const _CalendarExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final events = [
      _CalendarEvent(
        'Team Standup',
        '9:00 AM - 9:30 AM',
        'Daily sync with the team',
        'Conference Room A',
        ['Ahmed', 'Sara', 'Mohamed'],
        const Color(0xFF2563EB), // Blue 600
      ),
      _CalendarEvent(
        'Design Review',
        '11:00 AM - 12:00 PM',
        'Review new dashboard designs',
        'Online - Zoom',
        ['Layla', 'Youssef'],
        const Color(0xFF8B5CF6), // Violet 500
      ),
      _CalendarEvent(
        'Client Meeting',
        '2:00 PM - 3:00 PM',
        'Quarterly review with Acme Corp',
        'Meeting Room 2',
        ['Nour', 'Ahmed'],
        const Color(0xFF059669), // Emerald 600
      ),
      _CalendarEvent(
        'Sprint Planning',
        '4:00 PM - 5:30 PM',
        'Plan tasks for next sprint',
        'Main Hall',
        ['All Team'],
        const Color(0xFFD97706), // Amber 600
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Calendar Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Today, December 25',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Text(
                  '4 events',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          // Events
          ...events.map(
            (event) =>
                _CalendarEventRow(event: event, publicState: publicState),
          ),
        ],
      ),
    );
  }
}

class _CalendarEvent {
  final String title;
  final String time;
  final String description;
  final String location;
  final List<String> attendees;
  final Color color;

  _CalendarEvent(
    this.title,
    this.time,
    this.description,
    this.location,
    this.attendees,
    this.color,
  );
}

class _CalendarEventRow extends StatelessWidget {
  const _CalendarEventRow({required this.event, required this.publicState});

  final _CalendarEvent event;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.end,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.pressButton,
      modalBarrierEnabled: true,
      barrierBlur: 4,
      builder: (ctx, close) =>
          _CalendarEventTooltip(event: event, onClose: close),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: event.color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    event.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ...event.attendees
                    .take(2)
                    .map(
                      (name) => Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: event.color.withValues(alpha: 0.2),
                          child: Text(
                            name[0],
                            style: TextStyle(
                              fontSize: 10,
                              color: event.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                if (event.attendees.length > 2)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      child: Text(
                        '+${event.attendees.length - 2}',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarEventTooltip extends StatelessWidget {
  const _CalendarEventTooltip({required this.event, required this.onClose});

  final _CalendarEvent event;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: event.color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: event.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.event_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        event.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(event.location, style: const TextStyle(fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.people_outline_rounded,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      event.attendees.join(', '),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onClose,
                        icon: const Icon(Icons.edit_outlined, size: 16),
                        label: const Text('Edit'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: onClose,
                        style: FilledButton.styleFrom(
                          backgroundColor: event.color,
                        ),
                        icon: const Icon(Icons.video_call_outlined, size: 16),
                        label: const Text('Join'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7. Analytics Dashboard Example
// ============================================================================

class _AnalyticsExample extends StatelessWidget {
  const _AnalyticsExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {

    final metrics = [
      _AnalyticsMetric(
        'Revenue',
        '\$124,500',
        '+12.5%',
        true,
        Icons.trending_up_rounded,
        const Color(0xFF059669), // Emerald 600
        [65, 72, 80, 75, 90, 95, 100],
      ),
      _AnalyticsMetric(
        'Users',
        '8,421',
        '+8.2%',
        true,
        Icons.people_rounded,
        const Color(0xFF2563EB), // Blue 600
        [40, 50, 55, 60, 58, 70, 75],
      ),
      _AnalyticsMetric(
        'Orders',
        '1,284',
        '-3.1%',
        false,
        Icons.shopping_cart_rounded,
        const Color(0xFFD97706), // Amber 600
        [80, 75, 70, 65, 68, 62, 60],
      ),
      _AnalyticsMetric(
        'Conversion',
        '3.2%',
        '+0.5%',
        true,
        Icons.auto_graph_rounded,
        const Color(0xFF8B5CF6), // Violet 500
        [25, 28, 30, 32, 31, 34, 38],
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: metrics
          .map(
            (metric) =>
                _AnalyticsCard(metric: metric, publicState: publicState),
          )
          .toList(),
    );
  }
}

class _AnalyticsMetric {
  final String name;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color color;
  final List<int> sparkline;

  _AnalyticsMetric(
    this.name,
    this.value,
    this.change,
    this.isPositive,
    this.icon,
    this.color,
    this.sparkline,
  );
}

class _AnalyticsCard extends StatelessWidget {
  const _AnalyticsCard({required this.metric, required this.publicState});

  final _AnalyticsMetric metric;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.hoverButton,
      hoverOpenDelay: const Duration(milliseconds: 300),
      borderColor: metric.color.withValues(alpha: 0.3),
      borderWidth: 1,
      builder: (ctx, close) =>
          _AnalyticsDetailTooltip(metric: metric, onClose: close),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(metric.icon, size: 20, color: metric.color),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: (metric.isPositive ? Colors.green : Colors.red)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    metric.change,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: metric.isPositive ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              metric.value,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 2),
            Text(
              metric.name,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 10),
            // Mini Sparkline
            SizedBox(
              height: 24,
              child: CustomPaint(
                size: const Size(double.infinity, 24),
                painter: _SparklinePainter(metric.sparkline, metric.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<int> data;
  final Color color;

  _SparklinePainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final maxVal = data.reduce((a, b) => a > b ? a : b).toDouble();
    final minVal = data.reduce((a, b) => a < b ? a : b).toDouble();
    final range = maxVal - minVal;

    final path = Path();
    for (int i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final y = size.height - ((data[i] - minVal) / range) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AnalyticsDetailTooltip extends StatelessWidget {
  const _AnalyticsDetailTooltip({required this.metric, required this.onClose});

  final _AnalyticsMetric metric;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: metric.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(metric.icon, color: metric.color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metric.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Last 7 days',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current',
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    Text(
                      metric.value,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: metric.color,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          metric.isPositive
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          size: 16,
                          color: metric.isPositive ? Colors.green : Colors.red,
                        ),
                        Text(
                          metric.change,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: metric.isPositive
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                size: const Size(double.infinity, 44),
                painter: _SparklinePainter(metric.sparkline, metric.color),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onClose,
                style: FilledButton.styleFrom(backgroundColor: metric.color),
                child: const Text('View Full Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 8. File Manager Example
// ============================================================================

class _FileManagerExample extends StatelessWidget {
  const _FileManagerExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final files = [
      _FileItem(
        'Project Proposal.pdf',
        'PDF Document',
        '2.4 MB',
        'Dec 20, 2024',
        Icons.picture_as_pdf_rounded,
        const Color(0xFFDC2626), // Red 600
      ),
      _FileItem(
        'Design Assets.zip',
        'Archive',
        '45.8 MB',
        'Dec 22, 2024',
        Icons.folder_zip_rounded,
        const Color(0xFFD97706), // Amber 600
      ),
      _FileItem(
        'Presentation.pptx',
        'PowerPoint',
        '8.2 MB',
        'Dec 23, 2024',
        Icons.slideshow_rounded,
        const Color(0xFFEA580C), // Orange 600
      ),
      _FileItem(
        'Budget 2025.xlsx',
        'Excel Spreadsheet',
        '1.1 MB',
        'Dec 24, 2024',
        Icons.table_chart_rounded,
        const Color(0xFF059669), // Emerald 600
      ),
      _FileItem(
        'Meeting Notes.docx',
        'Word Document',
        '524 KB',
        'Dec 25, 2024',
        Icons.description_rounded,
        const Color(0xFF2563EB), // Blue 600
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: files
          .map((file) => _FileCard(file: file, publicState: publicState))
          .toList(),
    );
  }
}

class _FileItem {
  final String name;
  final String type;
  final String size;
  final String modified;
  final IconData icon;
  final Color color;

  _FileItem(
    this.name,
    this.type,
    this.size,
    this.modified,
    this.icon,
    this.color,
  );
}

class _FileCard extends StatelessWidget {
  const _FileCard({required this.file, required this.publicState});

  final _FileItem file;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.secondaryTapButton,
      builder: (ctx, close) => _FileContextMenu(file: file, onClose: close),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: file.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(file.icon, size: 32, color: file.color),
            ),
            const SizedBox(height: 10),
            Text(
              file.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              file.size,
              style: TextStyle(
                fontSize: 10,
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FileContextMenu extends StatelessWidget {
  const _FileContextMenu({required this.file, required this.onClose});

  final _FileItem file;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(file.icon, size: 20, color: file.color),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        file.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${file.size} • ${file.modified}',
                        style: TextStyle(
                          fontSize: 10,
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.2)),
          _FileMenuItem(
            icon: Icons.open_in_new_rounded,
            label: 'Open',
            onTap: onClose,
          ),
          _FileMenuItem(
            icon: Icons.download_rounded,
            label: 'Download',
            onTap: onClose,
          ),
          _FileMenuItem(
            icon: Icons.share_rounded,
            label: 'Share',
            onTap: onClose,
          ),
          _FileMenuItem(
            icon: Icons.drive_file_rename_outline_rounded,
            label: 'Rename',
            onTap: onClose,
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.2)),
          _FileMenuItem(
            icon: Icons.delete_outline_rounded,
            label: 'Delete',
            onTap: onClose,
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class _FileMenuItem extends StatelessWidget {
  const _FileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? const Color(0xFFDC2626) // Red 600
        : Theme.of(context).colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 13, color: color)),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 9. Kanban Board Example
// ============================================================================

class _KanbanExample extends StatelessWidget {
  const _KanbanExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {

    final tasks = [
      _KanbanTask(
        'Implement auth flow',
        'High',
        const Color(0xFFDC2626), // Red 600
        'In Progress',
        'A',
        const Color(0xFF2563EB), // Blue 600
      ),
      _KanbanTask(
        'Design dashboard',
        'Medium',
        const Color(0xFFD97706), // Amber 600
        'Review',
        'L',
        const Color(0xFFEC4899), // Pink 500
      ),
      _KanbanTask(
        'Write API docs',
        'Low',
        const Color(0xFF059669), // Emerald 600
        'To Do',
        'M',
        const Color(0xFF0F766E), // Teal 700
      ),
      _KanbanTask(
        'Fix login bug',
        'High',
        const Color(0xFFDC2626), // Red 600
        'Done',
        'Y',
        const Color(0xFF8B5CF6), // Violet 500
      ),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: tasks
          .map((task) => _KanbanTaskCard(task: task, publicState: publicState))
          .toList(),
    );
  }
}

class _KanbanTask {
  final String title;
  final String priority;
  final Color priorityColor;
  final String status;
  final String assigneeInitial;
  final Color assigneeColor;

  _KanbanTask(
    this.title,
    this.priority,
    this.priorityColor,
    this.status,
    this.assigneeInitial,
    this.assigneeColor,
  );
}

class _KanbanTaskCard extends StatelessWidget {
  const _KanbanTaskCard({required this.task, required this.publicState});

  final _KanbanTask task;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      whenContentVisible: WhenContentVisible.pressButton,
      modalBarrierEnabled: true,
      barrierBlur: 3,
      builder: (ctx, close) => _KanbanTaskDetail(task: task, onClose: close),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
          border: Border(left: BorderSide(width: 3, color: task.priorityColor)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(task.status).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.status,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(task.status),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: task.assigneeColor.withValues(alpha: 0.2),
                  child: Text(
                    task.assigneeInitial,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: task.assigneeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.flag_rounded, size: 12, color: task.priorityColor),
                const SizedBox(width: 4),
                Text(
                  task.priority,
                  style: TextStyle(
                    fontSize: 10,
                    color: task.priorityColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'To Do':
        return Colors.grey;
      case 'In Progress':
        return const Color(0xFF2563EB); // Blue 600
      case 'Review':
        return const Color(0xFFD97706); // Amber 600
      case 'Done':
        return const Color(0xFF059669); // Emerald 600
      default:
        return Colors.grey;
    }
  }
}

class _KanbanTaskDetail extends StatelessWidget {
  const _KanbanTaskDetail({required this.task, required this.onClose});

  final _KanbanTask task;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: task.priorityColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.task_alt_rounded,
                    color: task.priorityColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _TaskDetailRow(
              label: 'Status',
              value: task.status,
              color: _getStatusColor(task.status),
            ),
            _TaskDetailRow(
              label: 'Priority',
              value: task.priority,
              color: task.priorityColor,
            ),
            _TaskDetailRow(
              label: 'Assignee',
              value: 'Team Member',
              color: task.assigneeColor,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onClose,
                    child: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: onClose,
                    child: const Text('Move'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'To Do':
        return Colors.grey;
      case 'In Progress':
        return const Color(0xFF2563EB); // Blue 600
      case 'Review':
        return const Color(0xFFD97706); // Amber 600
      case 'Done':
        return const Color(0xFF059669); // Emerald 600
      default:
        return Colors.grey;
    }
  }
}

class _TaskDetailRow extends StatelessWidget {
  const _TaskDetailRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 10. Chat & Messaging Example
// ============================================================================

class _ChatExample extends StatelessWidget {
  const _ChatExample({required this.publicState});

  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final messages = [
      _ChatMessage(
        'Hey team! The new feature is ready for testing.',
        'Ahmed',
        '10:30 AM',
        true,
      ),
      _ChatMessage(
        'Great work! I will start testing it now.',
        'Sara',
        '10:32 AM',
        false,
      ),
      _ChatMessage(
        'Let me know if you find any issues. I am available all day.',
        'Ahmed',
        '10:33 AM',
        true,
      ),
      _ChatMessage(
        'Found a small bug in the login flow. Creating a ticket now.',
        'Mohamed',
        '10:45 AM',
        false,
      ),
    ];

    return Column(
      children: messages
          .map(
            (msg) => _ChatMessageBubble(message: msg, publicState: publicState),
          )
          .toList(),
    );
  }
}

class _ChatMessage {
  final String text;
  final String sender;
  final String time;
  final bool isMe;

  _ChatMessage(this.text, this.sender, this.time, this.isMe);
}

class _ChatMessageBubble extends StatelessWidget {
  const _ChatMessageBubble({required this.message, required this.publicState});

  final _ChatMessage message;
  final TooltipCardPublicState publicState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: colorScheme.secondaryContainer,
              child: Text(
                message.sender[0],
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          TooltipCard.builder(
            publicState: publicState,
            placementSide: message.isMe
                ? TooltipCardPlacementSide.start
                : TooltipCardPlacementSide.end,
            beakEnabled: true,
            whenContentVisible: WhenContentVisible.secondaryTapButton,
            builder: (ctx, close) =>
                _MessageActionsMenu(message: message, onClose: close),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: message.isMe
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(message.isMe ? 16 : 4),
                  bottomRight: Radius.circular(message.isMe ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isMe)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        message.sender,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 13,
                      color: message.isMe
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.time,
                    style: TextStyle(
                      fontSize: 10,
                      color: message.isMe
                          ? colorScheme.onPrimary.withValues(alpha: 0.7)
                          : colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe) const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _MessageActionsMenu extends StatelessWidget {
  const _MessageActionsMenu({required this.message, required this.onClose});

  final _ChatMessage message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Reactions row
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['👍', '❤️', '😂', '😮', '😢']
                  .map(
                    (emoji) => InkWell(
                      onTap: onClose,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.2)),
          _MessageAction(
            icon: Icons.reply_rounded,
            label: 'Reply',
            onTap: onClose,
          ),
          _MessageAction(
            icon: Icons.forward_rounded,
            label: 'Forward',
            onTap: onClose,
          ),
          _MessageAction(
            icon: Icons.copy_rounded,
            label: 'Copy',
            onTap: onClose,
          ),
          if (message.isMe) ...[
            Divider(
              height: 1,
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
            _MessageAction(
              icon: Icons.edit_rounded,
              label: 'Edit',
              onTap: onClose,
            ),
            _MessageAction(
              icon: Icons.delete_outline_rounded,
              label: 'Delete',
              onTap: onClose,
              isDestructive: true,
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageAction extends StatelessWidget {
  const _MessageAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? const Color(0xFFDC2626) // Red 600
        : Theme.of(context).colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 13, color: color)),
          ],
        ),
      ),
    );
  }
}
