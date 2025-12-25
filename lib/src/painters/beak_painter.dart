part of 'painters.dart';

/// Custom painter for the beak (arrow/caret) of the tooltip
/// with enhanced shadow direction and optional border support
class BeakPainter extends CustomPainter {
  BeakPainter({
    required this.position,
    required this.size,
    required this.color,
    required this.side,
    required this.elevation,
    required this.textDirection,
    this.borderColor,
    this.borderWidth = 0.0,
  });

  /// x-coordinate for vertical placements, y-coordinate for horizontal
  final double position;
  final double size;
  final Color color;
  final TooltipCardPlacementSide side;
  final double elevation;
  final TextDirection textDirection;

  /// Optional border color for the beak
  final Color? borderColor;

  /// Border width (0 = no border)
  final double borderWidth;

  @override
  void paint(Canvas canvas, Size s) {
    final double halfBase = size; // base width = 2*size
    final bool isRTL = textDirection == TextDirection.rtl;
    final Path path;

    // Calculate shadow offset based on beak direction for realistic shadows
    Offset shadowOffset;

    switch (side) {
      case TooltipCardPlacementSide.top:
        // Beak points down from top panel - shadow goes down-right
        final double beakX = isRTL ? s.width - position : position;
        final double tipY = s.height;
        final double baseY = 0;
        path = Path()
          ..moveTo(beakX - halfBase, baseY)
          ..lineTo(beakX, tipY)
          ..lineTo(beakX + halfBase, baseY)
          ..close();
        shadowOffset = Offset(elevation * 0.3, elevation * 0.5);
        break;

      case TooltipCardPlacementSide.bottom:
        // Beak points up from bottom panel - shadow goes down-right (but beak is inverted)
        final double beakX = isRTL ? s.width - position : position;
        final double tipY = 0;
        final double baseY = s.height;
        path = Path()
          ..moveTo(beakX - halfBase, baseY)
          ..lineTo(beakX, tipY)
          ..lineTo(beakX + halfBase, baseY)
          ..close();
        shadowOffset = Offset(elevation * 0.3, -elevation * 0.3);
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
          shadowOffset = Offset(-elevation * 0.3, elevation * 0.3);
        } else {
          final double tipX = s.width;
          final double baseX = 0;
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
          shadowOffset = Offset(elevation * 0.5, elevation * 0.3);
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
          shadowOffset = Offset(elevation * 0.5, elevation * 0.3);
        } else {
          final double tipX = 0;
          final double baseX = s.width;
          path = Path()
            ..moveTo(baseX, position - halfBase)
            ..lineTo(tipX, position)
            ..lineTo(baseX, position + halfBase)
            ..close();
          shadowOffset = Offset(-elevation * 0.3, elevation * 0.3);
        }
        break;

      default:
        path = Path();
        shadowOffset = Offset.zero;
        break;
    }

    // Draw directional shadow layers for realistic depth effect
    if (elevation > 0) {
      _drawDirectionalShadow(canvas, path, shadowOffset);
    }

    // Fill with anti-aliasing for smooth edges
    final fillPaint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Draw border if specified
    if (borderColor != null && borderWidth > 0) {
      _drawBorder(canvas, path);
    }
  }

  /// Draws a multi-layer directional shadow for realistic depth
  void _drawDirectionalShadow(Canvas canvas, Path path, Offset direction) {
    final int shadowLayers = 3;
    final double baseOpacity = TooltipCardConstants.shadowOpacity;

    for (int i = shadowLayers; i >= 1; i--) {
      final double factor = i / shadowLayers;
      final double blur = elevation * factor * 1.5;
      final double opacity = baseOpacity * (1 - factor * 0.6);

      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: opacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur)
        ..isAntiAlias = true;

      final offsetPath = path.shift(direction * factor);
      canvas.drawPath(offsetPath, shadowPaint);
    }
  }

  /// Draws border along the visible edges of the beak
  void _drawBorder(Canvas canvas, Path path) {
    final borderPaint = Paint()
      ..color = borderColor!
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.round;

    // Draw only the outer edges (excluding the base that connects to panel)
    final Path borderPath = _createBorderPath();
    canvas.drawPath(borderPath, borderPaint);
  }

  /// Creates a path for just the visible border edges (not the base)
  Path _createBorderPath() {
    final double halfBase = size;
    final bool isRTL = textDirection == TextDirection.rtl;

    switch (side) {
      case TooltipCardPlacementSide.top:
        final double beakX = isRTL ? 0 : position; // Will be adjusted in paint
        return Path()
          ..moveTo(beakX - halfBase, 0)
          ..lineTo(beakX, size)
          ..lineTo(beakX + halfBase, 0);

      case TooltipCardPlacementSide.bottom:
        final double beakX = isRTL ? 0 : position;
        return Path()
          ..moveTo(beakX - halfBase, size)
          ..lineTo(beakX, 0)
          ..lineTo(beakX + halfBase, size);

      case TooltipCardPlacementSide.start:
        if (isRTL) {
          return Path()
            ..moveTo(size, position - halfBase)
            ..lineTo(0, position)
            ..lineTo(size, position + halfBase);
        } else {
          return Path()
            ..moveTo(0, position - halfBase)
            ..lineTo(size, position)
            ..lineTo(0, position + halfBase);
        }

      case TooltipCardPlacementSide.end:
        if (isRTL) {
          return Path()
            ..moveTo(0, position - halfBase)
            ..lineTo(size, position)
            ..lineTo(0, position + halfBase);
        } else {
          return Path()
            ..moveTo(size, position - halfBase)
            ..lineTo(0, position)
            ..lineTo(size, position + halfBase);
        }

      default:
        return Path();
    }
  }

  @override
  bool shouldRepaint(covariant BeakPainter old) =>
      old.position != position ||
      old.size != size ||
      old.color != color ||
      old.side != side ||
      old.elevation != elevation ||
      old.textDirection != textDirection ||
      old.borderColor != borderColor ||
      old.borderWidth != borderWidth;
}
