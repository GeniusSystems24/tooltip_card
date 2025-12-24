part of 'widgets.dart';

/// Widget that handles the panel content and beak positioning
class BeakedPanelWithBeak extends StatelessWidget {
  const BeakedPanelWithBeak({
    super.key,
    required this.baseSide,
    required this.beakEnabled,
    required this.beakSize,
    required this.beakColor,
    required this.beakPosition,
    required this.elevation,
    required this.backgroundColor,
    required this.borderRadius,
    required this.constraints,
    required this.padding,
    required this.onEscape,
    required this.textDirection,
    required this.child,
  });

  final TooltipCardPlacementSide baseSide;
  final bool beakEnabled;
  final double beakSize;
  final Color beakColor;
  final double beakPosition;
  final double elevation;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onEscape;
  final TextDirection textDirection;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Panel body
        PanelMaterial(
          elevation: elevation,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          child: ConstrainedBox(
            constraints:
                constraints ??
                const BoxConstraints(
                  maxWidth: TooltipCardConstants.defaultMaxWidth,
                ),
            child: Shortcuts(
              shortcuts: const {
                SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
              },
              child: Actions(
                actions: {
                  DismissIntent: CallbackAction<DismissIntent>(
                    onInvoke: (i) {
                      onEscape();
                      return null;
                    },
                  ),
                },
                child: FocusScope(
                  autofocus: true,
                  child: Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Beak for vertical placements (top/bottom)
        if (beakEnabled &&
            (baseSide == TooltipCardPlacementSide.top ||
                baseSide == TooltipCardPlacementSide.bottom))
          Positioned(
            top: baseSide == TooltipCardPlacementSide.bottom ? -beakSize : null,
            bottom: baseSide == TooltipCardPlacementSide.top ? -beakSize : null,
            left: 0,
            right: 0,
            child: RepaintBoundary(
              child: BeakWidget(
                beakPosition: beakPosition,
                side: baseSide,
                size: beakSize,
                color: beakColor,
                elevation: elevation,
                textDirection: textDirection,
              ),
            ),
          ),

        // Beak for horizontal placements (start/end)
        if (beakEnabled &&
            (baseSide == TooltipCardPlacementSide.start ||
                baseSide == TooltipCardPlacementSide.end))
          PositionedDirectional(
            start: baseSide == TooltipCardPlacementSide.end ? -beakSize : null,
            end: baseSide == TooltipCardPlacementSide.start ? -beakSize : null,
            top: 0,
            bottom: 0,
            child: RepaintBoundary(
              child: BeakWidget(
                beakPosition: beakPosition,
                side: baseSide,
                size: beakSize,
                color: beakColor,
                elevation: elevation,
                textDirection: textDirection,
              ),
            ),
          ),
      ],
    );
  }
}
