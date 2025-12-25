part of 'widgets.dart';

/// Beak widget that uses the pre-calculated position from Phase 2
/// with optional border support
class BeakWidget extends StatelessWidget {
  const BeakWidget({
    super.key,
    required this.beakPosition,
    required this.side,
    required this.size,
    required this.color,
    required this.textDirection,
    this.borderColor,
    this.borderWidth = 0.0,
  });

  /// Pre-calculated from Phase 2 (X for vertical, Y for horizontal)
  final double beakPosition;
  final TooltipCardPlacementSide side;
  final double size;
  final Color color;
  final TextDirection textDirection;

  /// Optional border color for the beak
  final Color? borderColor;

  /// Border width (0 = no border)
  final double borderWidth;

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
            textDirection: textDirection,
            borderColor: borderColor,
            borderWidth: borderWidth,
          ),
        );
      },
    );
  }
}
