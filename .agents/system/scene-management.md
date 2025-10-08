# Scene Management System

## Overview

The project uses a hierarchical scene management system with a global autoload and root container nodes.

## Structure

```
Root (Godot Window)
├── Game (Autoload - global script)
└── App (Root scene)
    ├── SceneRoot (manages active gameplay scene)
    ├── UIRoot (manages UI overlays)
    │   └── CanvasLayer > Control
    │       └── [Active UI scenes loaded here]
    └── AudioRoot (manages global audio)
```

## Core Components

### Game (Autoload)
- **Path:** `res://core_engine/core/game.gd`
- **Purpose:** Global game manager accessible throughout the project
- **Key Features:**
  - Pause system
  - References to core nodes (app, scene, ui)
  - Process mode always (runs even when paused)
  - Quit game functionality

**Access from anywhere:**
```gdscript
Game.quit_game()
Game.game_paused = true
```

### App (Root Scene)
- **Path:** `res://core_engine/core/app.tscn`
- **Purpose:** Root container for all game systems
- **Children:**
  - SceneRoot (index 0)
  - UIRoot (index 1)
  - AudioRoot (index 2)

### SceneRoot
- **Path:** `res://core_engine/scene_manager/scene_root.tscn`
- **Purpose:** Container for active gameplay scenes
- **Usage:** Load level/game scenes as children here

### UIRoot
- **Path:** `res://core_engine/ui/ui_root.tscn`
- **Purpose:** Manages UI overlays (menus, HUD, etc.)
- **Structure:** Node > CanvasLayer > Control
- **Methods:**
  - `load_start_menu()` - Loads the start menu
  - `clear_ui()` - Removes all UI children

### AudioRoot
- **Path:** `res://core_engine/audio_engine/audio_root.tscn`
- **Purpose:** Global audio management
- **Usage:** Add AudioStreamPlayer nodes for music/SFX

## Scene Loading Flow

### Startup
1. Godot loads `App.tscn` as main scene
2. `Game.gd` autoload initializes
3. `Game._ready()` gets references to app, scene, ui nodes
4. `UIRoot._ready()` loads start menu

### Loading New Scenes
```gdscript
# Access scene root via Game autoload
var scene_root = Game.scene

# Clear current scene
for child in scene_root.get_children():
    child.queue_free()

# Load new scene
var new_scene = preload("res://game/levels/level_01.tscn").instantiate()
scene_root.add_child(new_scene)
Game.current_scene = new_scene
```

### Loading UI
```gdscript
# Access UI root via Game autoload
var ui_root = Game.ui as Node

# Get the control container
var control = ui_root.get_node("CanvasLayer/Control")

# Load UI scene
var menu = preload("res://view/ui/pause_menu.tscn").instantiate()
control.add_child(menu)
```

## Input Actions

### Menu Action
- **Key:** Escape
- **Action Name:** "menu"
- **Handler:** `Game._process()` - toggles pause

## Pause System

```gdscript
# Pause the game
Game.game_paused = true

# Unpause
Game.game_paused = false

# Toggle
Game.game_paused = !Game.game_paused

# Control pausibility
Game.is_game_pausible = false  # Disable pausing
```

## Benefits

1. **Centralized Control:** All scenes managed through clear entry points
2. **Layer Separation:** UI always renders on top of gameplay scenes
3. **Global Access:** Game autoload accessible from anywhere
4. **Pause Management:** Built-in pause system
5. **Predictable Hierarchy:** Consistent node structure
6. **Easy Transitions:** Clear pattern for loading/unloading scenes
