part of 'delegates.dart';

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
class TooltipCardPositionDelegate extends SingleChildLayoutDelegate {
  TooltipCardPositionDelegate({
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

  /// Use shared constant for precision calculations
  static const double _epsilon = TooltipCardConstants.positionEpsilon;

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
  double get _maxCornerRadius {
    final topLeft = borderRadius.topLeft;
    return math.max(topLeft.x, topLeft.y);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PHASE 1: Select Best Side
  // ═══════════════════════════════════════════════════════════════════════════

  /// Calculates available space in the top direction
  double _calculateTopSpace() {
    return math.max(
      0,
      targetRect.top - viewportMargin.top - beakSize - awaySpace,
    );
  }

  /// Calculates available space in the bottom direction
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
  TooltipCardPlacementSide _selectBestSide(Size contentSize) {
    final topSpace = _calculateTopSpace();
    final bottomSpace = _calculateBottomSpace();
    final startSpace = _calculateStartSpace();
    final endSpace = _calculateEndSpace();

    final preferredBase = preferredSide.baseSide;

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

    if (fitsInPreferred) {
      return preferredBase;
    }

    final bestVerticalSide = topSpace > bottomSpace
        ? TooltipCardPlacementSide.top
        : TooltipCardPlacementSide.bottom;
    final bestVerticalSpace = math.max(topSpace, bottomSpace);

    final bestHorizontalSide = startSpace > endSpace
        ? TooltipCardPlacementSide.start
        : TooltipCardPlacementSide.end;
    final bestHorizontalSpace = math.max(startSpace, endSpace);

    if (preferredBase == TooltipCardPlacementSide.top ||
        preferredBase == TooltipCardPlacementSide.bottom) {
      if (contentSize.height <= bestVerticalSpace + _epsilon) {
        return bestVerticalSide;
      }
      if (contentSize.width <= bestHorizontalSpace + _epsilon) {
        return bestHorizontalSide;
      }
      return bestVerticalSpace > bestHorizontalSpace
          ? bestVerticalSide
          : bestHorizontalSide;
    } else {
      if (contentSize.width <= bestHorizontalSpace + _epsilon) {
        return bestHorizontalSide;
      }
      if (contentSize.height <= bestVerticalSpace + _epsilon) {
        return bestVerticalSide;
      }
      return bestHorizontalSpace > bestVerticalSpace
          ? bestHorizontalSide
          : bestVerticalSide;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PHASE 2: Calculate Beak Position
  // ═══════════════════════════════════════════════════════════════════════════

  /// PHASE 2: Calculates the beak position on the flyout content edge
  double _calculateBeakPosition(
    TooltipCardPlacementSide side,
    Size contentSize,
    Offset flyoutOffset,
  ) {
    final safeZone = _maxCornerRadius + beakSize;

    final isVertical =
        side == TooltipCardPlacementSide.top ||
        side == TooltipCardPlacementSide.bottom;

    if (isVertical) {
      final beakIdealX = targetRect.center.dx - flyoutOffset.dx;
      final beakMinX = safeZone;
      final beakMaxX = contentSize.width - safeZone;
      final beakFinalX = beakIdealX.clamp(beakMinX, beakMaxX);
      return beakFinalX;
    } else {
      final beakIdealY = targetRect.center.dy - flyoutOffset.dy;
      final beakMinY = safeZone;
      final beakMaxY = contentSize.height - safeZone;
      final beakFinalY = beakIdealY.clamp(beakMinY, beakMaxY);
      return beakFinalY;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PHASE 3: Calculate Flyout Position
  // ═══════════════════════════════════════════════════════════════════════════

  /// PHASE 3: Calculates the flyout content position
  Offset _calculateFlyoutOffset(
    TooltipCardPlacementSide side,
    Size layoutSize,
    Size contentSize,
  ) {
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
        y = targetRect.top - beakSize - contentSize.height - awaySpace;
        x = targetRect.center.dx - contentSize.width / 2;
        break;

      case TooltipCardPlacementSide.bottom:
        y = targetRect.bottom + beakSize + awaySpace;
        x = targetRect.center.dx - contentSize.width / 2;
        break;

      case TooltipCardPlacementSide.start:
        x = _isRTL
            ? targetRect.right + beakSize + awaySpace
            : targetRect.left - beakSize - contentSize.width - awaySpace;
        y = targetRect.center.dy - contentSize.height / 2;
        break;

      case TooltipCardPlacementSide.end:
        x = _isRTL
            ? targetRect.left - beakSize - contentSize.width - awaySpace
            : targetRect.right + beakSize + awaySpace;
        y = targetRect.center.dy - contentSize.height / 2;
        break;

      default:
        break;
    }

    x = x.clamp(minX, maxX);
    y = y.clamp(minY, maxY);

    return Offset(x, y);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Public API
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxW = constraints.biggest.width - viewportMargin.horizontal;
    double maxH = constraints.biggest.height - viewportMargin.vertical;

    if (fitToViewport) {
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
    final selectedSide = _selectBestSide(contentSize);

    final flyoutOffset = _calculateFlyoutOffset(
      selectedSide,
      layoutSize,
      contentSize,
    );

    final beakPosition = _calculateBeakPosition(
      selectedSide,
      contentSize,
      flyoutOffset,
    );

    onResolvedPlacement(selectedSide, beakPosition);

    final finalOffset = flyoutOffset + offset;

    return finalOffset;
  }

  @override
  bool shouldRelayout(covariant TooltipCardPositionDelegate old) {
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
