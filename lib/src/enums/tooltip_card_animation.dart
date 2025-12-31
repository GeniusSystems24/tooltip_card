part of 'enums.dart';

/// Animation style for tooltip appearance and disappearance
///
/// Each animation type provides a different visual effect when the
/// tooltip opens and closes.
enum TooltipCardAnimation {
  /// Fade in/out animation (default)
  ///
  /// Simple opacity transition from 0 to 1
  fade,

  /// Scale animation
  ///
  /// Tooltip scales from 0.8 to 1.0 with fade
  scale,

  /// Fade with scale animation (default behavior)
  ///
  /// Combines opacity and scale for a polished effect
  fadeScale,

  /// Slide from the placement direction
  ///
  /// Tooltip slides in from the direction it's positioned
  /// (e.g., slides down if placed on top)
  slideIn,

  /// Slide with fade animation
  ///
  /// Combines slide and fade for a smooth entrance
  slideFade,

  /// Bounce animation
  ///
  /// Tooltip bounces slightly when appearing
  bounce,

  /// Elastic animation
  ///
  /// Tooltip has an elastic/spring effect when appearing
  elastic,

  /// Zoom animation
  ///
  /// Tooltip zooms in from a smaller size with overshoot
  zoom,

  /// No animation
  ///
  /// Tooltip appears and disappears instantly
  none,
}
