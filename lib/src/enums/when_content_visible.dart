part of 'enums.dart';

/// Defines how the tooltip content will become visible
enum WhenContentVisible {
  /// Content is shown when the trigger button is pressed (single tap)
  pressButton,

  /// Content is shown when hovering over the trigger button
  hoverButton,

  /// Content is shown when double-tapping the trigger button
  doubleTapButton,

  /// Content is shown on secondary tap (right-click)
  secondaryTapButton,

  /// Content is shown on long press - ideal for touch screens
  /// The tooltip appears after holding the trigger for ~500ms
  longPressButton,

  /// Content is shown on long press end - the tooltip appears
  /// after releasing a long press (touch-friendly)
  longPressUpButton,

  /// Content is shown on force press (3D Touch / Haptic Touch on iOS)
  /// Falls back to long press on devices without force touch support
  forcePressButton,
}

/// @deprecated Use [WhenContentVisible] instead
@Deprecated('Use WhenContentVisible instead')
typedef WhenContentVisable = WhenContentVisible;
