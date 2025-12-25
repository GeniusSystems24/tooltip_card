# Documentation Images

## 16:9 - API Overview Diagram

```
A clean technical diagram showing the TooltipCard widget architecture and its main properties. The visualization uses a tree/mind-map structure.

Central element: TooltipCard widget icon (tooltip shape)

Branching categories:
├── Appearance
│   ├── backgroundColor
│   ├── elevation
│   ├── borderRadius
│   ├── borderColor
│   └── borderWidth
├── Beak
│   ├── beakEnabled
│   ├── beakSize
│   ├── beakColor
│   └── beakInset
├── Positioning
│   ├── placementSide
│   ├── placementAlignment
│   ├── awaySpace
│   └── offset
├── Behavior
│   ├── whenContentVisible
│   ├── whenContentHide
│   ├── modalBarrierEnabled
│   └── dismissOnPointerMoveAway
└── Timing
    ├── hoverOpenDelay
    ├── hoverCloseDelay
    └── showDuration

Design elements:
- Light background with subtle grid
- Color-coded branches (each category has distinct color)
- Clean sans-serif typography
- Icons next to each property
- Connecting lines with smooth curves
- "TooltipCard API" title at top
- Version badge "v2.4.1"

Style: Technical documentation, API reference
Mood: Organized, Comprehensive, Developer-focused
```

---

## 4:5 - Quick Start Guide

```
A vertical step-by-step guide showing how to implement TooltipCard in 4 steps.

Step layout (top to bottom):

STEP 1: Install
- Terminal/console icon
- Code: flutter pub add tooltip_card
- Checkmark indicator

STEP 2: Import
- File icon
- Code: import 'package:tooltip_card/tooltip_card.dart';
- Checkmark indicator

STEP 3: Wrap Widget
- Widget tree icon
- Code snippet showing TooltipCard.builder wrapping a button
- Arrow pointing to the child widget

STEP 4: Customize
- Palette icon
- Code snippet showing common customization options
- Preview of the resulting tooltip

Design elements:
- Dark code editor theme for code snippets
- Numbered steps with circular badges
- Progress line connecting steps
- Syntax highlighting in code
- "Get Started in Minutes" header
- Flutter logo watermark

Style: Tutorial guide, Developer onboarding
Mood: Simple, Approachable, Quick-start
```

---

## 16:9 - Theme Configuration

```
A documentation image showing how to configure TooltipCardThemeData for app-wide theming.

Split layout:
Left side: Code editor showing ThemeData configuration with TooltipCardThemeData extension
Right side: Live preview of themed tooltips

Code section shows:
- TooltipCardThemeData instantiation
- Key properties being set (backgroundColor, beakColor, elevation, etc.)
- Comment annotations explaining each property

Preview section shows:
- Light theme tooltip example
- Dark theme tooltip example
- Custom branded tooltip example

Design elements:
- VS Code-like editor appearance
- Syntax highlighting with proper colors
- Line numbers visible
- Preview tooltips with realistic content
- "App-Wide Theming" title
- Theme toggle icon (sun/moon)

Style: Code documentation, IDE aesthetic
Mood: Professional, Configurable, Consistent
```

---

## 4:5 - Positioning Reference Card

```
A compact reference card showing all 12 tooltip placements with visual examples.

Grid layout (4 columns × 3 rows):
Each cell contains:
- Small button element
- Tooltip in the correct position
- Placement name label below

Placements arranged logically:
Row 1: topStart, top, topEnd, (legend)
Row 2: startTop, [center button], endTop
Row 3: start, [center button], end
Row 4: startBottom, [center button], endBottom
Row 5: bottomStart, bottom, bottomEnd

Design elements:
- Minimal design with focus on positions
- Color coding for position groups
- Arrows showing beak direction
- Grid lines for alignment reference
- "Placement Reference" header
- Legend showing color meanings
- Compact, printable format

Style: Reference card, Cheat sheet
Mood: Quick reference, Educational, Practical
```
