part of 'widgets.dart';

/// A structured content widget for TooltipCard, inspired by Fluent UI's TeachingTip.
///
/// This provides a consistent, professional layout for tooltip content with:
/// - Optional icon/image header
/// - Title and subtitle
/// - Custom content area
/// - Action buttons (primary, secondary, tertiary)
/// - Close button
///
/// Example:
/// ```dart
/// TooltipCard.builder(
///   child: Text('Hover me'),
///   builder: (context, close) => TooltipCardContent(
///     icon: Icon(Icons.lightbulb_outline),
///     title: 'Pro Tip',
///     subtitle: 'This feature can save you time',
///     content: Text('Click here to access advanced settings...'),
///     primaryAction: Button(
///       child: Text('Got it'),
///       onPressed: close,
///     ),
///   ),
/// )
/// ```
class TooltipCardContent extends StatelessWidget {
  const TooltipCardContent({
    super.key,
    this.icon,
    this.iconColor,
    this.iconSize = 24.0,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.content,
    this.primaryAction,
    this.secondaryAction,
    this.tertiaryAction,
    this.onClose,
    this.showCloseButton = true,
    this.maxWidth = 360.0,
    this.padding = const EdgeInsets.all(16.0),
    this.spacing = 12.0,
  });

  /// Optional icon displayed at the top of the content
  final Widget? icon;

  /// Color for the icon (if icon is an Icon widget)
  final Color? iconColor;

  /// Size of the icon
  final double iconSize;

  /// Main title text (required)
  final String title;

  /// Custom text style for the title
  final TextStyle? titleStyle;

  /// Optional subtitle/description text
  final String? subtitle;

  /// Custom text style for the subtitle
  final TextStyle? subtitleStyle;

  /// Optional custom content widget
  final Widget? content;

  /// Primary action button (e.g., "Got it", "Learn More")
  final Widget? primaryAction;

  /// Secondary action button (e.g., "Remind me later")
  final Widget? secondaryAction;

  /// Tertiary action button (e.g., "Don't show again")
  final Widget? tertiaryAction;

  /// Callback when close button is pressed
  final VoidCallback? onClose;

  /// Whether to show the close button
  final bool showCloseButton;

  /// Maximum width of the content
  final double maxWidth;

  /// Padding around the content
  final EdgeInsets padding;

  /// Spacing between sections
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section (Icon + Title + Close)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                if (icon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: iconColor ?? colorScheme.primary,
                      size: iconSize,
                    ),
                    child: icon!,
                  ),
                  SizedBox(width: spacing),
                ],

                // Title
                Expanded(
                  child: Text(
                    title,
                    style:
                        titleStyle ??
                        textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                  ),
                ),

                // Close button
                if (showCloseButton && onClose != null) ...[
                  SizedBox(width: spacing),
                  InkWell(
                    onTap: onClose,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // Subtitle
            if (subtitle != null) ...[
              SizedBox(height: spacing * 0.5),
              Text(
                subtitle!,
                style:
                    subtitleStyle ??
                    textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
              ),
            ],

            // Custom content
            if (content != null) ...[
              SizedBox(height: spacing),
              DefaultTextStyle(
                style:
                    textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.8),
                    ) ??
                    const TextStyle(),
                child: content!,
              ),
            ],

            // Actions
            if (primaryAction != null ||
                secondaryAction != null ||
                tertiaryAction != null) ...[
              SizedBox(height: spacing * 1.5),
              _buildActions(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    final actions = <Widget>[];

    if (primaryAction != null) {
      actions.add(Expanded(child: primaryAction!));
    }

    if (secondaryAction != null) {
      if (actions.isNotEmpty) actions.add(SizedBox(width: spacing * 0.75));
      actions.add(Expanded(child: secondaryAction!));
    }

    if (tertiaryAction != null) {
      if (actions.isNotEmpty) actions.add(SizedBox(width: spacing * 0.75));
      actions.add(tertiaryAction!);
    }

    return Row(mainAxisSize: MainAxisSize.min, children: actions);
  }
}
