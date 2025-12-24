part of 'painters.dart';

/// Custom painter for the beak (arrow/caret) of the tooltip
class BeakPainter extends CustomPainter {
  BeakPainter({
    required this.position,
    required this.size,
    required this.color,
    required this.side,
    required this.elevation,
    required this.textDirection,
  });

  /// x-coordinate for vertical placements, y-coordinate for horizontal
  final double position;
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
        final double beakX = isRTL ? s.width - position : position;
        final double tipY = s.height;
        final double baseY = 0;
        path = Path()
          ..moveTo(beakX - halfBase, baseY)
          ..lineTo(beakX, tipY)
          ..lineTo(beakX + halfBase, baseY)
          ..close();
        break;

      case TooltipCardPlacementSide.bottom:
        // Beak points up from bottom panel
        final double beakX = isRTL ? s.width - position : position;
        final double tipY = 0;
        final double baseY = s.height;
        path = Path()
          ..moveTo(beakX - halfBase, baseY)
          ..lineTo(beakX, tipY)
          ..lineTo(beakX + halfBase, baseY)
          ..close();
        break;

      case TooltipCardPlacementSide.start:
        // Start side: LTR=left (beak points right), RTL=right (beak points left)
        if (isRTL) {
          final double tipX = 0;
          final double baseX = s.width;
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
        } else {
          final double tipX = s.width;
          final double baseX = 0;
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
          final double tipX = s.width;
          final double baseX = 0;
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
        } else {
          final double tipX = 0;
          final double baseX = s.width;
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
        }
        break;

      default:
        path = Path();
        break;
    }

    // Enhanced shadow with better opacity handling
    final shadowColor = Colors.black.withValues(
      alpha: TooltipCardConstants.shadowOpacity,
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
  bool shouldRepaint(covariant BeakPainter old) =>
      old.position != position ||
      old.size != size ||
      old.color != color ||
      old.side != side ||
      old.elevation != elevation ||
      old.textDirection != textDirection;
}
