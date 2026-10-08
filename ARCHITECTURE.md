# Clean Architecture Overview

This template follows Clean Architecture by isolating responsibilities in layers.

## Layers

- Presentation: `lib/ui`
- Domain: `lib/domain`
- Data: `lib/data`
- Core: `lib/core`
- Config: `lib/config`
- Routing: `lib/routing`

## Dependency direction

`ui -> domain -> data -> core` and shared config/routing around them.

## Benefits

- better testability
- easier extension
- lower coupling between features
- consistent app structure
