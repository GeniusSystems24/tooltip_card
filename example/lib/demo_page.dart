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
      child: const Scaffold(
        body: _DemoContent(),
      ),
    );
  }

  ThemeData _buildModernTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1), // Indigo
        brightness: brightness,
      ),
      fontFamily: 'Inter',
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    colors: [
                      colorScheme.primary,
                      colorScheme.tertiary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.widgets_rounded, color: Colors.white, size: 24),
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
                'v5.3.0',
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
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.4),
            colorScheme.tertiaryContainer.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Fluent-Inspired Tooltips',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Beautiful, customizable tooltip cards with smart positioning, beak arrows, modal barriers, and smooth animations.',
            style: TextStyle(
              fontSize: 15,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
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
              subtitle: 'This is a TooltipCard in action. It supports rich content, actions, and beautiful animations.',
              primaryAction: FilledButton(
                onPressed: close,
                child: const Text('Got it!'),
              ),
              onClose: close,
            ),
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Try it now'),
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: colorScheme.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
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
                _PlacementChip(label: 'Top Start', placement: TooltipCardPlacementSide.topStart, publicState: _publicState),
                _PlacementChip(label: 'Top End', placement: TooltipCardPlacementSide.topEnd, publicState: _publicState),
                _PlacementChip(label: 'Bottom Start', placement: TooltipCardPlacementSide.bottomStart, publicState: _publicState),
                _PlacementChip(label: 'Bottom End', placement: TooltipCardPlacementSide.bottomEnd, publicState: _publicState),
                _PlacementChip(label: 'Start Top', placement: TooltipCardPlacementSide.startTop, publicState: _publicState),
                _PlacementChip(label: 'Start Bottom', placement: TooltipCardPlacementSide.startBottom, publicState: _publicState),
                _PlacementChip(label: 'End Top', placement: TooltipCardPlacementSide.endTop, publicState: _publicState),
                _PlacementChip(label: 'End Bottom', placement: TooltipCardPlacementSide.endBottom, publicState: _publicState),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTriggerModesSection(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: _TriggerModeCard(
            icon: Icons.touch_app_rounded,
            title: 'Press',
            description: 'Tap to open',
            publicState: _publicState,
            whenVisible: WhenContentVisible.pressButton,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TriggerModeCard(
            icon: Icons.mouse_rounded,
            title: 'Hover',
            description: 'Hover to open',
            publicState: _publicState,
            whenVisible: WhenContentVisible.hoverButton,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TriggerModeCard(
            icon: Icons.ads_click_rounded,
            title: 'Double Tap',
            description: 'Double-tap to open',
            publicState: _publicState,
            whenVisible: WhenContentVisible.doubleTapButton,
          ),
        ),
      ],
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

  Widget _buildModalContent(String title, String description, ColorScheme colorScheme, VoidCallback close) {
    return TooltipCardContent(
      icon: const Icon(Icons.layers_rounded),
      iconColor: colorScheme.primary,
      title: title,
      subtitle: description,
      primaryAction: FilledButton(
        onPressed: close,
        child: const Text('Close'),
      ),
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
                  onOpenChanged: (isOpen) => setState(() => _isControlledOpen = isOpen),
                  builder: (ctx, close) => TooltipCardContent(
                    icon: const Icon(Icons.smart_toy_rounded),
                    iconColor: colorScheme.primary,
                    title: 'Controlled Tooltip',
                    subtitle: 'This tooltip is controlled programmatically using TooltipCardController.',
                    primaryAction: FilledButton(
                      onPressed: close,
                      child: const Text('Dismiss'),
                    ),
                    onClose: close,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          _isControlledOpen ? Icons.visibility : Icons.visibility_off,
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
          flyoutBackgroundColor: const Color(0xFF1E1E1E),
          beakColor: const Color(0xFF1E1E1E),
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          elevation: 12,
          builder: (ctx, close) => DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: TooltipCardContent(
              icon: const Icon(Icons.dark_mode_rounded),
              iconColor: Colors.blueAccent,
              title: 'Dark Theme',
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              subtitle: 'Elegant dark appearance',
              subtitleStyle: TextStyle(color: Colors.grey.shade400),
              primaryAction: FilledButton(
                onPressed: close,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Nice!'),
              ),
              onClose: close,
            ),
          ),
          child: _StyleCard(
            icon: Icons.dark_mode_rounded,
            label: 'Dark',
            color: const Color(0xFF1E1E1E),
            textColor: Colors.white,
          ),
        ),

        // Gradient Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: colorScheme.primaryContainer,
          beakColor: colorScheme.primaryContainer,
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.gradient_rounded),
            iconColor: colorScheme.primary,
            title: 'Primary Container',
            subtitle: 'Uses theme primary container colors',
            primaryAction: FilledButton(
              onPressed: close,
              child: const Text('Beautiful!'),
            ),
            onClose: close,
          ),
          child: _StyleCard(
            icon: Icons.gradient_rounded,
            label: 'Primary',
            color: colorScheme.primaryContainer,
            textColor: colorScheme.onPrimaryContainer,
          ),
        ),

        // Warning Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: Colors.amber.shade50,
          beakColor: Colors.amber.shade50,
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.warning_rounded),
            iconColor: Colors.amber.shade700,
            title: 'Warning',
            subtitle: 'Attention-grabbing warning style',
            primaryAction: FilledButton(
              onPressed: close,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.amber.shade700,
              ),
              child: const Text('Understood'),
            ),
            onClose: close,
          ),
          child: _StyleCard(
            icon: Icons.warning_rounded,
            label: 'Warning',
            color: Colors.amber.shade100,
            textColor: Colors.amber.shade900,
          ),
        ),

        // Success Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: Colors.green.shade50,
          beakColor: Colors.green.shade50,
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.check_circle_rounded),
            iconColor: Colors.green.shade700,
            title: 'Success',
            subtitle: 'Operation completed successfully',
            primaryAction: FilledButton(
              onPressed: close,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green.shade600,
              ),
              child: const Text('Great!'),
            ),
            onClose: close,
          ),
          child: _StyleCard(
            icon: Icons.check_circle_rounded,
            label: 'Success',
            color: Colors.green.shade100,
            textColor: Colors.green.shade900,
          ),
        ),

        // Info Style
        TooltipCard.builder(
          publicState: _publicState,
          flyoutBackgroundColor: Colors.blue.shade50,
          beakColor: Colors.blue.shade50,
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.info_rounded),
            iconColor: Colors.blue.shade700,
            title: 'Information',
            subtitle: 'Helpful information for users',
            primaryAction: FilledButton(
              onPressed: close,
              child: const Text('Got it'),
            ),
            onClose: close,
          ),
          child: _StyleCard(
            icon: Icons.info_rounded,
            label: 'Info',
            color: Colors.blue.shade100,
            textColor: Colors.blue.shade900,
          ),
        ),

        // Rounded Style
        TooltipCard.builder(
          publicState: _publicState,
          borderRadius: BorderRadius.circular(24),
          placementSide: TooltipCardPlacementSide.bottom,
          beakEnabled: true,
          elevation: 16,
          builder: (ctx, close) => TooltipCardContent(
            icon: const Icon(Icons.circle_rounded),
            iconColor: colorScheme.primary,
            title: 'Extra Rounded',
            subtitle: 'Soft, friendly appearance',
            primaryAction: FilledButton(
              onPressed: close,
              child: const Text('Love it!'),
            ),
            onClose: close,
          ),
          child: _StyleCard(
            icon: Icons.circle_rounded,
            label: 'Rounded',
            color: colorScheme.surfaceContainerHighest,
            textColor: colorScheme.onSurface,
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
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
          ),
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
        primaryAction: FilledButton(
          onPressed: close,
          child: const Text('OK'),
        ),
        onClose: close,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.3),
          ),
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
  });

  final IconData icon;
  final String title;
  final String description;
  final TooltipCardPublicState publicState;
  final WhenContentVisible whenVisible;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TooltipCard.builder(
      publicState: publicState,
      whenContentVisible: whenVisible,
      hoverOpenDelay: const Duration(milliseconds: 100),
      placementSide: TooltipCardPlacementSide.bottom,
      beakEnabled: true,
      builder: (ctx, close) => TooltipCardContent(
        icon: Icon(icon),
        iconColor: colorScheme.primary,
        title: '$title Mode',
        subtitle: '$description the trigger to activate this tooltip.',
        primaryAction: FilledButton(
          onPressed: close,
          child: const Text('Close'),
        ),
        onClose: close,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 28, color: colorScheme.primary),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
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
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
