part of 'enums.dart';

/// Defines how the tooltip content will become visible
enum WhenContentVisible {
  /// Content is shown when the trigger button is pressed
  pressButton,

  /// Content is shown when hovering over the trigger button
  hoverButton,

  /// Content is shown when double-tapping the trigger button
  doubleTapButton,

  /// Content is shown on secondary tap (right-click or long press)
  secondaryTapButton,
}

/// @deprecated Use [WhenContentVisible] instead
@Deprecated('Use WhenContentVisible instead')
typedef WhenContentVisable = WhenContentVisible;
