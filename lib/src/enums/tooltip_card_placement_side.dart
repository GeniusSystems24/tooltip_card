part of 'enums.dart';

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

/// Internal alignment type for positioning calculations
enum HorizontalAlign { start, center, end }

/// Internal alignment type for positioning calculations
enum VerticalAlign { top, center, bottom }

/// Extension methods for [TooltipCardPlacementSide]
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
  HorizontalAlign get horizontalAlign {
    switch (this) {
      case TooltipCardPlacementSide.topStart:
      case TooltipCardPlacementSide.bottomStart:
        return HorizontalAlign.start;
      case TooltipCardPlacementSide.topEnd:
      case TooltipCardPlacementSide.bottomEnd:
        return HorizontalAlign.end;
      default:
        return HorizontalAlign.center;
    }
  }

  /// Gets the vertical alignment encoded in compound placements
  /// For horizontal placements (start/end), returns the vertical alignment
  /// For basic sides, returns center
  VerticalAlign get verticalAlign {
    switch (this) {
      case TooltipCardPlacementSide.startTop:
      case TooltipCardPlacementSide.endTop:
        return VerticalAlign.top;
      case TooltipCardPlacementSide.startBottom:
      case TooltipCardPlacementSide.endBottom:
        return VerticalAlign.bottom;
      default:
        return VerticalAlign.center;
    }
  }
}
