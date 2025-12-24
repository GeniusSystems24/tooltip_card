part of 'core.dart';

/// Spacing tokens for consistent padding and margins
class TooltipCardSpacing {
  TooltipCardSpacing._();

  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
}

/// Animation timing constants
class TooltipCardTiming {
  TooltipCardTiming._();

  static const Duration enterDuration = Duration(milliseconds: 200);
  static const Duration exitDuration = Duration(milliseconds: 150);
  static const Duration hoverOpenDelay = Duration(milliseconds: 500);
  static const Duration hoverCloseDelay = Duration(milliseconds: 250);
}

/// Animation curves
class TooltipCardCurves {
  TooltipCardCurves._();

  /// Curve for fade animations
  static const Curve fade = Curves.easeOut;

  /// Enhanced scale animation with spring effect
  static final Curve scaleIn = Curves.easeOutBack;

  /// Curve for scale out animation
  static const Curve scaleOut = Curves.easeInCubic;
}

/// Sizing and layout constants
class TooltipCardConstants {
  TooltipCardConstants._();

  /// Default maximum width for tooltip content
  static const double defaultMaxWidth = 360.0;

  /// Default elevation for the tooltip panel
  static const double defaultElevation = 8.0;

  /// Epsilon for position calculations to handle floating point precision
  static const double positionEpsilon = 0.5;

  /// Default shadow opacity
  static const double shadowOpacity = 0.25;

  /// Default beak size
  static const double defaultBeakSize = 10.0;

  /// Default beak inset from edges
  static const double defaultBeakInset = 16.0;

  /// Default border radius
  static const BorderRadius defaultBorderRadius = BorderRadius.all(
    Radius.circular(8),
  );
}
