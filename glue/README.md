# Glue (Connection Layer)

Connects game systems to view components.

## Purpose

- Small, specialized managers that connect game and view
- NOT intended to be reusable
- Handles initialization and wiring of systems
- Manages execution order when needed

## Examples

- GameManager - Initializes game systems and connects to UI
- LevelManager - Loads levels and sets up appropriate views
- MenuManager - Handles menu flow and connects to game state
