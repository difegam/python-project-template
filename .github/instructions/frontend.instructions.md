---
applyTo: "**/*.astro,**/*.ts,**/*.tsx,**/*.js,**/*.css,frontend/**"
---

# Frontend (Tailwind + Alpine)

- Alpine components should stay **small**; share state via `Alpine.store`; keep heavy logic in helpers.
- Respect **dark mode**; mobile-first; minimum touch targets **44px**; inline validation; clear error states.
- Typography & UI tokens:
  - Fonts: **Montserrat** (primary), **Lato** (secondary).
  - Functional colors: Success `#2ECC71`, Warning `#F1C40F`, Error `#E74C3C`, Info `#3498DB`.
  - Card radius 8px; button height 44px.
- Accessibility: aim for **WCAG 2.1 AA** (contrast ≥ 4.5:1, focus states, keyboard navigation).
