part of 'core.dart';

/// Theme extension for customizing TooltipCard appearance across the app.
///
/// Add this to your [ThemeData] to provide consistent styling for all
/// TooltipCard widgets in your application.
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       TooltipCardThemeData(
///         backgroundColor: Colors.grey.shade900,
///         beakColor: Colors.grey.shade900,
///         elevation: 12.0,
///         borderRadius: BorderRadius.circular(12),
///       ),
///     ],
///   ),
/// )
/// ```
///
/// Then access it in your widgets:
/// ```dart
/// final tooltipTheme = Theme.of(context).extension<TooltipCardThemeData>();
/// ```
@immutable
class TooltipCardThemeData extends ThemeExtension<TooltipCardThemeData> {
  /// Creates a TooltipCard theme.
  const TooltipCardThemeData({
    this.backgroundColor,
    this.beakColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.constraints,
    this.awaySpace,
    this.beakSize,
    this.beakInset,
    this.beakEnabled,
    this.hoverOpenDelay,
    this.hoverCloseDelay,
    this.showDuration,
    this.barrierColor,
    this.barrierBlur,
    this.titleStyle,
    this.subtitleStyle,
    this.contentTextStyle,
    this.iconColor,
    this.iconSize,
    this.actionSpacing,
    this.contentMaxWidth,
    this.contentPadding,
    this.contentSpacing,
  });

  // ─────────────────────────────────────────────────────────────────────────
  // Appearance
  // ─────────────────────────────────────────────────────────────────────────

  /// Background color of the tooltip panel.
  ///
  /// If null, uses [ColorScheme.surfaceContainerHigh] in dark mode
  /// or [ColorScheme.surface] in light mode.
  final Color? backgroundColor;

  /// Color of the beak/arrow.
  ///
  /// If null, defaults to [backgroundColor].
  final Color? beakColor;

  /// Elevation for the tooltip shadow.
  ///
  /// Defaults to [TooltipCardConstants.defaultElevation] (8.0).
  final double? elevation;

  /// Border radius of the tooltip panel.
  ///
  /// Defaults to [TooltipCardConstants.defaultBorderRadius].
  final BorderRadius? borderRadius;

  /// Padding inside the tooltip panel.
  final EdgeInsetsGeometry? padding;

  /// Size constraints for the tooltip.
  final BoxConstraints? constraints;

  /// Gap between the trigger and tooltip.
  final double? awaySpace;

  // ─────────────────────────────────────────────────────────────────────────
  // Beak
  // ─────────────────────────────────────────────────────────────────────────

  /// Whether the beak/arrow is enabled.
  ///
  /// Defaults to true.
  final bool? beakEnabled;

  /// Size of the beak triangle.
  ///
  /// Defaults to [TooltipCardConstants.defaultBeakSize] (10.0).
  final double? beakSize;

  /// Minimum inset of the beak from panel edges.
  ///
  /// Defaults to [TooltipCardConstants.defaultBeakInset] (20.0).
  final double? beakInset;

  // ─────────────────────────────────────────────────────────────────────────
  // Timing
  // ─────────────────────────────────────────────────────────────────────────

  /// Delay before showing tooltip on hover.
  ///
  /// Defaults to [TooltipCardTiming.hoverOpenDelay].
  final Duration? hoverOpenDelay;

  /// Delay before hiding tooltip after hover exit.
  ///
  /// Defaults to [TooltipCardTiming.hoverCloseDelay].
  final Duration? hoverCloseDelay;

  /// Duration before auto-closing the tooltip.
  ///
  /// If null, tooltip stays open until manually closed.
  final Duration? showDuration;

  // ─────────────────────────────────────────────────────────────────────────
  // Modal Barrier
  // ─────────────────────────────────────────────────────────────────────────

  /// Color of the modal barrier/scrim.
  final Color? barrierColor;

  /// Blur amount for the modal barrier.
  final double? barrierBlur;

  // ─────────────────────────────────────────────────────────────────────────
  // TooltipCardContent Styles
  // ─────────────────────────────────────────────────────────────────────────

  /// Text style for the title in [TooltipCardContent].
  final TextStyle? titleStyle;

  /// Text style for the subtitle in [TooltipCardContent].
  final TextStyle? subtitleStyle;

  /// Default text style for content in [TooltipCardContent].
  final TextStyle? contentTextStyle;

  /// Default icon color in [TooltipCardContent].
  final Color? iconColor;

  /// Default icon size in [TooltipCardContent].
  final double? iconSize;

  /// Spacing between action buttons in [TooltipCardContent].
  final double? actionSpacing;

  /// Maximum width for [TooltipCardContent].
  final double? contentMaxWidth;

  /// Padding for [TooltipCardContent].
  final EdgeInsetsGeometry? contentPadding;

  /// Spacing between elements in [TooltipCardContent].
  final double? contentSpacing;

  // ─────────────────────────────────────────────────────────────────────────
  // ThemeExtension Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  TooltipCardThemeData copyWith({
    Color? backgroundColor,
    Color? beakColor,
    double? elevation,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
    double? awaySpace,
    bool? beakEnabled,
    double? beakSize,
    double? beakInset,
    Duration? hoverOpenDelay,
    Duration? hoverCloseDelay,
    Duration? showDuration,
    Color? barrierColor,
    double? barrierBlur,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? contentTextStyle,
    Color? iconColor,
    double? iconSize,
    double? actionSpacing,
    double? contentMaxWidth,
    EdgeInsetsGeometry? contentPadding,
    double? contentSpacing,
  }) {
    return TooltipCardThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      beakColor: beakColor ?? this.beakColor,
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      constraints: constraints ?? this.constraints,
      awaySpace: awaySpace ?? this.awaySpace,
      beakEnabled: beakEnabled ?? this.beakEnabled,
      beakSize: beakSize ?? this.beakSize,
      beakInset: beakInset ?? this.beakInset,
      hoverOpenDelay: hoverOpenDelay ?? this.hoverOpenDelay,
      hoverCloseDelay: hoverCloseDelay ?? this.hoverCloseDelay,
      showDuration: showDuration ?? this.showDuration,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierBlur: barrierBlur ?? this.barrierBlur,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      actionSpacing: actionSpacing ?? this.actionSpacing,
      contentMaxWidth: contentMaxWidth ?? this.contentMaxWidth,
      contentPadding: contentPadding ?? this.contentPadding,
      contentSpacing: contentSpacing ?? this.contentSpacing,
    );
  }

  @override
  TooltipCardThemeData lerp(TooltipCardThemeData? other, double t) {
    if (other == null) return this;
    return TooltipCardThemeData(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      beakColor: Color.lerp(beakColor, other.beakColor, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      constraints: BoxConstraints.lerp(constraints, other.constraints, t),
      awaySpace: lerpDouble(awaySpace, other.awaySpace, t),
      beakEnabled: t < 0.5 ? beakEnabled : other.beakEnabled,
      beakSize: lerpDouble(beakSize, other.beakSize, t),
      beakInset: lerpDouble(beakInset, other.beakInset, t),
      hoverOpenDelay: t < 0.5 ? hoverOpenDelay : other.hoverOpenDelay,
      hoverCloseDelay: t < 0.5 ? hoverCloseDelay : other.hoverCloseDelay,
      showDuration: t < 0.5 ? showDuration : other.showDuration,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t),
      barrierBlur: lerpDouble(barrierBlur, other.barrierBlur, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t),
      contentTextStyle: TextStyle.lerp(
        contentTextStyle,
        other.contentTextStyle,
        t,
      ),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      actionSpacing: lerpDouble(actionSpacing, other.actionSpacing, t),
      contentMaxWidth: lerpDouble(contentMaxWidth, other.contentMaxWidth, t),
      contentPadding: EdgeInsetsGeometry.lerp(
        contentPadding,
        other.contentPadding,
        t,
      ),
      contentSpacing: lerpDouble(contentSpacing, other.contentSpacing, t),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Factory Constructors
  // ─────────────────────────────────────────────────────────────────────────

  /// Creates a light theme for TooltipCard.
  factory TooltipCardThemeData.light({Color? primaryColor}) {
    return TooltipCardThemeData(
      backgroundColor: Colors.white,
      beakColor: Colors.white,
      elevation: 8.0,
      borderRadius: TooltipCardConstants.defaultBorderRadius,
      barrierColor: Colors.black45,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      subtitleStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700),
      iconColor: primaryColor ?? Colors.blue,
    );
  }

  /// Creates a dark theme for TooltipCard.
  factory TooltipCardThemeData.dark({Color? primaryColor}) {
    return TooltipCardThemeData(
      backgroundColor: const Color(0xFF2D2D30),
      beakColor: const Color(0xFF2D2D30),
      elevation: 12.0,
      borderRadius: TooltipCardConstants.defaultBorderRadius,
      barrierColor: Colors.black54,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      subtitleStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
      iconColor: primaryColor ?? Colors.lightBlueAccent,
    );
  }

  /// Creates a Fluent UI inspired theme.
  factory TooltipCardThemeData.fluent({
    Brightness brightness = Brightness.light,
    Color? accentColor,
  }) {
    final isLight = brightness == Brightness.light;
    return TooltipCardThemeData(
      backgroundColor: isLight ? Colors.white : const Color(0xFF1F1F1F),
      beakColor: isLight ? Colors.white : const Color(0xFF1F1F1F),
      elevation: 16.0,
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(16),
      beakSize: 12.0,
      barrierBlur: 2.0,
      barrierColor: isLight
          ? Colors.black.withValues(alpha: 0.3)
          : Colors.black54,
      titleStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isLight ? Colors.black : Colors.white,
      ),
      subtitleStyle: TextStyle(
        fontSize: 12,
        color: isLight ? Colors.grey.shade600 : Colors.grey.shade400,
      ),
      iconColor: accentColor ?? (isLight ? Colors.blue : Colors.lightBlue),
      iconSize: 20.0,
      contentMaxWidth: 320.0,
      contentPadding: const EdgeInsets.all(12),
      contentSpacing: 8.0,
      actionSpacing: 8.0,
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Equality
  // ─────────────────────────────────────────────────────────────────────────

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is TooltipCardThemeData &&
        other.backgroundColor == backgroundColor &&
        other.beakColor == beakColor &&
        other.elevation == elevation &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.constraints == constraints &&
        other.awaySpace == awaySpace &&
        other.beakEnabled == beakEnabled &&
        other.beakSize == beakSize &&
        other.beakInset == beakInset &&
        other.hoverOpenDelay == hoverOpenDelay &&
        other.hoverCloseDelay == hoverCloseDelay &&
        other.showDuration == showDuration &&
        other.barrierColor == barrierColor &&
        other.barrierBlur == barrierBlur &&
        other.titleStyle == titleStyle &&
        other.subtitleStyle == subtitleStyle &&
        other.contentTextStyle == contentTextStyle &&
        other.iconColor == iconColor &&
        other.iconSize == iconSize &&
        other.actionSpacing == actionSpacing &&
        other.contentMaxWidth == contentMaxWidth &&
        other.contentPadding == contentPadding &&
        other.contentSpacing == contentSpacing;
  }

  @override
  int get hashCode => Object.hashAll([
    backgroundColor,
    beakColor,
    elevation,
    borderRadius,
    padding,
    constraints,
    awaySpace,
    beakEnabled,
    beakSize,
    beakInset,
    hoverOpenDelay,
    hoverCloseDelay,
    showDuration,
    barrierColor,
    barrierBlur,
    titleStyle,
    subtitleStyle,
    contentTextStyle,
    iconColor,
    iconSize,
    actionSpacing,
    contentMaxWidth,
    contentPadding,
    contentSpacing,
  ]);

  @override
  String toString() =>
      'TooltipCardThemeData('
      'backgroundColor: $backgroundColor, '
      'beakColor: $beakColor, '
      'elevation: $elevation, '
      'borderRadius: $borderRadius'
      ')';
}

/// Extension to easily access [TooltipCardThemeData] from [BuildContext].
extension TooltipCardThemeDataExtension on BuildContext {
  /// Gets the [TooltipCardThemeData] from the current theme.
  ///
  /// Returns null if no [TooltipCardThemeData] is defined in the theme.
  TooltipCardThemeData? get tooltipCardTheme =>
      Theme.of(this).extension<TooltipCardThemeData>();
}
