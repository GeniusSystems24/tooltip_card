# Technical Diagrams

## 16:9 - Widget Tree Diagram

```
A technical diagram showing how TooltipCard integrates into a Flutter widget tree.

Diagram structure (tree format):
MaterialApp
└── Scaffold
    └── Column
        └── TooltipCard  ← [HIGHLIGHTED]
            ├── child: ElevatedButton
            └── builder: (context, close) → Container
                └── [Tooltip Content Widgets]

Overlay layer (shown separately):
Overlay
└── TooltipCardPanel (positioned)
    └── BeakedPanelWithBeak
        ├── PanelMaterial (shadow, background)
        └── BeakWidget (arrow/caret)

Design elements:
- Tree structure with connecting lines
- Color coding: Main tree (blue), Overlay (purple)
- Highlighted TooltipCard node
- Arrows showing widget relationships
- Layer visualization (main layer vs overlay)
- "Widget Architecture" title
- Legend for colors/symbols

Style: Technical architecture diagram
Mood: Educational, Technical, Clear
```

---

## 4:5 - Positioning Algorithm

```
A vertical diagram explaining the 3-phase positioning system.

Phase breakdown:

PHASE 1: Select Side
- Diagram showing screen bounds check
- Arrow indicating selected side based on available space
- "Smart side selection based on overflow"

PHASE 2: Calculate Beak
- Diagram showing beak position calculation
- Alignment to trigger element center
- Beak inset constraints shown

PHASE 3: Calculate Flyout
- Final tooltip position calculation
- Offset adjustments illustrated
- Screen boundary respect shown

Design elements:
- Step-by-step flow (1 → 2 → 3)
- Mini diagrams for each phase
- Coordinate system visualization
- Mathematical formulas (simplified)
- Color progression (light to dark)
- "Positioning Pipeline" header

Style: Algorithm visualization, Technical flow
Mood: Technical, Precise, Educational
```

---

## 16:9 - Event Flow Diagram

```
A flowchart showing the tooltip visibility event flow.

Flow paths:

Hover Mode:
Mouse Enter → [hoverOpenDelay] → Show Tooltip → Mouse Exit → [hoverCloseDelay] → Hide

Press Mode:
Tap → Show Tooltip → Tap Outside/Barrier → Hide

Long Press Mode:
Press Start → [500ms] → Show Tooltip → Release → [goAway?] → Hide

Programmatic Mode:
visibleDeterminer: true → Show → visibleDeterminer: false → Hide

Design elements:
- Flowchart style with decision diamonds
- Timer icons for delays
- Different colors per mode
- Start/End nodes clearly marked
- Conditional branches shown
- "Event Flow" title
- Mode selector tabs at top

Style: Flowchart, Event diagram
Mood: Logical, Comprehensive, Technical
```

---

## 4:5 - Customization Layers

```
An exploded view diagram showing the customization layers of a tooltip.

Layers (from back to front):

Layer 1: Shadow
- elevation property
- Soft shadow visualization

Layer 2: Background
- backgroundColor
- borderRadius
- Rounded rectangle shape

Layer 3: Border (optional)
- borderColor
- borderWidth
- Stroke visualization

Layer 4: Beak
- beakColor
- beakSize
- Triangle shape with border

Layer 5: Content
- padding
- child widgets
- Content area

Design elements:
- Isometric/3D exploded view
- Each layer separated vertically
- Property labels pointing to each layer
- Assembly arrows showing how they stack
- "Anatomy of a Tooltip" title
- Color swatches for each property

Style: Exploded view diagram, Anatomy illustration
Mood: Educational, Detailed, Visual
```
