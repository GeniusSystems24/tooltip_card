part of 'widgets.dart';

/// Material panel widget for the tooltip content
class PanelMaterial extends StatelessWidget {
  const PanelMaterial({
    super.key,
    required this.elevation,
    required this.backgroundColor,
    required this.borderRadius,
    required this.child,
  });

  final double elevation;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        shadowColor: Theme.of(context).shadowColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: TooltipCardSpacing.md,
            vertical: TooltipCardSpacing.sm,
          ),
          child: child,
        ),
      ),
    );
  }
}
