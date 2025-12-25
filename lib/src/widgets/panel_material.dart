part of 'widgets.dart';

/// Material panel widget for the tooltip content
/// with optional border support
class PanelMaterial extends StatelessWidget {
  const PanelMaterial({
    super.key,
    required this.elevation,
    required this.backgroundColor,
    required this.borderRadius,
    required this.child,
    this.borderColor,
    this.borderWidth = 0.0,
  });

  final double elevation;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Widget child;

  /// Optional border color
  final Color? borderColor;

  /// Border width (0 = no border)
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final hasBorder = borderColor != null && borderWidth > 0;

    Widget content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: TooltipCardSpacing.md,
        vertical: TooltipCardSpacing.sm,
      ),
      child: child,
    );

    // Wrap with border decoration if needed
    if (hasBorder) {
      content = Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: borderColor!,
            width: borderWidth,
          ),
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: content,
        ),
      );
    }

    return RepaintBoundary(
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        shadowColor: Theme.of(context).shadowColor,
        child: content,
      ),
    );
  }
}
