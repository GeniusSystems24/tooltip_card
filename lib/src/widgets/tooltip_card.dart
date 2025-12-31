// TooltipCard — Fluent Beak/Callout (v5.5.0 - Animations & Data)
// -----------------------------------------------------------------
// Enhanced Fluent-style tooltip with comprehensive improvements:
//
// ✨ Performance:
//   • Optimized rebuilds with const constructors
//   • RepaintBoundary for independent widgets
//   • Reduced redundant calculations
//   • 3-phase sequential positioning system
//
// 🎬 Animations (v2.6.0):
//   • 9 animation types: fade, scale, fadeScale, slideIn, slideFade,
//     bounce, elastic, zoom, none
//   • Direction-aware slide animations
//   • Spring-based bounce and elastic effects
//   • Customizable per-tooltip animation
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
// 📱 Touch-Friendly (v2.5.0):
//   • Long press trigger for touch screens
//   • Long press up trigger for touch interaction
//   • Force press (3D Touch) support for iOS
//
// 🔄 Controller Data (v2.6.0):
//   • Pass data when opening: controller.open(data: 'user')
//   • Access data in builder: controller.data, controller.dataAs<T>()
//   • Dynamic content based on passed data
//
// 🚀 Core Features:
//   • RTL-aware positioning
//   • Beak/caret with shadow matching panel
//   • Viewport-fit with auto-flip and smart placement
//   • Modal scrim with blur support
//   • 7 trigger modes (press/hover/double-tap/right-click/long-press/force-press)
//   • Builder API with close callback

part of 'widgets.dart';

/// A powerful, customizable tooltip widget with Fluent UI inspired design.
///
/// Features:
/// - 7 trigger modes: press, hover, double-tap, right-click, long-press,
///   long-press-up, and force-press (3D Touch)
/// - 9 animation types: fade, scale, fadeScale, slideIn, slideFade,
///   bounce, elastic, zoom, none
/// - Controller with data passing for dynamic content
/// - Touch-friendly triggers for mobile devices
/// - Smart positioning with auto-flip
/// - Beak/arrow pointing to trigger
/// - Modal barrier support with blur
/// - Full Material 3 theming support
/// - RTL aware positioning
///
/// Example:
/// ```dart
/// TooltipCard.builder(
///   beakEnabled: true,
///   placementSide: TooltipCardPlacementSide.bottom,
///   whenContentVisible: WhenContentVisible.pressButton,
///   builder: (ctx, close) => TooltipCardContent(
///     icon: const Icon(Icons.lightbulb_outline),
///     title: 'Pro Tip',
///     subtitle: 'This feature can save you time',
///     primaryAction: FilledButton(
///       onPressed: close,
///       child: const Text('Got it'),
///     ),
///     onClose: close,
///   ),
///   child: const Text('Hover me'),
/// )
/// ```
class TooltipCard extends StatefulWidget {
  /// Creates a TooltipCard with a builder function for dynamic content.
  ///
  /// The [builder] receives the build context and a close callback.
  const TooltipCard.builder({
    super.key,
    required this.child,
    required this.builder,
    this.whenContentHide = WhenContentHide.goAway,
    this.whenContentVisible = WhenContentVisible.pressButton,
    this.hoverOpenDelay = TooltipCardTiming.hoverOpenDelay,
    this.hoverCloseDelay = TooltipCardTiming.hoverCloseDelay,
    this.awaySpace = 0.0,
    this.placementSide = TooltipCardPlacementSide.top,
    this.flyoutBackgroundColor,
    this.elevation = TooltipCardConstants.defaultElevation,
    this.borderRadius = TooltipCardConstants.defaultBorderRadius,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.constraints,
    this.onOpenChanged,
    this.onOpen,
    this.onClose,
    this.useRootOverlay = true,
    this.publicState,
    // Viewport-fit
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
    this.beakSize = TooltipCardConstants.defaultBeakSize,
    this.beakInset = TooltipCardConstants.defaultBeakInset,
    this.beakColor,
    // Border
    this.borderColor,
    this.borderWidth = 0.0,
    // Animation
    this.animation = TooltipCardAnimation.fadeScale,
  }) : flyoutContent = null;

  /// Creates a TooltipCard with static content.
  const TooltipCard({
    super.key,
    required this.child,
    required this.flyoutContent,
    this.controller,
    this.whenContentHide = WhenContentHide.goAway,
    this.whenContentVisible = WhenContentVisible.pressButton,
    this.hoverOpenDelay = const Duration(milliseconds: 300),
    this.hoverCloseDelay = const Duration(milliseconds: 300),
    this.awaySpace = 8.0,
    this.placementSide = TooltipCardPlacementSide.bottom,
    this.flyoutBackgroundColor,
    this.elevation = TooltipCardConstants.defaultElevation,
    this.borderRadius = TooltipCardConstants.defaultBorderRadius,
    this.padding = EdgeInsets.zero,
    this.constraints,
    this.onOpenChanged,
    this.onOpen,
    this.onClose,
    this.useRootOverlay = true,
    this.publicState,
    // Viewport-fit
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
    this.beakSize = TooltipCardConstants.defaultBeakSize,
    this.beakInset = 20,
    this.beakColor,
    // Border
    this.borderColor,
    this.borderWidth = 0.0,
    // Animation
    this.animation = TooltipCardAnimation.fadeScale,
  }) : builder = null;

  /// Static content widget to display in the tooltip
  final Widget? flyoutContent;

  /// Builder function for dynamic content
  final Widget Function(BuildContext context, VoidCallback close)? builder;

  /// The widget that triggers the tooltip
  final Widget child;

  /// How the tooltip is hidden
  final WhenContentHide whenContentHide;

  /// How the tooltip is shown
  final WhenContentVisible whenContentVisible;

  /// Delay before opening on hover
  final Duration hoverOpenDelay;

  /// Delay before closing after hover leaves
  final Duration hoverCloseDelay;

  /// Space between the trigger and tooltip
  final double awaySpace;

  /// Preferred placement side
  final TooltipCardPlacementSide placementSide;

  /// Background color of the tooltip
  final Color? flyoutBackgroundColor;

  /// Elevation for shadow
  final double elevation;

  /// Border radius of the tooltip
  final BorderRadius borderRadius;

  /// Padding inside the tooltip
  final EdgeInsetsGeometry? padding;

  /// Size constraints for the tooltip
  final BoxConstraints? constraints;

  /// Controller for programmatic control
  final TooltipCardController? controller;

  /// Callback when open state changes
  final ValueChanged<bool>? onOpenChanged;

  /// Callback when tooltip opens
  final VoidCallback? onOpen;

  /// Callback when tooltip closes
  final VoidCallback? onClose;

  /// Whether to use the root overlay
  final bool useRootOverlay;

  /// Public state for single-open management
  final TooltipCardPublicState? publicState;

  // Viewport-fit options

  /// Whether to fit content within viewport
  final bool fitToViewport;

  /// Margin from viewport edges
  final EdgeInsetsDirectional viewportMargin;

  /// Whether to auto-flip if no space
  final bool autoFlipIfZeroSpace;

  /// Whether to wrap content in scroll view
  final bool wrapContentInScrollView;

  // Modal scrim options

  /// Whether to show modal barrier
  final bool modalBarrierEnabled;

  /// Color of the barrier
  final Color? barrierColor;

  /// Blur amount for barrier
  final double barrierBlur;

  /// Whether barrier tap dismisses tooltip
  final bool? barrierDismissible;

  // Fluent UI inspired features

  /// Auto-close when pointer moves away
  final bool dismissOnPointerMoveAway;

  /// Duration before auto-close
  final Duration? showDuration;

  /// Custom offset for positioning
  final Offset offset;

  // Beak options

  /// Whether to show the beak
  final bool beakEnabled;

  /// Size of the beak
  final double beakSize;

  /// Inset of the beak from edge
  final double beakInset;

  /// Color of the beak
  final Color? beakColor;

  // Border options

  /// Optional border color for both panel and beak
  final Color? borderColor;

  /// Border width (0 = no border)
  final double borderWidth;

  // Animation

  /// Animation style for tooltip appearance
  ///
  /// Defaults to [TooltipCardAnimation.fadeScale] which combines
  /// fade and scale for a polished effect.
  final TooltipCardAnimation animation;

  @override
  State<TooltipCard> createState() => _TooltipCardState();
}

class _TooltipCardState extends State<TooltipCard>
    with TickerProviderStateMixin {
  final GlobalKey _targetKey = GlobalKey();
  OverlayEntry? _barrierEntry;
  OverlayEntry? _panelEntry;
  late final TooltipCardController _controller =
      widget.controller ?? TooltipCardController();
  late final TooltipCardPublicState _public =
      widget.publicState ?? TooltipCardPublicState.global;

  late TooltipCardPlacementSide _resolvedSide;
  double _resolvedBeakPosition = 0.0;

  late AnimationController _anim;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<Offset> _slide;
  bool _hoverTarget = false;
  bool _hoverPanel = false;
  Timer? _hoverTimer;
  Timer? _showDurationTimer;
  Ticker? _repositionTicker;

  bool get _isPressLike =>
      widget.whenContentVisible == WhenContentVisible.pressButton ||
      widget.whenContentVisible == WhenContentVisible.doubleTapButton ||
      widget.whenContentVisible == WhenContentVisible.secondaryTapButton ||
      widget.whenContentVisible == WhenContentVisible.longPressButton ||
      widget.whenContentVisible == WhenContentVisible.longPressUpButton ||
      widget.whenContentVisible == WhenContentVisible.forcePressButton;

  bool get _shouldAutoCloseOnHoverOut {
    // When modal barrier is enabled, don't auto-close on hover out
    // The user must explicitly close it (via close button, barrier tap, or ESC)
    if (widget.modalBarrierEnabled) return false;

    return widget.whenContentVisible == WhenContentVisible.hoverButton ||
        (_isPressLike && widget.whenContentHide == WhenContentHide.goAway) ||
        widget.dismissOnPointerMoveAway;
  }

  @override
  void initState() {
    super.initState();
    _resolvedSide = widget.placementSide;
    _anim = AnimationController(
      vsync: this,
      duration: _getAnimationDuration(),
      reverseDuration: TooltipCardTiming.exitDuration,
    );
    _setupAnimations();
    _controller.addListener(_handleControllerChange);
  }

  Duration _getAnimationDuration() {
    switch (widget.animation) {
      case TooltipCardAnimation.none:
        return Duration.zero;
      case TooltipCardAnimation.bounce:
      case TooltipCardAnimation.elastic:
        return const Duration(milliseconds: 400);
      case TooltipCardAnimation.zoom:
        return const Duration(milliseconds: 300);
      default:
        return TooltipCardTiming.enterDuration;
    }
  }

  void _setupAnimations() {
    // Fade animation
    _fade = CurvedAnimation(
      parent: _anim,
      curve: TooltipCardCurves.fade,
      reverseCurve: TooltipCardCurves.fadeOut,
    );

    // Scale animation based on type
    final (scaleBegin, scaleCurve, scaleReverseCurve) = _getScaleConfig();
    _scale = Tween<double>(begin: scaleBegin, end: 1.0).animate(
      CurvedAnimation(
        parent: _anim,
        curve: scaleCurve,
        reverseCurve: scaleReverseCurve,
      ),
    );

    // Slide animation
    _slide = Tween<Offset>(begin: _getSlideOffset(), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _anim,
        curve: TooltipCardCurves.slideIn,
        reverseCurve: TooltipCardCurves.slideOut,
      ),
    );
  }

  (double, Curve, Curve) _getScaleConfig() {
    switch (widget.animation) {
      case TooltipCardAnimation.scale:
      case TooltipCardAnimation.fadeScale:
        return (0.88, TooltipCardCurves.scaleIn, TooltipCardCurves.scaleOut);
      case TooltipCardAnimation.bounce:
        return (0.5, TooltipCardCurves.bounce, TooltipCardCurves.scaleOut);
      case TooltipCardAnimation.elastic:
        return (0.6, TooltipCardCurves.elastic, TooltipCardCurves.scaleOut);
      case TooltipCardAnimation.zoom:
        return (0.3, TooltipCardCurves.zoom, TooltipCardCurves.zoomOut);
      case TooltipCardAnimation.fade:
      case TooltipCardAnimation.slideIn:
      case TooltipCardAnimation.slideFade:
      case TooltipCardAnimation.none:
        return (1.0, Curves.linear, Curves.linear);
    }
  }

  Offset _getSlideOffset() {
    const slideAmount = 0.1;
    switch (_resolvedSide) {
      case TooltipCardPlacementSide.top:
      case TooltipCardPlacementSide.topStart:
      case TooltipCardPlacementSide.topEnd:
        return const Offset(0, slideAmount);
      case TooltipCardPlacementSide.bottom:
      case TooltipCardPlacementSide.bottomStart:
      case TooltipCardPlacementSide.bottomEnd:
        return const Offset(0, -slideAmount);
      case TooltipCardPlacementSide.start:
      case TooltipCardPlacementSide.startTop:
      case TooltipCardPlacementSide.startBottom:
        return const Offset(slideAmount, 0);
      case TooltipCardPlacementSide.end:
      case TooltipCardPlacementSide.endTop:
      case TooltipCardPlacementSide.endBottom:
        return const Offset(-slideAmount, 0);
    }
  }

  @override
  void didUpdateWidget(covariant TooltipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.placementSide != widget.placementSide ||
        oldWidget.animation != widget.animation) {
      _resolvedSide = widget.placementSide;
      _setupAnimations();
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
      _public.registerOpen(_controller);
      _showTooltipCard();
    } else {
      _hideTooltipCard();
      _public.registerClose(_controller);
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
        _setupAnimations();
      });
    });
  }

  void _showTooltipCard() {
    if (_panelEntry != null) return;
    final overlay = Overlay.of(context, rootOverlay: widget.useRootOverlay);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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

        final BuildContext scopedContext = _targetKey.currentContext ?? context;
        Widget builtChild = widget.builder != null
            ? widget.builder!(scopedContext, _controller.close)
            : widget.flyoutContent!;
        if (widget.wrapContentInScrollView) {
          builtChild = SingleChildScrollView(primary: false, child: builtChild);
        }

        return CustomSingleChildLayout(
          delegate: TooltipCardPositionDelegate(
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
              child: BeakedTooltipCardPanel(
                fade: _fade,
                scale: _scale,
                slide: _slide,
                animation: widget.animation,
                onEscape: _controller.close,
                elevation: widget.elevation,
                backgroundColor: _getPanelBackgroundColor(theme),
                borderRadius: widget.borderRadius,
                padding: widget.padding,
                constraints: widget.constraints,
                beakEnabled: widget.beakEnabled,
                beakSize: widget.beakSize,
                beakInset: widget.beakInset,
                beakColor: widget.beakColor ?? _getPanelBackgroundColor(theme),
                beakPosition: _resolvedBeakPosition,
                side: _resolvedSide,
                textDirection: Directionality.of(context),
                borderColor: widget.borderColor,
                borderWidth: widget.borderWidth,
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

    widget.onOpenChanged?.call(true);
    widget.onOpen?.call();

    if (widget.showDuration != null) {
      _showDurationTimer?.cancel();
      _showDurationTimer = Timer(widget.showDuration!, () {
        if (!mounted) return;
        _controller.close();
      });
    }

    _startTicker();
  }

  Future<void> _hideTooltipCard() async {
    if (_panelEntry == null) return;

    _showDurationTimer?.cancel();

    try {
      await _anim.reverse();
    } finally {
      _stopTicker();
      _removeEntries();

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

  Color _getPanelBackgroundColor(ThemeData theme) {
    if (widget.flyoutBackgroundColor != null) {
      return widget.flyoutBackgroundColor!;
    }

    final colorScheme = theme.colorScheme;
    return theme.brightness == Brightness.dark
        ? colorScheme.surfaceContainerHigh
        : colorScheme.surface;
  }

  String _getSemanticLabel() {
    const baseLabel = 'Tooltip trigger';
    final state = _controller.isOpen ? 'expanded' : 'collapsed';
    return '$baseLabel, $state';
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.flyoutContent != null || widget.builder != null,
      'Either flyoutContent or builder must be provided',
    );

    final buttonVisual = widget.child;

    final target = Semantics(
      button: true,
      enabled: true,
      expanded: _controller.isOpen,
      label: _getSemanticLabel(),
      child: GestureDetector(
        onTap: (widget.whenContentVisible == WhenContentVisible.pressButton)
            ? _toggleFromPressLike
            : null,
        onDoubleTap:
            (widget.whenContentVisible == WhenContentVisible.doubleTapButton)
                ? _toggleFromPressLike
                : null,
        onSecondaryTap:
            (widget.whenContentVisible == WhenContentVisible.secondaryTapButton)
                ? _toggleFromPressLike
                : null,
        onLongPress:
            (widget.whenContentVisible == WhenContentVisible.longPressButton)
                ? _toggleFromPressLike
                : null,
        onLongPressUp:
            (widget.whenContentVisible == WhenContentVisible.longPressUpButton)
                ? _toggleFromPressLike
                : null,
        onForcePressStart:
            (widget.whenContentVisible == WhenContentVisible.forcePressButton)
                ? (_) => _toggleFromPressLike()
                : null,
        behavior: HitTestBehavior.opaque,
        child: Focus(
          onKeyEvent: (node, event) {
            if (_controller.isOpen &&
                event.logicalKey == LogicalKeyboardKey.escape) {
              _controller.close();
              return KeyEventResult.handled;
            }
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
        if (widget.whenContentVisible == WhenContentVisible.hoverButton) {
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
}
