# Reactive Pattern Usage

## Overview

The Reactive pattern separates **State** from **Controls**, allowing UI components to remain decoupled while automatically synchronizing with game data.

## Core Concept

```
State (Reactive objects) <--signals--> Controls (UI nodes)
```

- **State**: Data wrapped in Reactive classes that emit signals when changed
- **Controls**: UI nodes (Button, Label, LineEdit) that observe state

## Available Reactive Types

Located in `addons/reactive/`:

- `ReactiveInt` - Integer values
- `ReactiveFloat` - Float values
- `ReactiveString` - String values
- `ReactiveBool` - Boolean values
- `ReactiveArray` - Arrays with signal-emitting operations
- `ReactiveObject` - Generic objects, handles nested reactives

## Usage Example

```gdscript
# Define state (usually in game/state/)
class_name PlayerState
extends Reactive

var health: ReactiveInt
var name: ReactiveString

func _init() -> void:
    health = ReactiveInt.new(100, self)  # 100 initial value, self as owner
    name = ReactiveString.new("Hero", self)

# Connect to UI (in view/ui/)
func _ready() -> void:
    var player_state = get_node("/root/PlayerState")

    # When state changes, update UI
    player_state.health.reactive_changed.connect(func():
        $HealthLabel.text = str(player_state.health.value)
    )

    # When UI changes, update state
    $NameEdit.text_changed.connect(func(new_name: String):
        player_state.name.value = new_name
    )
```

## Key Rules

1. **UI never talks to UI**: Components communicate through state only
2. **Use signals**: Never direct references between components
3. **Owner propagation**: Set owner so nested changes propagate upward
4. **One-way data flow**: State → UI or UI → State, never UI → UI

## Benefits

- Components are independent and reusable
- Easy to add/remove UI elements
- Automatic synchronization across all connected UI
- Simplified debugging (clear data flow)
- Maintainable as complexity grows
