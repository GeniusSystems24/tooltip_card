// TooltipCard — Fluent Beak/Callout (v5.3.0 - Fluent UI Inspired)
// -----------------------------------------------------------------
// Enhanced Fluent-style tooltip with comprehensive improvements:
//
// ✨ Performance:
//   • Optimized rebuilds with const constructors
//   • RepaintBoundary for independent widgets
//   • Reduced redundant calculations
//   • 3-phase sequential positioning system
//
// 🎬 Animations:
//   • Smooth spring-based animations
//   • Enhanced curve transitions
//   • Improved timing
//
// 🎨 Theming:
//   • Full Material 3 color scheme support
//   • Dark mode optimized
//   • Elevation system integrated
//
// 📐 Spacing & Layout:
//   • Unified spacing tokens
//   • Improved padding defaults
//   • Better alignment precision
//   • BorderRadius-aware beak positioning
//
// ♿ Accessibility:
//   • Enhanced semantics
//   • Keyboard navigation
//   • Screen reader support
//
// 🚀 Core Features:
//   • RTL-aware positioning
//   • Beak/caret with shadow matching panel
//   • Viewport-fit with auto-flip and smart placement
//   • Modal scrim with blur support
//   • Multiple trigger modes (press/hover/double-tap/right-click)
//   • Builder API with close callback
//
// 🎯 Fluent UI Inspired Features (v5.2.0):
//   • dismissOnPointerMoveAway - Auto-close when pointer leaves
//   • showDuration - Auto-hide after specified duration
//   • offset - Custom positioning fine-tuning
//   • onOpen/onClose - Separate event callbacks
//
// 📦 TooltipCardContent Widget (v5.3.0 - TeachingTip Style):
//   • Structured content layout inspired by Fluent UI TeachingTip
//   • Icon/image header support
//   • Title and subtitle sections
//   • Custom content area
//   • Multiple action buttons (primary, secondary, tertiary)
//   • Built-in close button
//   • Professional, consistent design
//
// Usage example with TooltipCardContent:
//   TooltipCard.builder(
//     beakEnabled: true,
//     placementSide: TooltipCardPlacementSide.bottom,
//     whenContentVisable: WhenContentVisable.pressButton,
//     flyoutContentBuilder: (ctx, close) => TooltipCardContent(
//       icon: const Icon(Icons.lightbulb_outline),
//       title: 'Pro Tip',
//       subtitle: 'This feature can save you time',
//       content: const Text('Click here to access advanced settings...'),
//       primaryAction: FilledButton(
//         onPressed: close,
//         child: const Text('Got it'),
//       ),
//       onClose: close,
//     ),
//     child: const Text('Hover me'),
//   )
//
// Custom content example:
//   TooltipCard.builder(
//     child: const Icon(Icons.info),
//     flyoutContentBuilder: (ctx, close) => Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Custom Content'),
//           ElevatedButton(onPressed: close, child: Text('Close')),
//         ],
//       ),
//     ),
//   )

// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter; // blur

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Design Tokens - Spacing, Timing, and Constants
// ═══════════════════════════════════════════════════════════════════════════

/// Spacing tokens for consistent padding and margins
class _TooltipCardSpacing {
  static const double sm = 8.0;
  static const double md = 12.0;
}

/// Animation timing constants
class _TooltipCardTiming {
  static const Duration enterDuration = Duration(milliseconds: 200);
  static const Duration exitDuration = Duration(milliseconds: 150);
}

/// Animation curves
class _TooltipCardCurves {
  // Spring-based curves for smooth, natural motion
  static const Curve fade = Curves.easeOut;

  // Enhanced scale animation with spring effect
  static final Curve scaleIn = Curves.easeOutBack;
  static const Curve scaleOut = Curves.easeInCubic;
}

/// Sizing constants
class _TooltipCardConstants {
  static const double defaultMaxWidth = 360.0;
  static const double positionEpsilon = 0.5;
  static const double shadowOpacity = 0.25;
}

// ═══════════════════════════════════════════════════════════════════════════
// Enums
// ═══════════════════════════════════════════════════════════════════════════

enum WhenContentHide { goAway, pressOutSide }

enum WhenContentVisable {
  pressButton,
  hoverButton,
  doubleTapButton,
  secondaryTapButton,
}

/// Placement side for the tooltip panel
///
/// Basic sides:
/// - [top]: Above the target
/// - [bottom]: Below the target
/// - [start]: To the start of the target (RTL aware)
/// - [end]: To the end of the target (RTL aware)
///
/// Compound sides (for precise positioning):
/// - [topStart]: Above and aligned to start
/// - [topEnd]: Above and aligned to end
/// - [bottomStart]: Below and aligned to start
/// - [bottomEnd]: Below and aligned to end
/// - [startTop]: To the start and aligned to top
/// - [startBottom]: To the start and aligned to bottom
/// - [endTop]: To the end and aligned to top
/// - [endBottom]: To the end and aligned to bottom
enum TooltipCardPlacementSide {
  top,
  bottom,
  start,
  end,
  topStart,
  topEnd,
  bottomStart,
  bottomEnd,
  startTop,
  startBottom,
  endTop,
  endBottom,
}

// ═══════════════════════════════════════════════════════════════════════════
// Helper Extensions for Placement
// ═══════════════════════════════════════════════════════════════════════════

/// Internal alignment type for positioning calculations
enum _HorizontalAlign { start, center, end }

enum _VerticalAlign { top, center, bottom }

extension TooltipCardPlacementSideExtension on TooltipCardPlacementSide {
  /// Returns the base side (top, bottom, start, or end) for compound placements
  TooltipCardPlacementSide get baseSide {
    switch (this) {
      case TooltipCardPlacementSide.topStart:
      case TooltipCardPlacementSide.topEnd:
        return TooltipCardPlacementSide.top;
      case TooltipCardPlacementSide.bottomStart:
      case TooltipCardPlacementSide.bottomEnd:
        return TooltipCardPlacementSide.bottom;
      case TooltipCardPlacementSide.startTop:
      case TooltipCardPlacementSide.startBottom:
        return TooltipCardPlacementSide.start;
      case TooltipCardPlacementSide.endTop:
      case TooltipCardPlacementSide.endBottom:
        return TooltipCardPlacementSide.end;
      default:
        return this;
    }
  }

  /// Checks if this is a compound placement (has both side and alignment)
  bool get isCompound {
    switch (this) {
      case TooltipCardPlacementSide.topStart:
      case TooltipCardPlacementSide.topEnd:
      case TooltipCardPlacementSide.bottomStart:
      case TooltipCardPlacementSide.bottomEnd:
      case TooltipCardPlacementSide.startTop:
      case TooltipCardPlacementSide.startBottom:
      case TooltipCardPlacementSide.endTop:
      case TooltipCardPlacementSide.endBottom:
        return true;
      default:
        return false;
    }
  }

  /// Checks if this is a vertical placement (top or bottom based)
  bool get isVertical {
    final base = baseSide;
    return base == TooltipCardPlacementSide.top ||
        base == TooltipCardPlacementSide.bottom;
  }

  /// Checks if this is a horizontal placement (start or end based)
  bool get isHorizontal {
    final base = baseSide;
    return base == TooltipCardPlacementSide.start ||
        base == TooltipCardPlacementSide.end;
  }

  /// Gets the horizontal alignment encoded in compound placements
  /// For vertical placements (top/bottom), returns the horizontal alignment
  /// For basic sides, returns center
  _HorizontalAlign get horizontalAlign {
    switch (this) {
      case TooltipCardPlacementSide.topStart:
      case TooltipCardPlacementSide.bottomStart:
        return _HorizontalAlign.start;
      case TooltipCardPlacementSide.topEnd:
      case TooltipCardPlacementSide.bottomEnd:
        return _HorizontalAlign.end;
      default:
        return _HorizontalAlign.center;
    }
  }

  /// Gets the vertical alignment encoded in compound placements
  /// For horizontal placements (start/end), returns the vertical alignment
  /// For basic sides, returns center
  _VerticalAlign get verticalAlign {
    switch (this) {
      case TooltipCardPlacementSide.startTop:
      case TooltipCardPlacementSide.endTop:
        return _VerticalAlign.top;
      case TooltipCardPlacementSide.startBottom:
      case TooltipCardPlacementSide.endBottom:
        return _VerticalAlign.bottom;
      default:
        return _VerticalAlign.center;
    }
  }
}

class TooltipCardPublicState extends ChangeNotifier {
  TooltipCardPublicState._();
  static final TooltipCardPublicState global = TooltipCardPublicState._();
  TooltipCardController? _openController;
  bool get hasAnyOpen => _openController != null;
  TooltipCardController? get openController => _openController;
  bool isAnotherOpen(TooltipCardController me) =>
      _openController != null && _openController != me;
  void _registerOpen(TooltipCardController c) {
    if (_openController == c) return;
    _openController?.close();
    _openController = c;
    notifyListeners();
  }

  void _registerClose(TooltipCardController c) {
    if (_openController == c) {
      _openController = null;
      notifyListeners();
    }
  }
}

class TooltipCardController extends ChangeNotifier {
  bool _isOpen = false;
  bool get isOpen => _isOpen;
  void open() {
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
    }
  }

  void close() {
    if (_isOpen) {
      _isOpen = false;
      notifyListeners();
    }
  }

  void toggle() => _isOpen ? close() : open();
}

class TooltipCard extends StatefulWidget {
  // Preferred constructor: dynamic content with builder and a `close()` callback.
  const TooltipCard.builder({
    super.key,
    required this.child,
    required this.flyoutContentBuilder,
    this.whenContentHide = WhenContentHide.goAway,
    this.whenContentVisable = WhenContentVisable.pressButton,
    this.hoverOpenDelay = const Duration(milliseconds: 500),
    this.hoverCloseDelay = const Duration(milliseconds: 250),
    this.awaySpace = 0.0,
    this.placementSide = TooltipCardPlacementSide.top,
    this.flyoutBackgroundColor,
    this.elevation = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.all(0),
    this.controller,
    this.constraints,
    this.onOpenChanged,
    this.onOpen,
    this.onClose,
    this.useRootOverlay = true,
    this.publicState,
    // Viewport‑fit
    this.fitToViewport = true,
    this.viewportMargin = const EdgeInsetsDirectional.all(8),
    this.autoFlipIfZeroSpace = true,
    this.wrapContentInScrollView = true,
    // Modal scrim
    this.modalBarrierEnabled = false,
    this.barrierColor,
    this.barrierBlur = 0.0,
    this.barrierDismissible,
    // Fluent UI inspired features
    this.dismissOnPointerMoveAway = false,
    this.showDuration,
    this.offset = Offset.zero,
    // Beak
    this.beakEnabled = true,
    this.beakSize = 10,
    this.beakInset = 16,
    this.beakColor,
  }) : flyoutContent = null;

  // Legacy constructor: static content.
  const TooltipCard({
    super.key,
    required this.child,
    required this.flyoutContent,
    this.controller,
    this.whenContentHide = WhenContentHide.goAway,
    this.whenContentVisable = WhenContentVisable.pressButton,
    this.hoverOpenDelay = const Duration(milliseconds: 300),
    this.hoverCloseDelay = const Duration(milliseconds: 300),
    this.awaySpace = 8.0,
    this.placementSide = TooltipCardPlacementSide.bottom,
    this.flyoutBackgroundColor,
    this.elevation = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsetsDirectional.all(0),
    this.constraints,
    this.onOpenChanged,
    this.onOpen,
    this.onClose,
    this.useRootOverlay = true,
    this.publicState,
    // Viewport‑fit
    this.fitToViewport = true,
    this.viewportMargin = const EdgeInsetsDirectional.all(8),
    this.autoFlipIfZeroSpace = true,
    this.wrapContentInScrollView = true,
    // Modal scrim
    this.modalBarrierEnabled = false,
    this.barrierColor,
    this.barrierBlur = 4,
    this.barrierDismissible,
    // Fluent UI inspired features
    this.dismissOnPointerMoveAway = false,
    this.showDuration,
    this.offset = Offset.zero,
    // Beak
    this.beakEnabled = true,
    this.beakSize = 10,
    this.beakInset = 20,
    this.beakColor,
  }) : flyoutContentBuilder = null;

  final Widget? flyoutContent;
  final Widget Function(BuildContext context, VoidCallback close)?
  flyoutContentBuilder;

  final Widget child;
  final WhenContentHide whenContentHide;
  final WhenContentVisable whenContentVisable;
  final Duration hoverOpenDelay;
  final Duration hoverCloseDelay;
  final double awaySpace;
  final TooltipCardPlacementSide placementSide;
  final Color? flyoutBackgroundColor;
  final double elevation;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final TooltipCardController? controller;

  /// Legacy callback that fires when open state changes
  final ValueChanged<bool>? onOpenChanged;

  /// Callback fired when the tooltip opens (Fluent UI style)
  final VoidCallback? onOpen;

  /// Callback fired when the tooltip closes (Fluent UI style)
  final VoidCallback? onClose;

  final bool useRootOverlay;
  final TooltipCardPublicState? publicState;

  // Viewport‑fit
  final bool fitToViewport;
  final EdgeInsetsDirectional viewportMargin;
  final bool autoFlipIfZeroSpace;
  final bool wrapContentInScrollView;

  // Modal scrim API
  final bool modalBarrierEnabled;
  final Color? barrierColor;
  final double barrierBlur;
  final bool? barrierDismissible;

  // Fluent UI inspired features

  /// Whether to dismiss the tooltip when the pointer moves away from both
  /// the target and the tooltip content.
  ///
  /// Inspired by Fluent UI's dismissOnPointerMoveAway feature.
  /// When enabled, the tooltip will close after [hoverCloseDelay] when the
  /// pointer is no longer over the target or tooltip.
  final bool dismissOnPointerMoveAway;

  /// Optional duration after which the tooltip will automatically close.
  ///
  /// Inspired by Fluent UI's showDuration feature.
  /// If null, the tooltip will remain open until explicitly closed.
  /// If set, a timer will automatically close the tooltip after this duration.
  final Duration? showDuration;

  /// Custom offset to apply to the tooltip position.
  ///
  /// Inspired by Fluent UI's offset parameter.
  /// This allows fine-tuning the tooltip position beyond the standard
  /// placement modes. The offset is applied after all positioning
  /// calculations are complete.
  final Offset offset;

  // Beak API
  final bool beakEnabled;
  final double beakSize;
  final double beakInset;
  final Color? beakColor;

  @override
  State<TooltipCard> createState() => _TooltipCardState();
}

class _TooltipCardState extends State<TooltipCard>
    with TickerProviderStateMixin {
  final GlobalKey _targetKey = GlobalKey();
  OverlayEntry? _barrierEntry; // scrim
  OverlayEntry? _panelEntry; // panel
  late final TooltipCardController _controller =
      widget.controller ?? TooltipCardController();
  late final TooltipCardPublicState _public =
      widget.publicState ?? TooltipCardPublicState.global;

  late TooltipCardPlacementSide _resolvedSide;
  double _resolvedBeakPosition = 0.0;

  late AnimationController _anim;
  late Animation<double> _fade;
  late Animation<double> _scale;
  bool _hoverTarget = false;
  bool _hoverPanel = false;
  Timer? _hoverTimer;
  Timer? _showDurationTimer; // Fluent UI: auto-close timer
  Ticker? _repositionTicker;

  bool get _isPressLike =>
      widget.whenContentVisable == WhenContentVisable.pressButton ||
      widget.whenContentVisable == WhenContentVisable.doubleTapButton ||
      widget.whenContentVisable == WhenContentVisable.secondaryTapButton;

  bool get _shouldAutoCloseOnHoverOut {
    return widget.whenContentVisable == WhenContentVisable.hoverButton ||
        (_isPressLike && widget.whenContentHide == WhenContentHide.goAway) ||
        widget.dismissOnPointerMoveAway;
  }

  @override
  void initState() {
    super.initState();
    _resolvedSide = widget.placementSide;
    _anim = AnimationController(
      vsync: this,
      duration: _TooltipCardTiming.enterDuration,
      reverseDuration: _TooltipCardTiming.exitDuration,
    );
    _fade = CurvedAnimation(parent: _anim, curve: _TooltipCardCurves.fade);
    _setupScale();
    _controller.addListener(_handleControllerChange);
  }

  void _setupScale() {
    _scale =
        Tween<double>(
          begin:
              0.88, // Slightly smaller initial scale for more pronounced effect
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _anim,
            curve: _TooltipCardCurves.scaleIn,
            reverseCurve: _TooltipCardCurves.scaleOut,
          ),
        );
  }

  @override
  void didUpdateWidget(covariant TooltipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.placementSide != widget.placementSide) {
      _resolvedSide = widget.placementSide;
      _setupScale();
    }
  }

  @override
  void dispose() {
    _stopTicker();
    _removeEntries();
    _controller.removeListener(_handleControllerChange);
    if (widget.controller == null) _controller.dispose();
    _anim.dispose();
    _hoverTimer?.cancel();
    _showDurationTimer?.cancel();
    super.dispose();
  }

  void _handleControllerChange() {
    if (_controller.isOpen) {
      _public._registerOpen(_controller);
      _showTooltipCard();
    } else {
      _hideTooltipCard();
      _public._registerClose(_controller);
    }
  }

  void _toggleFromPressLike() {
    if (widget.whenContentHide == WhenContentHide.goAway) {
      _controller.toggle();
    } else {
      _controller.open();
    }
  }

  void _startTicker() {
    _repositionTicker ??= Ticker((_) => _panelEntry?.markNeedsBuild());
    _repositionTicker!.start();
  }

  void _stopTicker() {
    _repositionTicker?.stop();
  }

  void _updateResolvedPlacement(
    TooltipCardPlacementSide side,
    double beakPosition,
  ) {
    if (_resolvedSide == side && _resolvedBeakPosition == beakPosition) return;
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_resolvedSide == side && _resolvedBeakPosition == beakPosition) {
        return;
      }
      setState(() {
        _resolvedSide = side;
        _resolvedBeakPosition = beakPosition;
        _setupScale();
      });
    });
  }

  void _showTooltipCard() {
    if (_panelEntry != null) return;
    final overlay = Overlay.of(context, rootOverlay: widget.useRootOverlay);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Enhanced theming with proper dark mode support
    final defaultScrim = colorScheme.scrim.withValues(
      alpha: theme.brightness == Brightness.dark ? 0.5 : 0.45,
    );

    final bool effectiveDismissible =
        widget.barrierDismissible ??
        (widget.modalBarrierEnabled
            ? true
            : (widget.whenContentHide == WhenContentHide.pressOutSide));
    final bool needBarrier = widget.modalBarrierEnabled || effectiveDismissible;

    if (needBarrier) {
      _barrierEntry = OverlayEntry(
        builder: (context) => Semantics(
          label: widget.modalBarrierEnabled
              ? 'Modal barrier'
              : 'Dismissible overlay',
          button: effectiveDismissible,
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _fade,
              builder: (context, _) {
                final Color color = widget.modalBarrierEnabled
                    ? (widget.barrierColor ?? defaultScrim).withValues(
                        alpha:
                            (widget.barrierColor?.a ??
                                (theme.brightness == Brightness.dark
                                    ? 0.5
                                    : 0.45)) *
                            _fade.value,
                      )
                    : Colors.transparent;

                Widget scrim = Container(color: color);

                // Apply blur effect with performance optimization
                if (widget.modalBarrierEnabled && widget.barrierBlur > 0) {
                  scrim = BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: widget.barrierBlur * _fade.value,
                      sigmaY: widget.barrierBlur * _fade.value,
                      tileMode: TileMode.clamp,
                    ),
                    child: scrim,
                  );
                }

                if (effectiveDismissible) {
                  scrim = GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _controller.close,
                    child: scrim,
                  );
                }

                if (widget.modalBarrierEnabled && !effectiveDismissible) {
                  scrim = AbsorbPointer(absorbing: true, child: scrim);
                }

                return SizedBox.expand(child: scrim);
              },
            ),
          ),
        ),
      );
    }

    _panelEntry = OverlayEntry(
      builder: (overlayCtx) {
        final overlayBox = overlay.context.findRenderObject() as RenderBox;
        final targetBox =
            _targetKey.currentContext?.findRenderObject() as RenderBox?;
        if (targetBox == null) return const SizedBox.shrink();
        final targetTopLeft = targetBox.localToGlobal(
          Offset.zero,
          ancestor: overlayBox,
        );
        final targetSize = targetBox.size;
        final targetRect = Rect.fromLTWH(
          targetTopLeft.dx,
          targetTopLeft.dy,
          targetSize.width,
          targetSize.height,
        );
        final overlaySize = overlayBox.size;

        // Build content
        final BuildContext scopedContext = _targetKey.currentContext ?? context;
        Widget builtChild = widget.flyoutContentBuilder != null
            ? widget.flyoutContentBuilder!(scopedContext, _controller.close)
            : widget.flyoutContent!;
        if (widget.wrapContentInScrollView) {
          builtChild = SingleChildScrollView(primary: false, child: builtChild);
        }

        return CustomSingleChildLayout(
          delegate: _TooltipCardPositionDelegate(
            overlaySize: overlaySize,
            targetRect: targetRect,
            awaySpace: widget.awaySpace,
            preferredSide: widget.placementSide,
            textDirection: Directionality.of(context),
            viewportMargin: widget.viewportMargin,
            fitToViewport: widget.fitToViewport,
            autoFlipIfZeroSpace: widget.autoFlipIfZeroSpace,
            userConstraints: widget.constraints,
            borderRadius: widget.borderRadius,
            beakSize: widget.beakSize,
            offset: widget.offset,
            onResolvedPlacement: _updateResolvedPlacement,
          ),
          child: MouseRegion(
            onEnter: (_) {
              _hoverPanel = true;
              _hoverTimer?.cancel();
            },
            onExit: (_) {
              _hoverPanel = false;
              _scheduleMaybeClose();
            },
            child: Semantics(
              container: true,
              label: 'Tooltip panel',
              child: _BeakedTooltipCardPanel(
                // animation + visuals
                fade: _fade,
                scale: _scale,
                onEscape: _controller.close,
                elevation: widget.elevation,
                bg: _getPanelBackgroundColor(theme),
                borderRadius: widget.borderRadius,
                padding: widget.padding,
                constraints: widget.constraints,
                // beak
                beakEnabled: widget.beakEnabled,
                beakSize: widget.beakSize,
                beakInset: widget.beakInset,
                beakColor: widget.beakColor ?? _getPanelBackgroundColor(theme),
                beakPosition: _resolvedBeakPosition,
                side: _resolvedSide,
                targetRect: targetRect,
                textDirection: Directionality.of(context),
                child: builtChild,
              ),
            ),
          ),
        );
      },
    );

    if (_barrierEntry != null) {
      overlay.insertAll([_barrierEntry!, _panelEntry!]);
    } else {
      overlay.insert(_panelEntry!);
    }

    _anim.forward(from: 0);

    // Fire callbacks (Fluent UI style)
    widget.onOpenChanged?.call(true);
    widget.onOpen?.call();

    // Start auto-close timer if showDuration is set (Fluent UI feature)
    if (widget.showDuration != null) {
      _showDurationTimer?.cancel();
      _showDurationTimer = Timer(widget.showDuration!, () {
        if (!mounted) return;
        _controller.close();
      });
    }

    _startTicker();
  }

  void _hideTooltipCard() async {
    if (_panelEntry == null) return;

    // Cancel auto-close timer
    _showDurationTimer?.cancel();

    try {
      await _anim.reverse();
    } finally {
      _stopTicker();
      _removeEntries();

      // Fire callbacks (Fluent UI style)
      widget.onOpenChanged?.call(false);
      widget.onClose?.call();
    }
  }

  void _removeEntries() {
    _panelEntry?.remove();
    _barrierEntry?.remove();
    _panelEntry = null;
    _barrierEntry = null;
  }

  void _scheduleMaybeClose() {
    if (!_shouldAutoCloseOnHoverOut) return;
    _hoverTimer?.cancel();
    _hoverTimer = Timer(widget.hoverCloseDelay, () {
      if (!_hoverTarget && !_hoverPanel) _controller.close();
    });
  }

  /// Gets the appropriate panel background color with theme awareness
  Color _getPanelBackgroundColor(ThemeData theme) {
    if (widget.flyoutBackgroundColor != null) {
      return widget.flyoutBackgroundColor!;
    }

    // Use Material 3 surface tones for better theming
    final colorScheme = theme.colorScheme;
    return theme.brightness == Brightness.dark
        ? colorScheme.surfaceContainerHigh
        : colorScheme.surface;
  }

  /// Gets semantic label for screen readers
  String _getSemanticLabel() {
    final baseLabel = 'Tooltip trigger';
    final state = _controller.isOpen ? 'expanded' : 'collapsed';
    return '$baseLabel, $state';
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.flyoutContent != null || widget.flyoutContentBuilder != null,
      'Either flyoutContent or flyoutContentBuilder must be provided',
    );

    final buttonVisual = _buildButtonVisual(context);

    final target = Semantics(
      button: true,
      enabled: true,
      expanded: _controller.isOpen,
      label: _getSemanticLabel(),
      child: GestureDetector(
        onTap: (widget.whenContentVisable == WhenContentVisable.pressButton)
            ? _toggleFromPressLike
            : null,
        onDoubleTap:
            (widget.whenContentVisable == WhenContentVisable.doubleTapButton)
            ? _toggleFromPressLike
            : null,
        onSecondaryTap:
            (widget.whenContentVisable == WhenContentVisable.secondaryTapButton)
            ? _toggleFromPressLike
            : null,
        behavior: HitTestBehavior.opaque,
        child: Focus(
          onKeyEvent: (node, event) {
            if (_controller.isOpen &&
                event.logicalKey == LogicalKeyboardKey.escape) {
              _controller.close();
              return KeyEventResult.handled;
            }
            // Support Enter/Space to toggle (keyboard accessibility)
            if (!_controller.isOpen &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.space)) {
              _controller.open();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: AnimatedBuilder(
            animation: Listenable.merge([_controller, _public]),
            builder: (context, _) {
              return buttonVisual;
            },
          ),
        ),
      ),
    );

    final withHover = MouseRegion(
      onEnter: (_) {
        _hoverTarget = true;
        if (widget.whenContentVisable == WhenContentVisable.hoverButton) {
          _hoverTimer?.cancel();
          _hoverTimer = Timer(widget.hoverOpenDelay, () {
            if (_hoverTarget) _controller.open();
          });
        }
      },
      onExit: (_) {
        _hoverTarget = false;
        _scheduleMaybeClose();
      },
      child: target,
    );

    return KeyedSubtree(key: _targetKey, child: withHover);
  }

  Widget _buildButtonVisual(BuildContext context) {
    return widget.child;
  }
}

/// Position delegate implementing a 3-phase sequential positioning system:
///
/// Phase 1: Select Best Side
///   - Calculate available space in each direction
///   - Select the optimal side based on content size and space availability
///
/// Phase 2: Calculate Beak Position
///   - Determine where the beak should be positioned on the flyout edge
///   - Avoid borderRadius zones to keep beak away from rounded corners
///
/// Phase 3: Calculate Flyout Position
///   - Position the flyout content such that the beak points to child center
///   - Apply viewport constraints to ensure content stays visible
class _TooltipCardPositionDelegate extends SingleChildLayoutDelegate {
  _TooltipCardPositionDelegate({
    required this.overlaySize,
    required this.targetRect,
    required this.awaySpace,
    required this.preferredSide,
    required this.textDirection,
    required this.viewportMargin,
    required this.fitToViewport,
    required this.autoFlipIfZeroSpace,
    required this.userConstraints,
    required this.borderRadius,
    required this.beakSize,
    required this.offset,
    required this.onResolvedPlacement,
  });

  // Use shared constant for precision calculations
  static const double _epsilon = _TooltipCardConstants.positionEpsilon;

  final Size overlaySize;
  final Rect targetRect;
  final double awaySpace;
  final TooltipCardPlacementSide preferredSide;
  final TextDirection textDirection;
  final EdgeInsetsDirectional viewportMargin;
  final bool fitToViewport;
  final bool autoFlipIfZeroSpace;
  final BoxConstraints? userConstraints;
  final BorderRadius borderRadius;
  final double beakSize;

  bool get isLTR => textDirection == TextDirection.ltr;

  /// Custom offset to apply after positioning calculations (Fluent UI feature)
  final Offset offset;

  final void Function(TooltipCardPlacementSide side, double beakPosition)
  onResolvedPlacement;

  bool get _isRTL => textDirection == TextDirection.rtl;

  /// Extracts the maximum corner radius from BorderRadius
  /// Used to calculate safe zones where the beak should not be positioned
  double get _maxCornerRadius {
    // For simplicity, we'll use the topLeft radius as representative
    // In a more sophisticated implementation, we'd check the specific corner
    // based on the selected side
    final topLeft = borderRadius.topLeft;
    return math.max(topLeft.x, topLeft.y);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PHASE 1: Select Best Side
  // ═══════════════════════════════════════════════════════════════════════════

  /// Calculates available space in the top direction
  /// Returns the maximum height available for content placed above the target
  double _calculateTopSpace() {
    return math.max(
      0,
      targetRect.top - viewportMargin.top - beakSize - awaySpace,
    );
  }

  /// Calculates available space in the bottom direction
  /// Returns the maximum height available for content placed below the target
  double _calculateBottomSpace() {
    return math.max(
      0,
      overlaySize.height -
          targetRect.bottom -
          viewportMargin.bottom -
          beakSize -
          awaySpace,
    );
  }

  /// Calculates available space in the start direction (LTR: left, RTL: right)
  /// Returns the maximum width available for content placed at the start side
  double _calculateStartSpace() {
    final bool tooltipOnLeft = !_isRTL;
    final viewportMarginLeft = isLTR
        ? viewportMargin.start
        : viewportMargin.end;
    final viewportMarginRight = isLTR
        ? viewportMargin.end
        : viewportMargin.start;

    final double available = tooltipOnLeft
        ? targetRect.left - viewportMarginLeft - beakSize - awaySpace
        : overlaySize.width -
              viewportMarginRight -
              targetRect.right -
              beakSize -
              awaySpace;
    return math.max(0, available);
  }

  /// Calculates available space in the end direction (LTR: right, RTL: left)
  /// Returns the maximum width available for content placed at the end side
  double _calculateEndSpace() {
    final bool tooltipOnRight = !_isRTL;
    final viewportMarginLeft = isLTR
        ? viewportMargin.start
        : viewportMargin.end;
    final viewportMarginRight = isLTR
        ? viewportMargin.end
        : viewportMargin.start;

    final double available = tooltipOnRight
        ? overlaySize.width -
              viewportMarginRight -
              targetRect.right -
              beakSize -
              awaySpace
        : targetRect.left - viewportMarginLeft - beakSize - awaySpace;
    return math.max(0, available);
  }

  /// PHASE 1: Selects the best side for placing the tooltip
  ///
  /// Algorithm:
  /// 1. Calculate available space in all 4 directions
  /// 2. Check if content fits in preferred side
  /// 3. If not, select the side with maximum available space
  ///
  /// Returns the selected placement side
  TooltipCardPlacementSide _selectBestSide(Size contentSize) {
    // Calculate available space in each direction
    final topSpace = _calculateTopSpace();
    final bottomSpace = _calculateBottomSpace();
    final startSpace = _calculateStartSpace();
    final endSpace = _calculateEndSpace();

    // Get base side from preferred (strips alignment modifiers)
    final preferredBase = preferredSide.baseSide;

    // Check if content fits in preferred side
    bool fitsInPreferred = false;
    switch (preferredBase) {
      case TooltipCardPlacementSide.top:
        fitsInPreferred = contentSize.height <= topSpace + _epsilon;
        break;
      case TooltipCardPlacementSide.bottom:
        fitsInPreferred = contentSize.height <= bottomSpace + _epsilon;
        break;
      case TooltipCardPlacementSide.start:
        fitsInPreferred = contentSize.width <= startSpace + _epsilon;
        break;
      case TooltipCardPlacementSide.end:
        fitsInPreferred = contentSize.width <= endSpace + _epsilon;
        break;
      default:
        break;
    }

    // If content fits in preferred side, use it
    if (fitsInPreferred) {
      return preferredBase;
    }

    // Otherwise, select the side with maximum available space
    // For vertical sides (top/bottom), compare heights
    // For horizontal sides (start/end), compare widths

    // Find best vertical side
    final bestVerticalSide = topSpace > bottomSpace
        ? TooltipCardPlacementSide.top
        : TooltipCardPlacementSide.bottom;
    final bestVerticalSpace = math.max(topSpace, bottomSpace);

    // Find best horizontal side
    final bestHorizontalSide = startSpace > endSpace
        ? TooltipCardPlacementSide.start
        : TooltipCardPlacementSide.end;
    final bestHorizontalSpace = math.max(startSpace, endSpace);

    // If preferred is vertical, try vertical first
    if (preferredBase == TooltipCardPlacementSide.top ||
        preferredBase == TooltipCardPlacementSide.bottom) {
      // Check if content fits in best vertical
      if (contentSize.height <= bestVerticalSpace + _epsilon) {
        return bestVerticalSide;
      }
      // Otherwise try best horizontal
      if (contentSize.width <= bestHorizontalSpace + _epsilon) {
        return bestHorizontalSide;
      }
      // Nothing fits perfectly, choose side with most space
      return bestVerticalSpace > bestHorizontalSpace
          ? bestVerticalSide
          : bestHorizontalSide;
    } else {
      // Preferred is horizontal, try horizontal first
      if (contentSize.width <= bestHorizontalSpace + _epsilon) {
        return bestHorizontalSide;
      }
      // Otherwise try best vertical
      if (contentSize.height <= bestVerticalSpace + _epsilon) {
        return bestVerticalSide;
      }
      // Nothing fits perfectly, choose side with most space
      return bestHorizontalSpace > bestVerticalSpace
          ? bestHorizontalSide
          : bestVerticalSide;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PHASE 2: Calculate Beak Position
  // ═══════════════════════════════════════════════════════════════════════════

  /// PHASE 2: Calculates the beak position on the flyout content edge
  ///
  /// The beak position is the coordinate (X for vertical sides, Y for horizontal sides)
  /// where the beak's tip attachment point is located on the content edge.
  ///
  /// Algorithm:
  /// 1. Calculate ideal position (where beak WANTS to be - aligned with target center)
  /// 2. Calculate safe zone boundaries (avoid borderRadius corners)
  /// 3. Clamp beak position to stay within safe zone
  ///
  /// For vertical sides (top/bottom):
  ///   - beakIdealX = targetCenter.dx - flyoutX
  ///   - Safe zone: [borderRadius + beakSize, contentWidth - borderRadius - beakSize]
  ///
  /// For horizontal sides (start/end):
  ///   - beakIdealY = targetCenter.dy - flyoutY
  ///   - Safe zone: [borderRadius + beakSize, contentHeight - borderRadius - beakSize]
  ///
  /// Parameters:
  ///   - side: The selected placement side
  ///   - contentSize: The size of the flyout content
  ///   - flyoutOffset: The position of the flyout content in overlay coordinates
  ///
  /// Returns: The beak position (X for vertical, Y for horizontal) in flyout-local coordinates
  double _calculateBeakPosition(
    TooltipCardPlacementSide side,
    Size contentSize,
    Offset flyoutOffset,
  ) {
    // Safe zone calculation: keep beak away from rounded corners
    final safeZone = _maxCornerRadius + beakSize;

    final isVertical =
        side == TooltipCardPlacementSide.top ||
        side == TooltipCardPlacementSide.bottom;

    if (isVertical) {
      // For vertical placements: calculate X position of beak
      // Ideal: align beak tip with target center horizontally
      final beakIdealX = targetRect.center.dx - flyoutOffset.dx;

      // Safe boundaries: avoid corners
      final beakMinX = safeZone;
      final beakMaxX = contentSize.width - safeZone;

      // Clamp to safe zone
      final beakFinalX = beakIdealX.clamp(beakMinX, beakMaxX);
      return beakFinalX;
    } else {
      // For horizontal placements: calculate Y position of beak
      // Ideal: align beak tip with target center vertically
      final beakIdealY = targetRect.center.dy - flyoutOffset.dy;

      // Safe boundaries: avoid corners
      final beakMinY = safeZone;
      final beakMaxY = contentSize.height - safeZone;

      // Clamp to safe zone
      final beakFinalY = beakIdealY.clamp(beakMinY, beakMaxY);
      return beakFinalY;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PHASE 3: Calculate Flyout Position
  // ═══════════════════════════════════════════════════════════════════════════

  /// PHASE 3: Calculates the flyout content position
  ///
  /// Positions the flyout content such that:
  /// 1. It's on the correct side of the target (with awaySpace + beakSize gap)
  /// 2. The beak points to the target center
  /// 3. Content stays within viewport bounds
  ///
  /// Algorithm for each side:
  ///
  /// Top placement:
  ///   flyoutY = targetRect.top - beakSize - contentHeight - awaySpace
  ///   flyoutX = targetRect.center.dx - beakX
  ///
  /// Bottom placement:
  ///   flyoutY = targetRect.bottom + beakSize + awaySpace
  ///   flyoutX = targetRect.center.dx - beakX
  ///
  /// Start placement (LTR: left side):
  ///   flyoutX = targetRect.left - beakSize - contentWidth - awaySpace
  ///   flyoutY = targetRect.center.dy - beakY
  ///
  /// End placement (LTR: right side):
  ///   flyoutX = targetRect.right + beakSize + awaySpace
  ///   flyoutY = targetRect.center.dy - beakY
  ///
  /// The position is then clamped to viewport boundaries.
  ///
  /// Note: This is called iteratively with beak position calculation because
  /// they depend on each other.
  Offset _calculateFlyoutOffset(
    TooltipCardPlacementSide side,
    Size layoutSize,
    Size contentSize,
  ) {
    // Calculate viewport boundaries
    final viewportMarginLeft = isLTR
        ? viewportMargin.start
        : viewportMargin.end;
    final viewportMarginRight = isLTR
        ? viewportMargin.end
        : viewportMargin.start;
    final double minX = viewportMarginLeft;
    final double maxX =
        layoutSize.width - viewportMarginRight - contentSize.width;
    final double minY = viewportMargin.top;
    final double maxY =
        layoutSize.height - viewportMargin.bottom - contentSize.height;

    double x = 0;
    double y = 0;

    switch (side) {
      case TooltipCardPlacementSide.top:
        // Position above target
        y = targetRect.top - beakSize - contentSize.height - awaySpace;
        // Center horizontally with target (will adjust based on beak later)
        x = targetRect.center.dx - contentSize.width / 2;
        break;

      case TooltipCardPlacementSide.bottom:
        // Position below target
        y = targetRect.bottom + beakSize + awaySpace;
        // Center horizontally with target (will adjust based on beak later)
        x = targetRect.center.dx - contentSize.width / 2;
        break;

      case TooltipCardPlacementSide.start:
        // Position to the start (LTR: left, RTL: right)
        x = _isRTL
            ? targetRect.right + beakSize + awaySpace
            : targetRect.left - beakSize - contentSize.width - awaySpace;
        // Center vertically with target (will adjust based on beak later)
        y = targetRect.center.dy - contentSize.height / 2;
        break;

      case TooltipCardPlacementSide.end:
        // Position to the end (LTR: right, RTL: left)
        x = _isRTL
            ? targetRect.left - beakSize - contentSize.width - awaySpace
            : targetRect.right + beakSize + awaySpace;
        // Center vertically with target (will adjust based on beak later)
        y = targetRect.center.dy - contentSize.height / 2;
        break;

      default:
        break;
    }

    // Apply viewport constraints
    x = x.clamp(minX, maxX);
    y = y.clamp(minY, maxY);

    return Offset(x, y);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Public API
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // Calculate maximum available space considering viewport margins
    double maxW = constraints.biggest.width - viewportMargin.horizontal;
    double maxH = constraints.biggest.height - viewportMargin.vertical;

    // If fitToViewport is enabled, further constrain based on available space
    if (fitToViewport) {
      // Calculate best available space in each dimension
      final topSpace = _calculateTopSpace();
      final bottomSpace = _calculateBottomSpace();
      final startSpace = _calculateStartSpace();
      final endSpace = _calculateEndSpace();

      final bestVerticalSpace = math.max(topSpace, bottomSpace);
      final bestHorizontalSpace = math.max(startSpace, endSpace);

      if (bestVerticalSpace > 0) {
        maxH = math.min(maxH, bestVerticalSpace);
      }
      if (bestHorizontalSpace > 0) {
        maxW = math.min(maxW, bestHorizontalSpace);
      }
    }

    // Apply user constraints if provided
    if (userConstraints != null) {
      if (userConstraints!.maxWidth.isFinite) {
        maxW = math.min(maxW, userConstraints!.maxWidth);
      }
      if (userConstraints!.maxHeight.isFinite) {
        maxH = math.min(maxH, userConstraints!.maxHeight);
      }
    }

    return BoxConstraints(
      minWidth: 0,
      minHeight: 0,
      maxWidth: maxW,
      maxHeight: maxH,
    );
  }

  @override
  Offset getPositionForChild(Size layoutSize, Size contentSize) {
    // ═════════════════════════════════════════════════════════════════════════
    // Execute 3-Phase Sequential Positioning
    // ═════════════════════════════════════════════════════════════════════════

    // PHASE 1: Select the best side based on available space and content size
    final selectedSide = _selectBestSide(contentSize);

    // PHASE 3: Calculate initial flyout position
    // (We do this before Phase 2 because beak position depends on flyout position)
    final flyoutOffset = _calculateFlyoutOffset(
      selectedSide,
      layoutSize,
      contentSize,
    );

    // PHASE 2: Calculate beak position based on flyout position
    final beakPosition = _calculateBeakPosition(
      selectedSide,
      contentSize,
      flyoutOffset,
    );

    // Notify parent of resolved placement and beak position
    // This allows the beak widget to receive the exact calculated position
    onResolvedPlacement(selectedSide, beakPosition);

    // Apply custom offset if specified (Fluent UI feature)
    // This allows fine-tuning the position beyond standard placement modes
    final finalOffset = flyoutOffset + offset;

    return finalOffset;
  }

  @override
  bool shouldRelayout(covariant _TooltipCardPositionDelegate old) {
    return overlaySize != old.overlaySize ||
        targetRect != old.targetRect ||
        awaySpace != old.awaySpace ||
        preferredSide != old.preferredSide ||
        textDirection != old.textDirection ||
        viewportMargin != old.viewportMargin ||
        fitToViewport != old.fitToViewport ||
        autoFlipIfZeroSpace != old.autoFlipIfZeroSpace ||
        userConstraints != old.userConstraints ||
        borderRadius != old.borderRadius ||
        beakSize != old.beakSize ||
        offset != old.offset;
  }
}

class _BeakedTooltipCardPanel extends StatelessWidget {
  const _BeakedTooltipCardPanel({
    required this.fade,
    required this.scale,
    required this.onEscape,
    required this.elevation,
    required this.bg,
    required this.borderRadius,
    required this.child,
    required this.side,
    this.padding,
    this.constraints,
    // beak
    required this.beakEnabled,
    required this.beakSize,
    required this.beakInset,
    required this.beakColor,
    required this.beakPosition,
    required this.targetRect,
    required this.textDirection,
  });

  final Animation<double> fade;
  final Animation<double> scale;
  final VoidCallback onEscape;
  final double elevation;
  final Color bg;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final Widget child;
  final TooltipCardPlacementSide side;

  final bool beakEnabled;
  final double beakSize; // tip to base distance
  final double beakInset; // horizontal inset from start/end if not centered
  final Color beakColor;
  final double beakPosition; // Calculated position from Phase 2
  final Rect targetRect;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    // Extra space reserved for the beak outside the material body
    final baseSide = side.baseSide;
    final double topExtra =
        (beakEnabled && baseSide == TooltipCardPlacementSide.bottom)
        ? beakSize
        : 0;
    final double bottomExtra =
        (beakEnabled && baseSide == TooltipCardPlacementSide.top)
        ? beakSize
        : 0;
    final double leftExtra =
        (beakEnabled && baseSide == TooltipCardPlacementSide.end)
        ? beakSize
        : 0;
    final double rightExtra =
        (beakEnabled && baseSide == TooltipCardPlacementSide.start)
        ? beakSize
        : 0;

    return RepaintBoundary(
      child: FadeTransition(
        opacity: fade,
        child: ScaleTransition(
          scale: scale,
          alignment: _getScaleAlignment(),
          child: Padding(
            // Make room for the beak tip to extend outside without clipping
            padding: EdgeInsets.only(
              top: topExtra,
              bottom: bottomExtra,
              left: leftExtra,
              right: rightExtra,
            ),
            child: LayoutBuilder(
              builder: (context, boxConstraints) {
                return _BeakedPanelWithBeak(
                  baseSide: baseSide,
                  beakEnabled: beakEnabled,
                  beakSize: beakSize,
                  beakColor: beakColor,
                  beakPosition: beakPosition,
                  elevation: elevation,
                  bg: bg,
                  borderRadius: borderRadius,
                  constraints: constraints,
                  padding: padding,
                  onEscape: onEscape,
                  targetRect: targetRect,
                  textDirection: textDirection,
                  child: child,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Gets the appropriate scale alignment based on placement
  Alignment _getScaleAlignment() {
    final baseSide = side.baseSide;
    final horizontalAlign = side.horizontalAlign;
    final verticalAlign = side.verticalAlign;

    // For basic sides, use center alignment
    if (!side.isCompound) {
      switch (baseSide) {
        case TooltipCardPlacementSide.top:
          return Alignment.bottomCenter;
        case TooltipCardPlacementSide.bottom:
          return Alignment.topCenter;
        case TooltipCardPlacementSide.start:
          return Alignment.centerRight;
        case TooltipCardPlacementSide.end:
          return Alignment.centerLeft;
        default:
          return Alignment.center;
      }
    }

    // For compound placements, use more precise alignment
    switch (baseSide) {
      case TooltipCardPlacementSide.top:
        switch (horizontalAlign) {
          case _HorizontalAlign.start:
            return Alignment.bottomLeft;
          case _HorizontalAlign.end:
            return Alignment.bottomRight;
          case _HorizontalAlign.center:
            return Alignment.bottomCenter;
        }
      case TooltipCardPlacementSide.bottom:
        switch (horizontalAlign) {
          case _HorizontalAlign.start:
            return Alignment.topLeft;
          case _HorizontalAlign.end:
            return Alignment.topRight;
          case _HorizontalAlign.center:
            return Alignment.topCenter;
        }
      case TooltipCardPlacementSide.start:
        switch (verticalAlign) {
          case _VerticalAlign.top:
            return Alignment.topRight;
          case _VerticalAlign.bottom:
            return Alignment.bottomRight;
          case _VerticalAlign.center:
            return Alignment.centerRight;
        }
      case TooltipCardPlacementSide.end:
        switch (verticalAlign) {
          case _VerticalAlign.top:
            return Alignment.topLeft;
          case _VerticalAlign.bottom:
            return Alignment.bottomLeft;
          case _VerticalAlign.center:
            return Alignment.centerLeft;
        }
      default:
        return Alignment.center;
    }
  }
}

/// Widget that handles the panel content and beak positioning
/// Uses the beak position calculated from Phase 2 of the positioning system
class _BeakedPanelWithBeak extends StatefulWidget {
  const _BeakedPanelWithBeak({
    required this.baseSide,
    required this.beakEnabled,
    required this.beakSize,
    required this.beakColor,
    required this.beakPosition,
    required this.elevation,
    required this.bg,
    required this.borderRadius,
    required this.constraints,
    required this.padding,
    required this.onEscape,
    required this.targetRect,
    required this.textDirection,
    required this.child,
  });

  final TooltipCardPlacementSide baseSide;
  final bool beakEnabled;
  final double beakSize;
  final Color beakColor;
  final double beakPosition; // Calculated from Phase 2
  final double elevation;
  final Color bg;
  final BorderRadius borderRadius;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onEscape;
  final Rect targetRect;
  final TextDirection textDirection;
  final Widget child;

  @override
  State<_BeakedPanelWithBeak> createState() => _BeakedPanelWithBeakState();
}

class _BeakedPanelWithBeakState extends State<_BeakedPanelWithBeak> {
  final GlobalKey _panelKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Panel body
        _PanelMaterial(
          key: _panelKey,
          elevation: widget.elevation,
          bg: widget.bg,
          borderRadius: widget.borderRadius,
          child: ConstrainedBox(
            constraints:
                widget.constraints ??
                const BoxConstraints(
                  maxWidth: _TooltipCardConstants.defaultMaxWidth,
                ),
            child: Shortcuts(
              shortcuts: const {
                SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
              },
              child: Actions(
                actions: {
                  DismissIntent: CallbackAction<DismissIntent>(
                    onInvoke: (i) {
                      widget.onEscape();
                      return null;
                    },
                  ),
                },
                child: FocusScope(
                  autofocus: true,
                  child: Padding(
                    padding: widget.padding ?? EdgeInsets.zero,
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),

        if (widget.beakEnabled)
          // For vertical placements (top/bottom)
          if (widget.baseSide == TooltipCardPlacementSide.top ||
              widget.baseSide == TooltipCardPlacementSide.bottom)
            Positioned(
              top: widget.baseSide == TooltipCardPlacementSide.bottom
                  ? -widget.beakSize
                  : null,
              bottom: widget.baseSide == TooltipCardPlacementSide.top
                  ? -widget.beakSize
                  : null,
              left: 0,
              right: 0,
              child: RepaintBoundary(
                child: _BeakWithPosition(
                  beakPosition: widget.beakPosition,
                  side: widget.baseSide,
                  size: widget.beakSize,
                  color: widget.beakColor,
                  elevation: widget.elevation,
                  textDirection: widget.textDirection,
                ),
              ),
            )
          // For horizontal placements (start/end)
          else if (widget.baseSide == TooltipCardPlacementSide.start ||
              widget.baseSide == TooltipCardPlacementSide.end)
            PositionedDirectional(
              start: widget.baseSide == TooltipCardPlacementSide.end
                  ? -widget.beakSize
                  : null,
              end: widget.baseSide == TooltipCardPlacementSide.start
                  ? -widget.beakSize
                  : null,
              top: 0,
              bottom: 0,
              child: RepaintBoundary(
                child: _BeakWithPosition(
                  beakPosition: widget.beakPosition,
                  side: widget.baseSide,
                  size: widget.beakSize,
                  color: widget.beakColor,
                  elevation: widget.elevation,
                  textDirection: widget.textDirection,
                ),
              ),
            ),
      ],
    );
  }
}

/// Beak widget that uses the pre-calculated position from Phase 2
/// No complex calculations needed - just renders the beak at the specified position
class _BeakWithPosition extends StatelessWidget {
  const _BeakWithPosition({
    required this.beakPosition,
    required this.side,
    required this.size,
    required this.color,
    required this.elevation,
    required this.textDirection,
  });

  final double
  beakPosition; // Pre-calculated from Phase 2 (X for vertical, Y for horizontal)
  final TooltipCardPlacementSide side;
  final double size;
  final Color color;
  final double elevation;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    // Simply render the beak at the exact position calculated by Phase 2
    // No need for complex RenderBox calculations or global coordinate conversions
    return _Beak(
      side: side,
      size: size,
      color: color,
      elevation: elevation,
      targetCenterPosition: beakPosition,
      textDirection: textDirection,
    );
  }
}

class _PanelMaterial extends StatelessWidget {
  const _PanelMaterial({
    super.key,
    required this.elevation,
    required this.bg,
    required this.borderRadius,
    required this.child,
  });
  final double elevation;
  final Color bg;
  final BorderRadius borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        elevation: elevation,
        color: bg,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        shadowColor: Theme.of(context).shadowColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _TooltipCardSpacing.md,
            vertical: _TooltipCardSpacing.sm,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _Beak extends StatelessWidget {
  const _Beak({
    required this.side,
    required this.size,
    required this.color,
    required this.elevation,
    required this.targetCenterPosition,
    required this.textDirection,
  });
  final TooltipCardPlacementSide side;
  final double size;
  final Color color;
  final double elevation;
  final double
  targetCenterPosition; // X for vertical placements, Y for horizontal
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        // For vertical placements (top/bottom), targetCenterPosition is X
        // For horizontal placements (start/end), targetCenterPosition is Y
        final isVertical =
            side == TooltipCardPlacementSide.top ||
            side == TooltipCardPlacementSide.bottom;

        final canvasSize = isVertical
            ? Size(c.maxWidth, size)
            : Size(size, c.maxHeight);

        return CustomPaint(
          size: canvasSize,
          painter: _BeakPainter(
            position: targetCenterPosition,
            size: size,
            color: color,
            side: side,
            elevation: elevation,
            textDirection: textDirection,
          ),
        );
      },
    );
  }
}

class _BeakPainter extends CustomPainter {
  _BeakPainter({
    required this.position,
    required this.size,
    required this.color,
    required this.side,
    required this.elevation,
    required this.textDirection,
  });
  final double
  position; // x-coordinate for vertical, y-coordinate for horizontal
  final double size;
  final Color color;
  final TooltipCardPlacementSide side;
  final double elevation;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size s) {
    final double halfBase = size; // base width = 2*size
    final bool isRTL = textDirection == TextDirection.rtl;
    final Path path;

    switch (side) {
      case TooltipCardPlacementSide.top:
        // Beak points down from top panel
        // In RTL, mirror the horizontal position
        final double beakX = isRTL ? s.width - position : position;
        final double tipY = s.height; // tip at bottom
        final double baseY = 0; // base at top (panel edge)
        path = Path()
          ..moveTo(beakX - halfBase, baseY)
          ..lineTo(beakX, tipY)
          ..lineTo(beakX + halfBase, baseY)
          ..close();
        break;

      case TooltipCardPlacementSide.bottom:
        // Beak points up from bottom panel
        // In RTL, mirror the horizontal position
        final double beakX = isRTL ? s.width - position : position;
        final double tipY = 0; // tip at top
        final double baseY = s.height; // base at bottom (panel edge)
        path = Path()
          ..moveTo(beakX - halfBase, baseY)
          ..lineTo(beakX, tipY)
          ..lineTo(beakX + halfBase, baseY)
          ..close();
        break;

      case TooltipCardPlacementSide.start:
        // Start side: LTR=left (beak points right), RTL=right (beak points left)
        if (isRTL) {
          // RTL: start is on right side, beak points left
          final double tipX = 0; // tip at left
          final double baseX = s.width; // base at right (panel edge)
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
        } else {
          // LTR: start is on left side, beak points right
          final double tipX = s.width; // tip at right
          final double baseX = 0; // base at left (panel edge)
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
        }
        break;

      case TooltipCardPlacementSide.end:
        // End side: LTR=right (beak points left), RTL=left (beak points right)
        if (isRTL) {
          // RTL: end is on left side, beak points right
          final double tipX = s.width; // tip at right
          final double baseX = 0; // base at left (panel edge)
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
        } else {
          // LTR: end is on right side, beak points left
          final double tipX = 0; // tip at left
          final double baseX = s.width; // base at right (panel edge)
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
        }
        break;

      default:
        // Fallback: draw nothing
        path = Path();
        break;
    }

    // Enhanced shadow with better opacity handling
    final shadowColor = Colors.black.withValues(
      alpha: _TooltipCardConstants.shadowOpacity,
    );
    final effectiveElevation = elevation == 0 ? 1.0 : elevation;
    canvas.drawShadow(path, shadowColor, effectiveElevation, true);

    // Fill with anti-aliasing for smooth edges
    final paint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BeakPainter old) =>
      old.position != position ||
      old.size != size ||
      old.color != color ||
      old.side != side ||
      old.elevation != elevation ||
      old.textDirection != textDirection;
}

// ═══════════════════════════════════════════════════════════════════════════
// TooltipCardContent - TeachingTip Style Structured Content
// ═══════════════════════════════════════════════════════════════════════════

/// A structured content widget for TooltipCard, inspired by Fluent UI's TeachingTip.
///
/// This provides a consistent, professional layout for tooltip content with:
/// - Optional icon/image header
/// - Title and subtitle
/// - Custom content area
/// - Action buttons (primary, secondary, tertiary)
/// - Close button
///
/// Example:
/// ```dart
/// TooltipCard.builder(
///   child: Text('Hover me'),
///   flyoutContentBuilder: (context, close) => TooltipCardContent(
///     icon: Icon(Icons.lightbulb_outline),
///     title: 'Pro Tip',
///     subtitle: 'This feature can save you time',
///     content: Text('Click here to access advanced settings...'),
///     primaryAction: Button(
///       child: Text('Got it'),
///       onPressed: close,
///     ),
///   ),
/// )
/// ```
class TooltipCardContent extends StatelessWidget {
  const TooltipCardContent({
    super.key,
    this.icon,
    this.iconColor,
    this.iconSize = 24.0,
    required this.title,
    this.subtitle,
    this.content,
    this.primaryAction,
    this.secondaryAction,
    this.tertiaryAction,
    this.onClose,
    this.showCloseButton = true,
    this.maxWidth = 360.0,
    this.padding = const EdgeInsets.all(16.0),
    this.spacing = 12.0,
  });

  /// Optional icon displayed at the top of the content
  final Widget? icon;

  /// Color for the icon (if icon is an Icon widget)
  final Color? iconColor;

  /// Size of the icon
  final double iconSize;

  /// Main title text (required)
  final String title;

  /// Optional subtitle/description text
  final String? subtitle;

  /// Optional custom content widget
  final Widget? content;

  /// Primary action button (e.g., "Got it", "Learn More")
  final Widget? primaryAction;

  /// Secondary action button (e.g., "Remind me later")
  final Widget? secondaryAction;

  /// Tertiary action button (e.g., "Don't show again")
  final Widget? tertiaryAction;

  /// Callback when close button is pressed
  final VoidCallback? onClose;

  /// Whether to show the close button
  final bool showCloseButton;

  /// Maximum width of the content
  final double maxWidth;

  /// Padding around the content
  final EdgeInsets padding;

  /// Spacing between sections
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section (Icon + Title + Close)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                if (icon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: iconColor ?? colorScheme.primary,
                      size: iconSize,
                    ),
                    child: icon!,
                  ),
                  SizedBox(width: spacing),
                ],

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),

                // Close button
                if (showCloseButton && onClose != null) ...[
                  SizedBox(width: spacing),
                  InkWell(
                    onTap: onClose,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // Subtitle
            if (subtitle != null) ...[
              SizedBox(height: spacing * 0.5),
              Text(
                subtitle!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],

            // Custom content
            if (content != null) ...[
              SizedBox(height: spacing),
              DefaultTextStyle(
                style:
                    textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.8),
                    ) ??
                    const TextStyle(),
                child: content!,
              ),
            ],

            // Actions
            if (primaryAction != null ||
                secondaryAction != null ||
                tertiaryAction != null) ...[
              SizedBox(height: spacing * 1.5),
              _buildActions(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    final actions = <Widget>[];

    if (primaryAction != null) {
      actions.add(Expanded(child: primaryAction!));
    }

    if (secondaryAction != null) {
      if (actions.isNotEmpty) actions.add(SizedBox(width: spacing * 0.75));
      actions.add(Expanded(child: secondaryAction!));
    }

    if (tertiaryAction != null) {
      if (actions.isNotEmpty) actions.add(SizedBox(width: spacing * 0.75));
      actions.add(tertiaryAction!);
    }

    return Row(mainAxisSize: MainAxisSize.min, children: actions);
  }
}
