# SOP: Creating a Reusable Game System

## Goal
Create independent, reusable systems that can work across projects.

## Step-by-Step Process

### 1. Design System in Isolation

Ask yourself:
- What is the SINGLE responsibility of this system?
- What data does it need?
- What signals should it emit?
- Can it work without knowing about other systems?

### 2. Create System (in `game/systems/`)

```gdscript
# game/systems/health_system.gd
class_name HealthSystem
extends Node

## Emitted when health changes
signal health_changed(current_health: int, max_health: int)
## Emitted when entity dies
signal died()

## Maximum health (set in Inspector or via code)
@export var max_health: int = 100

## Current health (use Reactive for complex cases)
var current_health: int:
    set(value):
        current_health = clampi(value, 0, max_health)
        health_changed.emit(current_health, max_health)
        if current_health == 0:
            died.emit()

func _ready() -> void:
    current_health = max_health

func take_damage(amount: int) -> void:
    current_health -= amount

func heal(amount: int) -> void:
    current_health += amount
```

### 3. Keep Systems Independent

✅ **Independent (Good):**
```gdscript
# System emits signals, doesn't know who's listening
signal attacked(damage: int)

func attack() -> void:
    attacked.emit(calculate_damage())
```

❌ **Coupled (Bad):**
```gdscript
# System directly references another system
func attack() -> void:
    var enemy = get_node("../Enemy")
    enemy.health_system.take_damage(10)  # BAD!
```

### 4. Configuration via Exports

Make systems configurable via Inspector:

```gdscript
@export var max_health: int = 100
@export var regeneration_rate: float = 1.0
@export var damage_multiplier: float = 1.0
```

Or via data resources:
```gdscript
@export var config: HealthConfig  # Resource in data/
```

### 5. Connect Systems via Glue

Don't connect in the systems themselves. Use glue code:

```gdscript
# glue/combat_connector.gd
func _ready() -> void:
    var attack_system = $AttackSystem
    var health_system = $HealthSystem

    # Wire them together
    attack_system.attacked.connect(func(damage: int):
        health_system.take_damage(damage)
    )
```

### 6. No Visual Code

Systems should NEVER:
- Reference sprites, animations, particles
- Play sounds directly
- Update UI

Instead, emit signals that view layer observes.

### 7. Testing

Create simple test scenes in `game/systems/tests/`:

```gdscript
# game/systems/tests/test_health_system.tscn
# Contains just a HealthSystem node + test script
func _ready():
    $HealthSystem.take_damage(30)
    assert($HealthSystem.current_health == 70)
```

## Checklist

Before completing a system:
- [ ] System has ONE clear responsibility
- [ ] No references to other game systems
- [ ] No visual code (sprites, UI, audio)
- [ ] All configuration via exports or data resources
- [ ] Emits signals for important state changes
- [ ] Can be tested independently
- [ ] Could be reused in another project

## Related Documentation
- `system/simulation-view-separation.md` - Why systems should be headless
- `system/project-structure.md` - Where systems fit in architecture
