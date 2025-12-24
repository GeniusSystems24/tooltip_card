import 'package:tooltip_card/tooltip_card.dart';

// DemoTooltipCards — v5.0.0 Comprehensive Showcase
// ------------------------------------------------
// This screen demonstrates ALL features of TooltipCard (v5.0.0):
//  • Compound placement sides (added in v4.8.0)
//  • Unified child parameter API (NEW in v5.0.0)
//  • Builder API with close()
//  • Legacy static content
//  • Visibility modes: press / hover / double‑tap / secondary‑tap
//  • Hide modes: goAway / pressOutSide
//  • Viewport‑fit (clamping, tall content auto‑scroll)
//  • PublicState (one open at a time)
//  • Modal barrier: color + blur + dismissible toggle
//  • Beak/Caret: enabled/disabled, size, alignment (start/center/end), side (top/bottom)
//  • RTL alignment
//  • Programmatic control with TooltipCardController
//  • Performance optimizations (v4.7.3)
//
// Quick run:
//   void main() => runApp(const DemoTooltipCardApp());

import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TooltipCard Demo'), centerTitle: true),
      body: const DemoTooltipCards(),
    );
  }
}

class DemoTooltipCards extends StatefulWidget {
  const DemoTooltipCards({super.key});
  @override
  State<DemoTooltipCards> createState() => _DemoTooltipCardsState();
}

class _DemoTooltipCardsState extends State<DemoTooltipCards> {
  // Shared public state: only one tooltip open at a time across this screen.
  final TooltipCardPublicState pub = TooltipCardPublicState.global;

  // Programmatic controller
  final TooltipCardController ctl = TooltipCardController();
  bool isProgramOpen = false;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TooltipCard v5.0.0 — Full Showcase',
                          style: t.headlineSmall,
                        ),
                        Text(
                          'Comprehensive examples for all features',
                          style: t.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Section 1: Compound Placement Sides
              _section('🎯 Compound Placement Sides (v4.8.0)', [
                _subsection('Vertical Compound Placements', [
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.topStart,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Top-Start Placement',
                      description:
                          'Positioned above with start alignment.\nNo need for placementAlign parameter!',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_upward),
                        SizedBox(width: 8),
                        Text('Top-Start'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.topEnd,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Top-End Placement',
                      description: 'Positioned above with end alignment.',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_upward),
                        SizedBox(width: 8),
                        Text('Top-End'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.bottomStart,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Bottom-Start Placement',
                      description: 'Positioned below with start alignment.',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_downward),
                        SizedBox(width: 8),
                        Text('Bottom-Start'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.bottomEnd,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Bottom-End Placement',
                      description: 'Positioned below with end alignment.',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_downward),
                        SizedBox(width: 8),
                        Text('Bottom-End'),
                      ],
                    ),
                  ),
                ]),
                _subsection('Horizontal Compound Placements', [
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.startTop,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Start-Top Placement',
                      description: 'Positioned at start with top alignment.',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 8),
                        Text('Start-Top'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.startBottom,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Start-Bottom Placement',
                      description: 'Positioned at start with bottom alignment.',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 8),
                        Text('Start-Bottom'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.endTop,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'End-Top Placement',
                      description: 'Positioned at end with top alignment.',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_forward),
                        SizedBox(width: 8),
                        Text('End-Top'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.endBottom,
                    flyoutBackgroundColor: Colors.grey,
                    beakColor: Colors.grey,
                    beakEnabled: true,
                    builder: (ctx, close) => SizedBox(
                      width: 100,
                      child: _panelShell(
                        title: 'End-Bottom Placement',
                        description: 'Positioned at end with bottom alignment.',
                        onClose: close,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_forward),
                        SizedBox(width: 8),
                        Text('End-Bottom'),
                      ],
                    ),
                  ),
                ]),
              ]),

              // Section 2: Basic Placements (Centered by Default)
              _section('📍 Basic Placements (Centered)', [
                _subsection('Top & Bottom', [
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.top,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      child: const _FilterPanel(),
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.filter_list),
                        SizedBox(width: 8),
                        Text('Top (Centered)'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.bottom,
                    beakEnabled: true,
                    builder: (ctx, close) =>
                        _panelShell(child: const _SortPanel(), onClose: close),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sort),
                        SizedBox(width: 8),
                        Text('Bottom (Centered)'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.bottom,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      child: const _ExportPanel(),
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.upload_file),
                        SizedBox(width: 8),
                        Text('Bottom (Centered)'),
                      ],
                    ),
                  ),
                ]),
                _subsection('Start & End', [
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.start,
                    beakEnabled: true,
                    builder: (ctx, close) =>
                        _panelShell(child: const _SmallMenu(), onClose: close),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.menu),
                        SizedBox(width: 8),
                        Text('Start Side'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.end,
                    beakEnabled: true,
                    builder: (ctx, close) =>
                        _panelShell(child: const _SmallMenu(), onClose: close),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 8),
                        Text('End Side'),
                      ],
                    ),
                  ),
                ]),
              ]),

              // Section 3: Trigger Modes
              _section('🖱️ Trigger Modes', [
                _subsection('Press & Hover', [
                  TooltipCard.builder(
                    publicState: pub,
                    whenContentVisible: WhenContentVisible.pressButton,
                    whenContentHide: WhenContentHide.goAway,
                    builder: (ctx, close) => _panelShell(
                      title: 'Press Mode',
                      description:
                          'Opens on click, closes on hover out or second click',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.touch_app),
                        SizedBox(width: 8),
                        Text('Press to Open'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    whenContentVisible: WhenContentVisible.hoverButton,
                    hoverOpenDelay: const Duration(milliseconds: 90),
                    hoverCloseDelay: const Duration(milliseconds: 220),
                    placementSide: TooltipCardPlacementSide.top,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Hover Mode',
                      description: 'Opens on hover with 90ms delay',
                      child: const _PaletteMenu(),
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.mouse),
                        SizedBox(width: 8),
                        Text('Hover to Open'),
                      ],
                    ),
                  ),
                ]),
                _subsection('Special Triggers', [
                  TooltipCard.builder(
                    publicState: pub,
                    whenContentVisible: WhenContentVisible.doubleTapButton,
                    builder: (ctx, close) => _panelShell(
                      title: 'Double-Tap Mode',
                      description: 'Requires double-tap to open',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.double_arrow),
                        SizedBox(width: 8),
                        Text('Double-Tap'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    whenContentVisible: WhenContentVisible.secondaryTapButton,
                    builder: (ctx, close) => _panelShell(
                      child: const _ContextMenu(),
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.more_horiz),
                        SizedBox(width: 8),
                        Text('Right-Click'),
                      ],
                    ),
                  ),
                ]),
              ]),

              // Section 4: Hide Modes
              _section('🚪 Hide Modes', [
                TooltipCard.builder(
                  publicState: pub,
                  whenContentHide: WhenContentHide.goAway,
                  builder: (ctx, close) => _panelShell(
                    title: 'GoAway Hide',
                    description:
                        'Closes when hovering out from button and panel',
                    onClose: close,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('GoAway Mode'),
                    ],
                  ),
                ),
                TooltipCard.builder(
                  publicState: pub,
                  whenContentHide: WhenContentHide.pressOutSide,
                  builder: (ctx, close) => _panelShell(
                    title: 'PressOutside Hide',
                    description: 'Closes only when clicking outside',
                    onClose: close,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 8),
                      Text('PressOutside Mode'),
                    ],
                  ),
                ),
              ]),

              // Section 5: Beak Variations
              _section('🔺 Beak (Callout Arrow) Variations', [
                _subsection('Beak Enabled', [
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.bottom,
                    beakEnabled: true,
                    beakSize: 10,
                    builder: (ctx, close) => _panelShell(
                      title: 'Default Beak',
                      description: 'Standard beak at center',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline),
                        SizedBox(width: 8),
                        Text('Beak • Center'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.bottom,
                    beakEnabled: true,
                    beakSize: 16,
                    builder: (ctx, close) => _panelShell(
                      title: 'Large Beak',
                      description: 'Beak size: 16px',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 8),
                        Text('Large Beak'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.top,
                    beakEnabled: true,
                    beakColor: Colors.red,
                    flyoutBackgroundColor: Colors.red.shade50,
                    builder: (ctx, close) => _panelShell(
                      title: 'Custom Beak',
                      description: 'Beak with custom color',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline),
                        SizedBox(width: 8),
                        Text('Custom Color Beak'),
                      ],
                    ),
                  ),
                ]),
                _subsection('No Beak', [
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.bottom,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Without Beak',
                      description: 'Clean panel without arrow',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.block),
                        SizedBox(width: 8),
                        Text('No Beak'),
                      ],
                    ),
                  ),
                ]),
              ]),

              // Section 6: Fluent Callout Styles
              _section('🎨 Fluent Callout Styles', [
                TooltipCard.builder(
                  publicState: pub,
                  flyoutBackgroundColor: Colors.black87,
                  placementSide: TooltipCardPlacementSide.bottom,
                  beakEnabled: true,
                  beakSize: 10,
                  builder: (ctx, close) => DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: _panelShell(
                      onClose: close,
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Fluent Dark Callout',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Classic Fluent Design with dark background',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.dark_mode),
                      SizedBox(width: 8),
                      Text('Black Callout'),
                    ],
                  ),
                ),
                TooltipCard.builder(
                  publicState: pub,
                  flyoutBackgroundColor: Colors.blue.shade700,
                  placementSide: TooltipCardPlacementSide.bottom,
                  beakEnabled: true,
                  builder: (ctx, close) => DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: _panelShell(
                      onClose: close,
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Information',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 6),
                          Text('Important information in blue accent'),
                        ],
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.info),
                      SizedBox(width: 8),
                      Text('Blue Callout'),
                    ],
                  ),
                ),
                TooltipCard.builder(
                  publicState: pub,
                  flyoutBackgroundColor: Colors.orange.shade100,
                  beakColor: Colors.orange.shade100,
                  placementSide: TooltipCardPlacementSide.top,
                  beakEnabled: true,
                  builder: (ctx, close) => _panelShell(
                    onClose: close,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning, color: Colors.orange.shade700),
                        const SizedBox(width: 8),
                        const Flexible(
                          child: Text('This action requires confirmation'),
                        ),
                      ],
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning_amber),
                      SizedBox(width: 8),
                      Text('Warning Callout'),
                    ],
                  ),
                ),
              ]),

              // Section 7: Modal Barrier
              _section('🔒 Modal Barrier', [
                _subsection('Modal with Blur', [
                  TooltipCard.builder(
                    publicState: pub,
                    modalBarrierEnabled: true,
                    barrierBlur: 8,
                    barrierColor: Colors.black.withValues(alpha: 0.35),
                    builder: (ctx, close) => _panelShell(
                      child: const _ConfirmPanel(),
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.security),
                        SizedBox(width: 8),
                        Text('Modal • Blur 8'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    modalBarrierEnabled: true,
                    barrierBlur: 16,
                    barrierColor: Colors.black.withValues(alpha: 0.5),
                    builder: (ctx, close) => _panelShell(
                      title: 'Heavy Blur',
                      description: 'Maximum blur for focus',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.blur_on),
                        SizedBox(width: 8),
                        Text('Heavy Blur'),
                      ],
                    ),
                  ),
                ]),
                _subsection('Modal Dismissible', [
                  TooltipCard.builder(
                    publicState: pub,
                    modalBarrierEnabled: true,
                    barrierDismissible: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Dismissible Modal',
                      description: 'Click outside to close',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.touch_app),
                        SizedBox(width: 8),
                        Text('Dismissible'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    modalBarrierEnabled: true,
                    barrierDismissible: false,
                    builder: (ctx, close) => _panelShell(
                      title: 'Non-Dismissible',
                      description: 'Must use close button',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline),
                        SizedBox(width: 8),
                        Text('NOT Dismissible'),
                      ],
                    ),
                  ),
                ]),
              ]),

              // Section 8: Content Types
              _section('📦 Content Types', [
                _subsection('Simple Content', [
                  TooltipCard.builder(
                    publicState: pub,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.text_fields),
                        SizedBox(width: 8),
                        Text('Simple Text'),
                      ],
                    ),
                    builder: (ctx, close) => _panelShell(
                      title: 'Simple Content',
                      description: 'Just text, nothing fancy',
                      onClose: close,
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.list),
                        SizedBox(width: 8),
                        Text('Menu List'),
                      ],
                    ),
                    builder: (ctx, close) =>
                        _panelShell(child: const _SmallMenu(), onClose: close),
                  ),
                ]),
                _subsection('Rich Content', [
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.bottom,
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      child: const _PaletteMenu(),
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.palette),
                        SizedBox(width: 8),
                        Text('Color Picker'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.tune),
                        SizedBox(width: 8),
                        Text('Filter Panel'),
                      ],
                    ),
                    builder: (ctx, close) => _panelShell(
                      child: const _FilterPanel(),
                      onClose: close,
                    ),
                  ),
                ]),
                _subsection('Tall Content', [
                  TooltipCard.builder(
                    publicState: pub,
                    placementSide: TooltipCardPlacementSide.top,
                    viewportMargin: const EdgeInsetsDirectional.all(12),
                    builder: (ctx, close) => _panelShell(
                      child: const _VeryTallContent(),
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.view_agenda_outlined),
                        SizedBox(width: 8),
                        Text('Scrollable'),
                      ],
                    ),
                  ),
                ]),
              ]),

              // Section 9: Styling
              _section('🎨 Custom Styling', [
                TooltipCard.builder(
                  publicState: pub,
                  flyoutBackgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceTint.withValues(alpha: 0.06),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  padding: const EdgeInsets.all(16),
                  elevation: 12,
                  constraints: const BoxConstraints(maxWidth: 420),
                  builder: (ctx, close) =>
                      _panelShell(child: const _StyledPanel(), onClose: close),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.design_services),
                      SizedBox(width: 8),
                      Text('Custom Style'),
                    ],
                  ),
                ),
                TooltipCard.builder(
                  publicState: pub,
                  borderRadius: BorderRadius.zero,
                  elevation: 4,
                  builder: (ctx, close) => _panelShell(
                    title: 'Square Design',
                    description: 'Sharp corners, minimal elevation',
                    onClose: close,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.square),
                      SizedBox(width: 8),
                      Text('Square Corners'),
                    ],
                  ),
                ),
                TooltipCard.builder(
                  publicState: pub,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  elevation: 16,
                  beakEnabled: true,
                  builder: (ctx, close) => _panelShell(
                    title: 'Very Rounded',
                    description: 'Maximum roundness with high elevation',
                    onClose: close,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle_outlined),
                      SizedBox(width: 8),
                      Text('Rounded'),
                    ],
                  ),
                ),
              ]),

              // Section 10: Programmatic Control
              _section('🎮 Programmatic Control', [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TooltipCard.builder(
                      publicState: pub,
                      controller: ctl,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.play_circle),
                          SizedBox(width: 8),
                          Text('Controlled Tooltip'),
                        ],
                      ),
                      onOpenChanged: (v) => setState(() => isProgramOpen = v),
                      builder: (ctx, close) => _panelShell(
                        title: 'Programmatic Control',
                        description:
                            'Use buttons below to control this tooltip',
                        onClose: close,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () => ctl.open(),
                          icon: const Icon(Icons.open_in_new, size: 18),
                          label: const Text('Open'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => ctl.close(),
                          icon: const Icon(Icons.close, size: 18),
                          label: const Text('Close'),
                        ),
                        TextButton.icon(
                          onPressed: () => ctl.toggle(),
                          icon: const Icon(Icons.swap_horiz, size: 18),
                          label: const Text('Toggle'),
                        ),
                        Chip(
                          avatar: Icon(
                            isProgramOpen ? Icons.check_circle : Icons.cancel,
                            size: 18,
                          ),
                          label: Text(isProgramOpen ? 'OPEN' : 'CLOSED'),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),

              // Section 11: RTL Support
              _section('🔄 RTL (Right-to-Left) Support', [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      TooltipCard.builder(
                        publicState: pub,
                        placementSide: TooltipCardPlacementSide.bottomStart,
                        beakEnabled: true,
                        builder: (ctx, close) => _panelShell(
                          title: 'محاذاة البداية',
                          description: 'في وضع RTL، البداية هي اليمين',
                          onClose: close,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.format_align_left),
                            SizedBox(width: 8),
                            Text('RTL • start'),
                          ],
                        ),
                      ),
                      TooltipCard.builder(
                        publicState: pub,
                        placementSide: TooltipCardPlacementSide.bottom,
                        beakEnabled: true,
                        builder: (ctx, close) => _panelShell(
                          title: 'محاذاة المركز',
                          description: 'المحاذاة في المركز',
                          onClose: close,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.format_align_center),
                            SizedBox(width: 8),
                            Text('RTL • center'),
                          ],
                        ),
                      ),
                      TooltipCard.builder(
                        publicState: pub,
                        placementSide: TooltipCardPlacementSide.bottomEnd,
                        beakEnabled: true,
                        builder: (ctx, close) => _panelShell(
                          title: 'محاذاة النهاية',
                          description: 'في وضع RTL، النهاية هي اليسار',
                          onClose: close,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.format_align_right),
                            SizedBox(width: 8),
                            Text('RTL • end'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),

              // Section 12: Legacy Constructor
              _section('📜 Legacy Constructor (Static Content)', [
                TooltipCard(
                  publicState: pub,
                  flyoutContent: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Static widget content via legacy constructor.',
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome),
                      SizedBox(width: 8),
                      Text('Legacy API'),
                    ],
                  ),
                ),
              ]),

              // Section 13: Theme Integration
              _section('🌓 Theme Integration', [
                _subsection('Auto Theme Colors', [
                  TooltipCard.builder(
                    publicState: pub,
                    // No flyoutBackgroundColor - uses theme automatically
                    beakEnabled: true,
                    builder: (ctx, close) => _panelShell(
                      title: 'Theme-Aware',
                      description:
                          'Automatically uses ${isDark ? 'dark' : 'light'} mode surface color',
                      onClose: close,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.brightness_auto),
                        SizedBox(width: 8),
                        Text('Auto Surface'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    flyoutBackgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    beakEnabled: true,
                    builder: (ctx, close) => DefaultTextStyle(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      child: _panelShell(
                        onClose: close,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Primary Container',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 6),
                            Text('Uses theme primary color'),
                          ],
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.color_lens),
                        SizedBox(width: 8),
                        Text('Primary Color'),
                      ],
                    ),
                  ),
                ]),
              ]),

              // Section 14: TooltipCardThemeData Usage
              _section('🎨 TooltipCardThemeData (v2.4.0)', [
                _subsection('Using Theme Extension', [
                  Builder(
                    builder: (context) {
                      // Access theme data via context extension
                      final tooltipTheme = context.tooltipCardTheme;
                      return TooltipCard.builder(
                        publicState: pub,
                        beakEnabled: true,
                        placementSide: TooltipCardPlacementSide.bottom,
                        builder: (ctx, close) => TooltipCardContent(
                          icon: const Icon(Icons.palette),
                          iconColor: tooltipTheme?.iconColor,
                          title: 'Theme Extension',
                          subtitle:
                              'This tooltip uses TooltipCardThemeData from context',
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Icon Color: ${tooltipTheme?.iconColor}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Elevation: ${tooltipTheme?.elevation}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Beak Size: ${tooltipTheme?.beakSize}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          primaryAction: FilledButton(
                            onPressed: close,
                            child: const Text('Got it'),
                          ),
                          onClose: close,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.extension),
                            SizedBox(width: 8),
                            Text('Context Extension'),
                          ],
                        ),
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      final tooltipTheme = context.tooltipCardTheme;
                      return TooltipCard.builder(
                        publicState: pub,
                        beakEnabled: tooltipTheme?.beakEnabled ?? true,
                        beakSize: tooltipTheme?.beakSize ?? 10,
                        elevation: tooltipTheme?.elevation ?? 8,
                        borderRadius:
                            tooltipTheme?.borderRadius ??
                            BorderRadius.circular(8),
                        placementSide: TooltipCardPlacementSide.bottom,
                        builder: (ctx, close) => TooltipCardContent(
                          icon: const Icon(Icons.style),
                          iconColor: tooltipTheme?.iconColor,
                          title: 'Themed Properties',
                          subtitle: 'All properties from TooltipCardThemeData',
                          primaryAction: FilledButton(
                            onPressed: close,
                            child: const Text('Nice!'),
                          ),
                          onClose: close,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.brush),
                            SizedBox(width: 8),
                            Text('Themed Properties'),
                          ],
                        ),
                      );
                    },
                  ),
                ]),
                _subsection('TooltipCardContent with Theme', [
                  TooltipCard.builder(
                    publicState: pub,
                    beakEnabled: true,
                    modalBarrierEnabled: true,
                    placementSide: TooltipCardPlacementSide.bottom,
                    builder: (ctx, close) {
                      final theme = ctx.tooltipCardTheme;
                      return TooltipCardContent(
                        icon: const Icon(Icons.rocket_launch),
                        iconColor:
                            theme?.iconColor ??
                            Theme.of(ctx).colorScheme.primary,
                        iconSize: theme?.iconSize ?? 24,
                        title: 'New Feature Discovery',
                        subtitle:
                            'Check out this amazing new feature that will boost your productivity!',
                        content: const Text(
                          'The TooltipCardThemeData allows you to define consistent styles for all tooltips in your app.',
                        ),
                        primaryAction: FilledButton(
                          onPressed: close,
                          child: const Text('Explore Now'),
                        ),
                        secondaryAction: OutlinedButton(
                          onPressed: close,
                          child: const Text('Later'),
                        ),
                        onClose: close,
                        maxWidth: theme?.contentMaxWidth ?? 320,
                        padding: const EdgeInsets.all(16),
                        spacing: theme?.contentSpacing ?? 12,
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome),
                        SizedBox(width: 8),
                        Text('Feature Discovery'),
                      ],
                    ),
                  ),
                  TooltipCard.builder(
                    publicState: pub,
                    beakEnabled: true,
                    placementSide: TooltipCardPlacementSide.bottom,
                    builder: (ctx, close) {
                      final theme = ctx.tooltipCardTheme;
                      return TooltipCardContent(
                        icon: const Icon(Icons.school),
                        iconColor: Colors.amber,
                        title: 'Onboarding Tip',
                        titleStyle: theme?.titleStyle,
                        subtitle: 'Learn how to use this feature effectively',
                        subtitleStyle: theme?.subtitleStyle,
                        primaryAction: FilledButton(
                          onPressed: close,
                          child: const Text('Next'),
                        ),
                        tertiaryAction: TextButton(
                          onPressed: close,
                          child: const Text('Skip Tutorial'),
                        ),
                        onClose: close,
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lightbulb),
                        SizedBox(width: 8),
                        Text('Onboarding Style'),
                      ],
                    ),
                  ),
                ]),
                _subsection('Theme Comparison', [
                  // Light theme style
                  Theme(
                    data: Theme.of(context).copyWith(
                      extensions: [
                        TooltipCardThemeData.light(primaryColor: Colors.blue),
                      ],
                    ),
                    child: Builder(
                      builder: (ctx) {
                        return TooltipCard.builder(
                          publicState: pub,
                          beakEnabled: true,
                          flyoutBackgroundColor: Colors.white,
                          beakColor: Colors.white,
                          placementSide: TooltipCardPlacementSide.bottom,
                          builder: (innerCtx, close) => TooltipCardContent(
                            icon: const Icon(Icons.light_mode),
                            iconColor: Colors.blue,
                            title: 'Light Theme',
                            subtitle: 'Using TooltipCardThemeData.light()',
                            primaryAction: FilledButton(
                              onPressed: close,
                              child: const Text('OK'),
                            ),
                            onClose: close,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.wb_sunny),
                              SizedBox(width: 8),
                              Text('Light Factory'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Dark theme style
                  Theme(
                    data: Theme.of(context).copyWith(
                      extensions: [
                        TooltipCardThemeData.dark(
                          primaryColor: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                    child: Builder(
                      builder: (ctx) {
                        return TooltipCard.builder(
                          publicState: pub,
                          beakEnabled: true,
                          flyoutBackgroundColor: const Color(0xFF2D2D30),
                          beakColor: const Color(0xFF2D2D30),
                          placementSide: TooltipCardPlacementSide.bottom,
                          builder: (innerCtx, close) => DefaultTextStyle(
                            style: const TextStyle(color: Colors.white),
                            child: TooltipCardContent(
                              icon: const Icon(Icons.dark_mode),
                              iconColor: Colors.lightBlueAccent,
                              title: 'Dark Theme',
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              subtitle: 'Using TooltipCardThemeData.dark()',
                              subtitleStyle: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                              primaryAction: FilledButton(
                                onPressed: close,
                                child: const Text('OK'),
                              ),
                              onClose: close,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.nights_stay),
                              SizedBox(width: 8),
                              Text('Dark Factory'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Fluent theme style
                  Theme(
                    data: Theme.of(context).copyWith(
                      extensions: [
                        TooltipCardThemeData.fluent(
                          brightness: Theme.of(context).brightness,
                          accentColor: Colors.deepPurple,
                        ),
                      ],
                    ),
                    child: Builder(
                      builder: (ctx) {
                        final fluentTheme = ctx.tooltipCardTheme;
                        return TooltipCard.builder(
                          publicState: pub,
                          beakEnabled: true,
                          beakSize: fluentTheme?.beakSize ?? 12,
                          elevation: fluentTheme?.elevation ?? 16,
                          placementSide: TooltipCardPlacementSide.bottom,
                          modalBarrierEnabled: true,
                          barrierBlur: fluentTheme?.barrierBlur ?? 2,
                          builder: (innerCtx, close) => TooltipCardContent(
                            icon: const Icon(Icons.window),
                            iconColor: Colors.deepPurple,
                            title: 'Fluent Theme',
                            subtitle: 'Using TooltipCardThemeData.fluent()',
                            content: const Text(
                              'Inspired by Microsoft Fluent UI design system.',
                            ),
                            primaryAction: FilledButton(
                              onPressed: close,
                              child: const Text('Awesome!'),
                            ),
                            onClose: close,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.apps),
                              SizedBox(width: 8),
                              Text('Fluent Factory'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ]),

              const SizedBox(height: 28),
              const Divider(),
              const SizedBox(height: 8),
              Center(
                child: Column(
                  children: [
                    Text(
                      '💡 Tip: Resize window/scroll — panels re‑clamp to viewport',
                      style: t.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '🎯 v5.0.0: Unified child parameter API for cleaner code',
                      style: t.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _subsection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(spacing: 12, runSpacing: 8, children: children),
        ],
      ),
    );
  }

  // Shared panel decoration wrapper (keeps spacing/buttons consistent)
  Widget _panelShell({
    String? title,
    String? description,
    Widget? child,
    required VoidCallback onClose,
  }) {
    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 6),
          ],
          if (description != null) ...[
            Text(description, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 12),
          ],
          if (child != null) ...[child, const SizedBox(height: 12)],
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: onClose,
                icon: const Icon(Icons.close, size: 16),
                label: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------
// Panels used by the demo
// ---------------------------
class _FilterPanel extends StatelessWidget {
  const _FilterPanel();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Date Range', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        const Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  labelText: 'From',
                  isDense: true,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  labelText: 'To',
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('Keyword', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        const TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search...',
            isDense: true,
          ),
        ),
      ],
    );
  }
}

class _SortPanel extends StatelessWidget {
  const _SortPanel();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Date'),
        _radioRow(['Ascending', 'Descending']),
        const SizedBox(height: 8),
        const Text('Activity'),
        _radioRow(['A‑Z', 'Z‑A']),
        const SizedBox(height: 8),
        const Text('Name'),
        _radioRow(['A‑Z', 'Z‑A']),
      ],
    );
  }
}

class _ExportPanel extends StatelessWidget {
  const _ExportPanel();
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _MenuItem(icon: Icons.picture_as_pdf, label: 'Export as PDF'),
        _MenuItem(icon: Icons.grid_on, label: 'Export as Excel'),
        _MenuItem(icon: Icons.table_chart, label: 'Export as CSV'),
      ],
    );
  }
}

class _SmallMenu extends StatelessWidget {
  const _SmallMenu();
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _MenuItem(icon: Icons.settings, label: 'Settings'),
        _MenuItem(icon: Icons.person, label: 'Profile'),
        _MenuItem(icon: Icons.logout, label: 'Sign out'),
      ],
    );
  }
}

class _ContextMenu extends StatelessWidget {
  const _ContextMenu();
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _MenuItem(icon: Icons.copy, label: 'Copy'),
        _MenuItem(icon: Icons.cut, label: 'Cut'),
        _MenuItem(icon: Icons.paste, label: 'Paste'),
        Divider(height: 1),
        _MenuItem(icon: Icons.delete_outline, label: 'Delete'),
      ],
    );
  }
}

class _PaletteMenu extends StatelessWidget {
  const _PaletteMenu();
  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.indigo,
      Colors.blue,
      Colors.teal,
      Colors.green,
      Colors.amber,
      Colors.orange,
      Colors.red,
      Colors.purple,
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final c in colors)
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class _VeryTallContent extends StatelessWidget {
  const _VeryTallContent();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Intentionally tall content',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        for (int i = 1; i <= 40; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.label_outline, size: 16),
                const SizedBox(width: 8),
                Text('Item #$i'),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('Action')),
              ],
            ),
          ),
      ],
    );
  }
}

class _ConfirmPanel extends StatelessWidget {
  const _ConfirmPanel();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Dangerous Operation',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        const Text(
          'Are you sure you want to continue? This action cannot be undone.',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
            const Spacer(),
            FilledButton.tonal(onPressed: () {}, child: const Text('Review')),
            const SizedBox(width: 8),
            FilledButton(onPressed: () {}, child: const Text('Confirm')),
          ],
        ),
      ],
    );
  }
}

class _StyledPanel extends StatelessWidget {
  const _StyledPanel();
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(Icons.palette),
            SizedBox(width: 8),
            Text('Theme Settings'),
          ],
        ),
        SizedBox(height: 12),
        _LabeledSwitch(label: 'Use dynamic color'),
        _LabeledSwitch(label: 'High contrast mode'),
        _LabeledSwitch(label: 'Reduce animations'),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 12),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _LabeledSwitch extends StatefulWidget {
  const _LabeledSwitch({required this.label});
  final String label;
  @override
  State<_LabeledSwitch> createState() => _LabeledSwitchState();
}

class _LabeledSwitchState extends State<_LabeledSwitch> {
  bool v = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(widget.label)),
        Switch(value: v, onChanged: (x) => setState(() => v = x)),
      ],
    );
  }
}

// Helper for radio groups in SortPanel
Widget _radioRow(List<String> values) => _RadioRow(values: values);

class _RadioRow extends StatefulWidget {
  const _RadioRow({required this.values});
  final List<String> values;
  @override
  State<_RadioRow> createState() => _RadioRowState();
}

class _RadioRowState extends State<_RadioRow> {
  int group = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < widget.values.length; i++) ...[
          Radio<int>(
            value: i,
            groupValue: group,
            onChanged: (v) => setState(() => group = v ?? 0),
          ),
          Text(widget.values[i]),
          const SizedBox(width: 12),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TooltipCardContent Examples (TeachingTip Style)
// ═══════════════════════════════════════════════════════════════════════════

/// Example demonstrating TooltipCardContent usage
Widget buildTooltipCardContentExamples() {
  return Wrap(
    spacing: 16,
    runSpacing: 16,
    children: [
      // Example 1: Basic TeachingTip style
      TooltipCard.builder(
        beakEnabled: true,
        placementSide: TooltipCardPlacementSide.bottom,
        whenContentVisible: WhenContentVisible.pressButton,
        builder: (context, close) => TooltipCardContent(
          icon: const Icon(Icons.lightbulb_outline),
          title: 'Pro Tip',
          subtitle: 'This feature can save you time',
          content: const Text(
            'Click the settings icon to access advanced options and customize your experience.',
          ),
          primaryAction: FilledButton(
            onPressed: close,
            child: const Text('Got it'),
          ),
          onClose: close,
        ),
        child: const FilledButton(onPressed: null, child: Text('Show Pro Tip')),
      ),

      // Example 2: With multiple actions
      TooltipCard.builder(
        beakEnabled: true,
        placementSide: TooltipCardPlacementSide.topEnd,
        whenContentVisible: WhenContentVisible.pressButton,
        builder: (context, close) => TooltipCardContent(
          icon: const Icon(Icons.info_outline),
          iconColor: Colors.blue,
          title: 'New Feature Available',
          subtitle: 'We\'ve added dark mode support',
          content: const Text(
            'Experience a more comfortable viewing experience in low-light environments.',
          ),
          primaryAction: FilledButton(
            onPressed: () {
              // Enable dark mode
              close();
            },
            child: const Text('Enable Now'),
          ),
          secondaryAction: OutlinedButton(
            onPressed: close,
            child: const Text('Later'),
          ),
          onClose: close,
        ),
        child: const FilledButton(
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 16),
              SizedBox(width: 8),
              Text('New Feature'),
            ],
          ),
        ),
      ),

      // Example 3: Warning style with tertiary action
      TooltipCard.builder(
        beakEnabled: true,
        placementSide: TooltipCardPlacementSide.start,
        whenContentVisible: WhenContentVisible.pressButton,
        showDuration: const Duration(seconds: 10),
        builder: (context, close) => TooltipCardContent(
          icon: const Icon(Icons.warning_amber_outlined),
          iconColor: Colors.orange,
          title: 'Unsaved Changes',
          subtitle: 'You have unsaved changes in your document',
          content: const Text(
            'Would you like to save your changes before continuing?',
          ),
          primaryAction: FilledButton(
            onPressed: () {
              // Save changes
              close();
            },
            child: const Text('Save'),
          ),
          secondaryAction: OutlinedButton(
            onPressed: close,
            child: const Text('Discard'),
          ),
          tertiaryAction: TextButton(
            onPressed: close,
            child: const Text('Cancel'),
          ),
          onClose: close,
        ),
        child: const FilledButton(
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber, size: 16),
              SizedBox(width: 8),
              Text('Unsaved Warning'),
            ],
          ),
        ),
      ),

      // Example 4: Success notification
      TooltipCard.builder(
        beakEnabled: true,
        placementSide: TooltipCardPlacementSide.end,
        whenContentVisible: WhenContentVisible.hoverButton,
        dismissOnPointerMoveAway: true,
        builder: (context, close) => TooltipCardContent(
          icon: const Icon(Icons.check_circle_outline),
          iconColor: Colors.green,
          title: 'Changes Saved',
          subtitle: 'All your changes have been saved successfully',
          showCloseButton: false,
          maxWidth: 280,
          onClose: close,
        ),
        child: const Icon(Icons.save),
      ),

      // Example 5: Help tooltip with custom content
      TooltipCard.builder(
        beakEnabled: true,
        placementSide: TooltipCardPlacementSide.bottomStart,
        whenContentVisible: WhenContentVisible.pressButton,
        builder: (context, close) => TooltipCardContent(
          icon: const Icon(Icons.help_outline),
          title: 'Keyboard Shortcuts',
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ShortcutRow(keys: 'Ctrl + S', description: 'Save'),
              _ShortcutRow(keys: 'Ctrl + Z', description: 'Undo'),
              _ShortcutRow(keys: 'Ctrl + Y', description: 'Redo'),
              _ShortcutRow(keys: 'Ctrl + F', description: 'Find'),
            ],
          ),
          primaryAction: FilledButton(
            onPressed: close,
            child: const Text('Close'),
          ),
          onClose: close,
        ),
        child: const FilledButton(
          onPressed: null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.keyboard, size: 16),
              SizedBox(width: 8),
              Text('Shortcuts'),
            ],
          ),
        ),
      ),

      // Example 6: Minimal style (title only)
      TooltipCard.builder(
        beakEnabled: true,
        placementSide: TooltipCardPlacementSide.top,
        whenContentVisible: WhenContentVisible.hoverButton,
        builder: (context, close) => TooltipCardContent(
          title: 'Quick Info',
          subtitle: 'Hover for more details',
          showCloseButton: false,
          maxWidth: 200,
          padding: const EdgeInsets.all(12),
          onClose: close,
        ),
        child: const Icon(Icons.info),
      ),
    ],
  );
}

// Helper widget for keyboard shortcuts
class _ShortcutRow extends StatelessWidget {
  const _ShortcutRow({required this.keys, required this.description});

  final String keys;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Text(
              keys,
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
            ),
          ),
          const SizedBox(width: 12),
          Text(description),
        ],
      ),
    );
  }
}
