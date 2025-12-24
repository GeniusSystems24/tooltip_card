/// TooltipCard — A powerful, customizable tooltip library for Flutter
///
/// This library provides a comprehensive tooltip widget with Fluent UI inspired
/// design, smart positioning, Material 3 theming, and accessibility support.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:tooltip_card/tooltip_card.dart';
///
/// TooltipCard.builder(
///   child: Icon(Icons.info),
///   builder: (context, close) => TooltipCardContent(
///     title: 'Information',
///     subtitle: 'This is helpful information',
///     primaryAction: FilledButton(
///       onPressed: close,
///       child: Text('Got it'),
///     ),
///     onClose: close,
///   ),
/// )
/// ```
///
/// ## Features
///
/// - Multiple trigger modes (press, hover, double-tap, right-click)
/// - Smart positioning with auto-flip
/// - Beak/arrow pointing to trigger
/// - Modal barrier support with blur
/// - Full Material 3 theming support
/// - RTL aware positioning
/// - Structured content with TooltipCardContent
/// - Programmatic control via TooltipCardController
library;

// Export all public APIs
export 'src/controllers/controllers.dart';
export 'src/core/core.dart';
export 'src/delegates/delegates.dart';
export 'src/enums/enums.dart';
export 'src/painters/painters.dart';
export 'src/widgets/widgets.dart';
