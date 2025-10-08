# SOP: Adding Game Data

## Principle
Never hardcode values in scripts. All tunable data goes in `data/`.

## Step-by-Step Process

### 1. Identify Data Type

**Simple values** (numbers, strings):
- Create a Resource script

**Complex entities** (items, enemies, abilities):
- Create a Resource class

**Large datasets** (dialogue, translations):
- Use CSV/JSON files

### 2. Create Resource Class (for complex data)

```gdscript
# data/enemy_data.gd
class_name EnemyData
extends Resource

@export var enemy_name: String
@export var max_health: int
@export var movement_speed: float
@export var attack_damage: int
@export var sprite: Texture2D
@export var attack_cooldown: float
```

### 3. Create Resource Instances

In Godot Editor:
1. Right-click `data/` folder
2. Create Resource
3. Select your custom resource class (e.g., `EnemyData`)
4. Save as `.tres` file (e.g., `goblin.tres`, `skeleton.tres`)

### 4. Fill in Values

Edit the `.tres` file in Inspector to set all properties.

### 5. Use in Code

```gdscript
# game/systems/enemy_spawner.gd
@export var enemy_data: EnemyData

func spawn_enemy() -> void:
    var enemy = Enemy.new()
    enemy.setup(enemy_data)  # Pass data to enemy
```

Or preload:
```gdscript
const GOBLIN = preload("res://data/enemies/goblin.tres")

func spawn_goblin() -> void:
    spawn_enemy(GOBLIN)
```

### 6. Organize Data

Keep related data together:
```
data/
├── enemies/
│   ├── goblin.tres
│   ├── skeleton.tres
│   └── boss.tres
├── items/
│   ├── sword.tres
│   └── potion.tres
└── abilities/
    ├── fireball.tres
    └── heal.tres
```

### 7. For Large Datasets

Use CSV or JSON:

```
# data/dialogue.csv
character,line_id,text
Hero,001,"Hello, world!"
Villain,002,"We meet again."
```

Load with:
```gdscript
var file = FileAccess.open("res://data/dialogue.csv", FileAccess.READ)
# Parse CSV
```

## Benefits

✅ Game designers can tweak values without touching code
✅ Easy to balance and iterate
✅ Values are discoverable (all in one place)
✅ Can be modded by players
✅ Version control shows data changes clearly

## Checklist

Before hardcoding a value, ask:
- [ ] Could this change during development?
- [ ] Would a designer want to tweak this?
- [ ] Should this be different for multiple instances?

If yes to any, put it in `data/`.

## Related Documentation
- `system/project-structure.md` - Data folder organization
- `data/theme_usage.md` - Using theme resources
