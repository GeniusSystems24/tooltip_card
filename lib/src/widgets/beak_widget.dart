part of 'widgets.dart';

/// Beak widget that uses the pre-calculated position from Phase 2
class BeakWidget extends StatelessWidget {
  const BeakWidget({
    super.key,
    required this.beakPosition,
    required this.side,
    required this.size,
    required this.color,
    required this.elevation,
    required this.textDirection,
  });

  /// Pre-calculated from Phase 2 (X for vertical, Y for horizontal)
  final double beakPosition;
  final TooltipCardPlacementSide side;
  final double size;
  final Color color;
  final double elevation;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isVertical =
            side == TooltipCardPlacementSide.top ||
            side == TooltipCardPlacementSide.bottom;

        final canvasSize = isVertical
            ? Size(c.maxWidth, size)
            : Size(size, c.maxHeight);

        return CustomPaint(
          size: canvasSize,
          painter: BeakPainter(
            position: beakPosition,
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
