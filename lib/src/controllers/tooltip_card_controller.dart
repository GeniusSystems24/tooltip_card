part of 'controllers.dart';

/// Controller for programmatic control of a [TooltipCard]
///
/// Supports passing arbitrary data when opening the tooltip, which can be
/// used to customize the tooltip content dynamically.
///
/// Provides methods to:
/// - [open] - Show the tooltip (optionally with data)
/// - [close] - Hide the tooltip
/// - [toggle] - Toggle between open and closed states
/// - [updateData] - Update data while keeping the tooltip open
///
/// Example:
/// ```dart
/// final controller = TooltipCardController();
///
/// // Use in widget
/// TooltipCard.builder(
///   controller: controller,
///   child: Text('Trigger'),
///   builder: (context, close) {
///     // Access the data passed when opening
///     final data = controller.data;
///     return Text('Content for: $data');
///   },
/// );
///
/// // Programmatic control with data
/// controller.open(data: 'user_profile');
/// controller.open(data: {'id': 1, 'type': 'premium'});
/// controller.open(data: 42);
///
/// // Update data while tooltip is open (without closing/reopening)
/// controller.updateData({'id': 2, 'type': 'basic'});
///
/// // Or without data
/// controller.open();
/// controller.close();
/// controller.toggle();
/// ```
class TooltipCardController extends ChangeNotifier {
  bool _isOpen = false;
  dynamic _data;

  /// Whether the tooltip is currently open
  bool get isOpen => _isOpen;

  /// The data passed when opening the tooltip
  ///
  /// Returns null if no data was passed or the tooltip is closed
  dynamic get data => _data;

  /// Gets the data cast to a specific type
  ///
  /// Returns null if the data is not of the expected type
  /// ```dart
  /// final userId = controller.dataAs<int>();
  /// final userMap = controller.dataAs<Map<String, dynamic>>();
  /// ```
  T? dataAs<T>() => _data is T ? _data as T : null;

  /// Opens the tooltip, optionally with associated data
  ///
  /// If the tooltip is already open and new data is provided,
  /// the data will be updated and listeners will be notified
  /// without closing and reopening the tooltip.
  ///
  /// The [data] parameter can be any value that will be accessible
  /// via [data] or [dataAs] while the tooltip is open.
  ///
  /// ```dart
  /// controller.open(data: 'user');
  /// controller.open(data: {'id': 1, 'name': 'John'});
  /// controller.open(data: MyCustomObject());
  ///
  /// // If already open, this updates data without closing
  /// controller.open(data: 'new_user');
  /// ```
  void open({dynamic data}) {
    final oldData = _data;
    _data = data;
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
    } else if (oldData != data) {
      // If already open and data changed, notify listeners to update content
      notifyListeners();
    }
  }

  /// Updates the data while keeping the tooltip open
  ///
  /// This method only updates the data if the tooltip is currently open.
  /// If the tooltip is closed, this method does nothing.
  ///
  /// Use this when you want to update the tooltip content dynamically
  /// without affecting its open/closed state.
  ///
  /// ```dart
  /// // Open with initial data
  /// controller.open(data: users[0]);
  ///
  /// // Later, update to show different data (tooltip stays open)
  /// controller.updateData(users[1]);
  /// controller.updateData(users[2]);
  ///
  /// // Can also clear data while keeping tooltip open
  /// controller.updateData(null);
  /// ```
  void updateData(dynamic data) {
    if (_isOpen && _data != data) {
      _data = data;
      notifyListeners();
    }
  }

  /// Closes the tooltip and clears any associated data
  void close() {
    if (_isOpen) {
      _isOpen = false;
      _data = null;
      notifyListeners();
    }
  }

  /// Toggles the tooltip between open and closed states
  ///
  /// When toggling open, optionally pass [data] to associate with the tooltip
  void toggle({dynamic data}) {
    if (_isOpen) {
      close();
    } else {
      open(data: data);
    }
  }

  /// Checks if the current data equals the given value
  bool hasData(dynamic value) => _data == value;

  /// Checks if the current data is of a specific type
  bool isDataType<T>() => _data is T;
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
