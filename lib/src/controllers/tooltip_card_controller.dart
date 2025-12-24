part of 'controllers.dart';

/// Controller for programmatic control of a [TooltipCard]
///
/// Provides methods to:
/// - [open] - Show the tooltip
/// - [close] - Hide the tooltip
/// - [toggle] - Toggle between open and closed states
///
/// Example:
/// ```dart
/// final controller = TooltipCardController();
///
/// // Use in widget
/// TooltipCard.builder(
///   controller: controller,
///   child: Text('Trigger'),
///   builder: (context, close) => Text('Content'),
/// );
///
/// // Programmatic control
/// controller.open();
/// controller.close();
/// controller.toggle();
/// ```
class TooltipCardController extends ChangeNotifier {
  bool _isOpen = false;

  /// Whether the tooltip is currently open
  bool get isOpen => _isOpen;

  /// Opens the tooltip
  void open() {
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
    }
  }

  /// Closes the tooltip
  void close() {
    if (_isOpen) {
      _isOpen = false;
      notifyListeners();
    }
  }

  /// Toggles the tooltip between open and closed states
  void toggle() => _isOpen ? close() : open();
}

/// Global state manager for tracking open tooltips
///
/// Ensures only one tooltip is open at a time within a given scope.
/// Uses a singleton pattern by default with [TooltipCardPublicState.global].
///
/// Example:
/// ```dart
/// // Using the global singleton
/// TooltipCard.builder(
///   publicState: TooltipCardPublicState.global,
///   // ...
/// );
///
/// // Or create a custom scope
/// final myState = TooltipCardPublicState();
/// ```
class TooltipCardPublicState extends ChangeNotifier {
  /// Private constructor for singleton
  TooltipCardPublicState._();

  /// Creates a new public state instance for custom scoping
  factory TooltipCardPublicState() => TooltipCardPublicState._();

  /// Global singleton instance
  static final TooltipCardPublicState global = TooltipCardPublicState._();

  TooltipCardController? _openController;

  /// Whether any tooltip is currently open
  bool get hasAnyOpen => _openController != null;

  /// The currently open controller, if any
  TooltipCardController? get openController => _openController;

  /// Checks if another tooltip (not [me]) is currently open
  bool isAnotherOpen(TooltipCardController me) =>
      _openController != null && _openController != me;

  /// Registers a controller as the currently open tooltip
  ///
  /// Automatically closes any previously open tooltip
  void registerOpen(TooltipCardController controller) {
    if (_openController == controller) return;
    _openController?.close();
    _openController = controller;
    notifyListeners();
  }

  /// Unregisters a controller when it closes
  void registerClose(TooltipCardController controller) {
    if (_openController == controller) {
      _openController = null;
      notifyListeners();
    }
  }
}
