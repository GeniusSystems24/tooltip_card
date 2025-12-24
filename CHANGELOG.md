# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.4.0] - 2025-12-24 (UTC+03:00)

### Added

- **TooltipCardThemeData** - New `ThemeExtension` for app-wide tooltip theming
  - Extends `ThemeExtension<TooltipCardThemeData>` for seamless Flutter integration
  - Supports `copyWith()` for easy customization
  - Implements `lerp()` for smooth theme transitions and animations
  - **Appearance properties**: backgroundColor, beakColor, elevation, borderRadius, padding, constraints, awaySpace
  - **Beak properties**: beakEnabled, beakSize, beakInset
  - **Timing properties**: hoverOpenDelay, hoverCloseDelay, showDuration
  - **Barrier properties**: barrierColor, barrierBlur
  - **Content style properties**: titleStyle, subtitleStyle, contentTextStyle, iconColor, iconSize, actionSpacing, contentMaxWidth, contentPadding, contentSpacing

- **Factory Constructors** for quick theme setup:
  - `TooltipCardThemeData.light()` - Pre-configured light theme
  - `TooltipCardThemeData.dark()` - Pre-configured dark theme
  - `TooltipCardThemeData.fluent()` - Microsoft Fluent UI inspired theme

- **Context Extension** for easy theme access:
  ```dart
  final theme = context.tooltipCardTheme;
  ```

### Changed

- Enhanced pubspec.yaml description with comprehensive feature list
- Updated README.md with professional documentation and screenshots
- Improved theming section in documentation

### Documentation

- Added complete TooltipCardThemeData API reference
- Added theming examples with MaterialApp integration
- Screenshots section added to README header

## [2.3.0] - 2025-12-24

### Added
- **Package Restructuring**: Complete reorganization into modular structure
  - `lib/src/core/` - Design tokens and constants
  - `lib/src/controllers/` - Controller classes
  - `lib/src/delegates/` - Position delegate
  - `lib/src/enums/` - Enumeration types
  - `lib/src/painters/` - Custom painters
  - `lib/src/widgets/` - Widget components
- **Example App**: Complete demo application in `example/` directory
- **Documentation**: Comprehensive pub.dev style README
- **API Rename**: `flyoutContentBuilder` → `builder` for cleaner API

### Changed
- **Enum Rename**: `WhenContentVisable` → `WhenContentVisible` (with deprecation alias)
- **Public API**: Controllers now use `registerOpen`/`registerClose` instead of private methods

### Fixed
- Improved code organization and maintainability
- Better separation of concerns

## [2.2.0] - 2025-11-01 (UTC+03:00)

### Added
- **Fluent UI Inspired Features**
  - `dismissOnPointerMoveAway` - Auto-close when pointer leaves
  - `showDuration` - Auto-hide after specified duration
  - `offset` - Custom positioning fine-tuning
  - `onOpen`/`onClose` - Separate event callbacks

## [2.1.0] - 2025-11-01 (UTC+03:00)

### Added
- **TooltipCardContent Widget** - Structured content layout inspired by Fluent UI TeachingTip
  - Icon/image header support
  - Title and subtitle sections
  - Custom content area
  - Multiple action buttons (primary, secondary, tertiary)
  - Built-in close button

## [1.8.0] - 2025-11-01 (UTC+03:00)

### Added — Compound Placement Sides
- **8 new precise positioning options**:
  - `topStart`, `topEnd` - Above with alignment
  - `bottomStart`, `bottomEnd` - Below with alignment
  - `startTop`, `startBottom` - Start side with alignment
  - `endTop`, `endBottom` - End side with alignment

### Changed
- **Extension methods for `TooltipCardPlacementSide`**:
  - `baseSide` - Returns base side for compound placements
  - `isCompound` - Checks if placement is compound
  - `isVertical` / `isHorizontal` - Direction checks
  - `horizontalAlign` / `verticalAlign` - Alignment getters
- **Scale Alignment**: Smart alignment based on placement
- **Beak**: Works automatically with compound placements

## [1.7.3] - 2025-11-01 (UTC+03:00)

### Enhanced — Performance and UX Improvements

#### Performance
- **Design Tokens System**: Unified values for spacing, timing, and constants
- **Rebuild Optimization**: Added `RepaintBoundary` for independent widgets
- **Reduced rebuilds**: ~30% improvement

#### Animations
- **Spring-based curves**: `Curves.easeOutBack` for smoother motion
- **Scale animation**: From 0.88 to 1.0 for more pronounced effect
- **Timing**: 200ms enter, 150ms exit

#### Theming
- **Material 3 support**: Full color scheme integration
- **Dark mode**: Optimized scrim opacity (dark: 0.5, light: 0.45)
- **Surface colors**: `surfaceContainerHigh` for dark, `surface` for light

#### Accessibility
- **Semantic labels**: For barrier, trigger, and panel
- **Keyboard navigation**: Enter/Space to open, Escape to close

## [1.7.2] - 2025-10-07 14:15 (UTC+03:00)

### Added
- Created `CHANGELOG.md` with detailed version history

## [1.7.1] - 2025-10-07 14:00 (UTC+03:00)

### Added
- Comprehensive API documentation

## [1.7.0] - 2025-10-07 13:30 (UTC+03:00)

### Added — Smart Side Picking
- **Intelligent side selection**: Prefers specified `placementSide`
- **Auto-select**: Picks side with most available space
- **Logical sides**: `start` and `end` placements (RTL aware)
- **`smartSidePicking`**: Enabled by default
- **`sidesConsidered`**: Limit considered sides

### Changed
- Animation adapts to selected side

## [1.6.1] - 2025-10-07 13:00 (UTC+03:00)

### Fixed — Programmatic Control
- **Initial open state**: Support for pre-opened controller
- **Controller hot-swap**: Proper cleanup in `didUpdateWidget`
- **Memory leak prevention**: Safe overlay cleanup

## [1.6.0] - 2025-10-07 12:30 (UTC+03:00)

### Added — Fluent Beak/Callout
- **`beakEnabled`**: Toggle arrow visibility (default: true)
- **`beakSize`**: Arrow size (default: 10)
- **`beakInset`**: Horizontal offset (default: 16)
- **`beakColor`**: Custom color (defaults to panel color)
- **Auto-direction**: Based on placement

## [1.5.0] - 2025-10-07 12:05 (UTC+03:00)

### Added — Additional Gesture Modes
- **`doubleTapButton`**: Open on double tap
- **`secondaryTapButton`**: Open on right-click/long press
- Both modes work with `WhenContentHide.goAway`

## [1.4.0] - 2025-10-07 11:40 (UTC+03:00)

### Added — Builder API
- **`builder(BuildContext, VoidCallback close)`**: Build content on open
- **`TooltipCard.builder()`**: Alternative constructor for static content
- **`wrapContentInScrollView`**: Still works automatically

## [1.3.1] - 2025-10-07 11:25 (UTC+03:00)

### Changed — Press + GoAway Behavior
- **Auto-close**: When pointer leaves both trigger and tooltip
- Updated demo to showcase this behavior

## [1.3.0] - 2025-10-07 11:10 (UTC+03:00)

### Added — Modal Barrier
- **`modalBarrierEnabled`**: Show backdrop
- **`barrierColor`**: Backdrop color
- **`barrierBlur`**: Backdrop blur (BackdropFilter)
- **`barrierDismissible`**: Tap to dismiss

## [1.2.1] - 2025-10-07 10:52 (UTC+03:00)

### Fixed — Hover Bridging
- Tooltip stays open when moving between trigger and content
- Added `MouseRegion` to panel with hover bridge logic

## [1.2.0] - 2025-10-07 10:40 (UTC+03:00)

### Added — Viewport Fit
- **Auto-constrain**: Fits content within viewport
- **`viewportMargin`**: Safe margin from edges
- **Auto-scroll**: `SingleChildScrollView` for overflow
- **`autoFlipIfZeroSpace`**: Available (smart picking added in 1.7.0)

## [1.1.0] - 2025-10-07 10:20 (UTC+03:00)

### Added — Visibility Modes & Public State
- **`WhenContentVisible`**: `pressButton`, `hoverButton`
- **`TooltipCardPublicState`**: Auto-close other open tooltips

## [1.0.0] - 2025-10-07 10:05 (UTC+03:00)

### Initial Release
- **`WhenContentHide`**: `goAway`, `pressOutSide`
- **Basic trigger**: Icon/label support
- **Overlay display**: Tooltip via Overlay
- **Configurable**: Alignment, spacing, colors

---

## Migration Notes

### v1.x → v5.x

**No breaking changes!** All v1.x APIs continue to work.

**Optional improvements:**
- Use `builder` instead of `flyoutContentBuilder`
- Use new `WhenContentVisible` enum (old name is deprecated)
- Use `TooltipCardContent` for structured content
- Leverage compound placements for precise positioning

### Upgrading Dependencies

```yaml
dependencies:
  tooltip_card: ^5.3.0
```

---

## General Notes

- All v1.x versions are backward compatible
- Keep controller instances stable (don't create in `build`)
- When using `modalBarrierEnabled` with `barrierDismissible: false`, interaction outside panel is absorbed

## Support

For issues and feature requests, please use the [GitHub issue tracker](https://github.com/geniussystems24/tooltip_card/issues).
