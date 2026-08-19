---
name: CareerPilot AI
colors:
  surface: '#f9f9ff'
  surface-dim: '#d3daef'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f1f3ff'
  surface-container: '#e9edff'
  surface-container-high: '#e1e8fd'
  surface-container-highest: '#dce2f7'
  on-surface: '#141b2b'
  on-surface-variant: '#464555'
  inverse-surface: '#293040'
  inverse-on-surface: '#edf0ff'
  outline: '#777587'
  outline-variant: '#c7c4d8'
  surface-tint: '#4d44e3'
  primary: '#3525cd'
  on-primary: '#ffffff'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#4648d4'
  on-secondary: '#ffffff'
  secondary-container: '#6063ee'
  on-secondary-container: '#fffbff'
  tertiary: '#7e3000'
  on-tertiary: '#ffffff'
  tertiary-container: '#a44100'
  on-tertiary-container: '#ffd2be'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#e1e0ff'
  secondary-fixed-dim: '#c0c1ff'
  on-secondary-fixed: '#07006c'
  on-secondary-fixed-variant: '#2f2ebe'
  tertiary-fixed: '#ffdbcc'
  tertiary-fixed-dim: '#ffb695'
  on-tertiary-fixed: '#351000'
  on-tertiary-fixed-variant: '#7b2f00'
  background: '#f9f9ff'
  on-background: '#141b2b'
  surface-variant: '#dce2f7'
typography:
  display:
    fontFamily: Geist
    fontSize: 48px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Geist
    fontSize: 32px
    fontWeight: '600'
    lineHeight: '1.3'
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Geist
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.3'
  headline-md:
    fontFamily: Geist
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.4'
  body-lg:
    fontFamily: Geist
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Geist
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  label-md:
    fontFamily: Geist
    fontSize: 14px
    fontWeight: '500'
    lineHeight: '1.4'
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Geist
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1.2'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  container-max: 1280px
  gutter: 24px
  margin-desktop: 48px
  margin-mobile: 16px
  unit-xs: 4px
  unit-sm: 8px
  unit-md: 16px
  unit-lg: 24px
  unit-xl: 48px
---

## Brand & Style

The design system is engineered for an **Empowering, Intelligent, and Trustworthy** user experience. It serves as a sophisticated digital mentor for students, balancing the technical prowess of AI with the accessibility required for early-career navigation.

The aesthetic follows a **Modern Corporate** style with a heavy emphasis on **Minimalism** and **Soft-Tactility**. The UI feels "breathable" through generous whitespace, high-quality typography, and a refined "card-on-canvas" architecture. Visual interest is generated through subtle depth and purposeful micro-interactions rather than heavy ornamentation.

## Colors

The palette is anchored by **Indigo (#4f46e5)**, signaling intelligence and professional stability. This is supported by **Deep Violet (#6366f1)** for secondary accents and interactive states.

- **Background:** A crisp off-white creates a low-glare canvas for long-form reading and career planning.
- **Surface:** Pure white is used for elevated containers, clearly distinguished from the background via thin borders and soft shadows.
- **Typography:** High-contrast Dark Slate for headlines ensures immediate readability, while Slate body text reduces visual fatigue.

## Typography

This design system utilizes **Geist** for its technical precision and modern geometric construction. The typeface bridges the gap between "developer-centric" toolsets and "student-friendly" approachability.

Headings should utilize tighter letter spacing and bold weights to command attention. Body copy remains at a generous line height (1.6) to facilitate the consumption of AI-generated advice and career insights. Labels use a medium weight to ensure they remain legible even at smaller scales on mobile devices.

## Layout & Spacing

The system relies on a **Fluid Grid** with fixed maximum constraints. 
- **Desktop:** 12-column grid with 24px gutters. Use wide 48px margins to enforce the "premium" feel.
- **Tablet:** 8-column grid with 20px gutters.
- **Mobile:** 4-column grid with 16px gutters and 16px margins.

Spacing follows an 8px base unit. Component-internal spacing should be generous (e.g., card padding should rarely drop below 24px) to maintain the "breathable" design narrative.

## Elevation & Depth

Depth is communicated through **Tonal Layers** combined with **Ambient Shadows**. 

1. **Level 0 (Base):** Background color (#f9fafb).
2. **Level 1 (Cards/Surface):** White surface with a 1px border (#e5e7eb).
3. **Level 2 (Interactive/Floating):** White surface with a "Soft Ambient" shadow. Shadows should have a large blur radius (20px-30px), low opacity (4-6%), and a slight Y-offset to simulate a natural light source. 

Avoid harsh black shadows; instead, use a subtle indigo-tinted shadow to harmonize with the primary brand color.

## Shapes

The shape language is defined by large, welcoming radii. 
- **Standard Components:** Buttons and input fields use a `0.5rem` (8px) radius.
- **Containers & Cards:** Use `rounded-xl` (1.5rem / 24px) to create a soft, approachable frame for content.
- **Chips/Badges:** Use a full "Pill" radius for categorical distinction.

Consistency in corner rounding is critical to maintaining the "premium SaaS" identity; ensure that nested elements have a proportionally smaller radius to maintain visual harmony.

## Components

### Buttons
- **Primary:** Indigo background, white text, 8px radius. Subtle scale-down effect on click (98%).
- **Secondary:** White background, 1px border (#e5e7eb), Dark Slate text.
- **Ghost:** No border or background until hover.

### Input Fields
- Clear labels using `label-md`. 
- 1px border (#e5e7eb) that transitions to Indigo (#4f46e5) on focus with a soft 4px focus ring.
- Placeholder text in Slate (#9ca3af).

### Cards
- White background, 24px radius, 1px border. 
- Content inside should be padded with `unit-lg` (24px) at minimum.
- Hover state: Slight vertical lift (-4px) and a deepening of the ambient shadow.

### Chips & Badges
- Used for skill tags or status. 
- Light indigo tint background with indigo text for "active" or "positive" states.

### Icons
- Use thin-stroke icons (1.5px or 2px stroke width). 
- Icons should always be accompanied by labels or tooltips, adhering to the "intelligent and clear" brand pillar.

### Additional Components
- **Progress Steppers:** Use for career roadmaps; minimal lines with soft-glow active nodes.
- **AI Response Containers:** Distinguish AI-generated content with a very subtle gradient border or a soft violet-tinted background.