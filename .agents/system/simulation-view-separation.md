# Simulation/View Separation

## Architecture

The codebase is divided into two independent layers:

### Simulation Layer (`game/`)
The "headless" game - pure gameplay logic with no visual dependencies.

**Contains:**
- Game rules and mechanics
- State management
- Physics and collision logic
- AI behavior
- Data structures

**Does NOT contain:**
- Sprites, animations, particles
- UI code
- Audio playback
- Any visual representation

**Example:** A health system tracks damage, healing, and death states, but doesn't display health bars or play hurt animations.

### View Layer (`view/`)
The "observer" - renders the simulation state visually.

**Contains:**
- UI components and screens
- Visual effects and animations
- Sprite rendering
- Audio playback
- Camera control

**Does NOT contain:**
- Gameplay logic
- Game state modification (it reads, doesn't write)

**Example:** A health bar component reads health from the simulation and updates its visual representation.

## How They Connect

```
Simulation (game/) --signals--> View (view/)
                   <--input--
```

1. **Simulation emits signals** when state changes
2. **View observes signals** and updates visuals
3. **View sends input** to simulation (button presses, clicks)
4. **Glue layer** (`glue/`) wires them together

## Benefits

1. **Testable**: Simulation can be tested without rendering
2. **Flexible**: Replace visuals without touching gameplay
3. **Networked**: Simulation can run on server, view on client
4. **Maintainable**: Clear boundaries prevent spaghetti code
5. **Reusable**: Simulation systems work across different visual styles

## Example Structure

```gdscript
# game/systems/health_system.gd (Simulation)
class_name HealthSystem
extends Node

signal health_changed(new_health: int)
signal died()

var current_health: int = 100:
    set(value):
        current_health = value
        health_changed.emit(current_health)
        if current_health <= 0:
            died.emit()

func take_damage(amount: int) -> void:
    current_health -= amount

# view/ui/health_bar.gd (View)
class_name HealthBar
extends ProgressBar

func _ready() -> void:
    # Observe the simulation
    var health_system = get_node("../../HealthSystem")
    health_system.health_changed.connect(_on_health_changed)

func _on_health_changed(new_health: int) -> void:
    value = new_health

# glue/game_manager.gd (Connection)
func _ready() -> void:
    var health_system = $HealthSystem
    var health_bar = $UI/HealthBar
    # Systems initialize themselves, glue just sets up the scene
```

## Testing Without View

```gdscript
# tests/test_health.gd
func test_health_system():
    var health = HealthSystem.new()
    health.take_damage(30)
    assert(health.current_health == 70)
    # No rendering needed!
```
