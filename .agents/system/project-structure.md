# Project Structure

## Folder Organization

```
godot-games/
├── .agents/              # AI assistant documentation
│   ├── task/            # Implementation plans and PRDs
│   ├── system/          # Architecture documentation
│   ├── sops/            # Standard operating procedures
│   └── README.md        # Documentation index
│
├── addons/
│   └── reactive/        # Reactive UI system (reusable addon)
│
├── game/                # SIMULATION LAYER - Pure gameplay logic
│   ├── systems/         # Reusable game systems (health, movement, etc.)
│   └── state/           # Game state managers using Reactive classes
│
├── view/                # PRESENTATION LAYER - Visual representation
│   ├── ui/              # User interface screens and components
│   └── vfx/             # Visual effects, animations, particles
│
├── glue/                # CONNECTION LAYER - Wires game to view
│   └── (managers)       # GameManager, MenuManager, etc.
│
└── data/                # GAME DATA - Centralized configuration
    ├── palette.gd       # Color palette constants
    ├── create_theme.gd  # Theme generator script
    └── (resources)      # .tres files for game data
```

## Key Principles

### 1. Separation of Concerns
- **Game**: Gameplay logic, no visuals
- **View**: Visual representation, no gameplay logic
- **Glue**: Connects game and view, not reusable
- **Data**: All tunable parameters in one place

### 2. Modularity
- 70% reusable systems
- 30% glue code
- Systems are independent and don't reference each other directly
- Communication via signals or through state

### 3. Reactive Architecture
- All mutable game state uses Reactive classes
- UI components bind to reactive state via signals
- Changes propagate automatically through the system
- Components are decoupled and independent

## Autoloads

Game state should be set up as autoloads for global access. Keep autoloads minimal and well-organized.
