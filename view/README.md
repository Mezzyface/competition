# View (Presentation Layer)

Visual representation that **observes** the game simulation.

## Structure

- `/ui` - User interface screens and components
- `/vfx` - Visual effects, animations, particles

## Rules

- NO gameplay logic
- Reads from game state but doesn't modify simulation logic
- Connects to game state via signals
- UI components use Reactive pattern for data binding
- View doesn't know about other view components (decoupled)
