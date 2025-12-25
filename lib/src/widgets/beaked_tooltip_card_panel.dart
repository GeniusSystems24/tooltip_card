part of 'widgets.dart';

/// Wrapper for tooltip panel with animations
/// with optional border support
class BeakedTooltipCardPanel extends StatelessWidget {
  const BeakedTooltipCardPanel({
    super.key,
    required this.fade,
    required this.scale,
    required this.onEscape,
    required this.elevation,
    required this.backgroundColor,
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
    required this.textDirection,
    // border
    this.borderColor,
    this.borderWidth = 0.0,
  });

  final Animation<double> fade;
  final Animation<double> scale;
  final VoidCallback onEscape;
  final double elevation;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final Widget child;
  final TooltipCardPlacementSide side;

  final bool beakEnabled;
  final double beakSize;
  final double beakInset;
  final Color beakColor;
  final double beakPosition;
  final TextDirection textDirection;

  /// Optional border color
  final Color? borderColor;

  /// Border width (0 = no border)
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.only(
              top: topExtra,
              bottom: bottomExtra,
              left: leftExtra,
              right: rightExtra,
            ),
            child: LayoutBuilder(
              builder: (context, boxConstraints) {
                return BeakedPanelWithBeak(
                  baseSide: baseSide,
                  beakEnabled: beakEnabled,
                  beakSize: beakSize,
                  beakColor: beakColor,
                  beakPosition: beakPosition,
                  elevation: elevation,
                  backgroundColor: backgroundColor,
                  borderRadius: borderRadius,
                  constraints: constraints,
                  padding: padding,
                  onEscape: onEscape,
                  textDirection: textDirection,
                  borderColor: borderColor,
                  borderWidth: borderWidth,
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

    switch (baseSide) {
      case TooltipCardPlacementSide.top:
        switch (horizontalAlign) {
          case HorizontalAlign.start:
            return Alignment.bottomLeft;
          case HorizontalAlign.end:
            return Alignment.bottomRight;
          case HorizontalAlign.center:
            return Alignment.bottomCenter;
        }
      case TooltipCardPlacementSide.bottom:
        switch (horizontalAlign) {
          case HorizontalAlign.start:
            return Alignment.topLeft;
          case HorizontalAlign.end:
            return Alignment.topRight;
          case HorizontalAlign.center:
            return Alignment.topCenter;
        }
      case TooltipCardPlacementSide.start:
        switch (verticalAlign) {
          case VerticalAlign.top:
            return Alignment.topRight;
          case VerticalAlign.bottom:
            return Alignment.bottomRight;
          case VerticalAlign.center:
            return Alignment.centerRight;
        }
      case TooltipCardPlacementSide.end:
        switch (verticalAlign) {
          case VerticalAlign.top:
            return Alignment.topLeft;
          case VerticalAlign.bottom:
            return Alignment.bottomLeft;
          case VerticalAlign.center:
            return Alignment.centerLeft;
        }
      default:
        return Alignment.center;
    }
  }
}
