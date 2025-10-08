# Implementation Plan: Scene Structure Setup

## Overview
Set up core scene management system with hierarchical structure and start menu.

## Implementation

### 1. Core Folder Structure ✅
Created `core_engine/` with subfolders:
- `core/` - Main app and game manager
- `scene_manager/` - Scene root
- `ui/` - UI root
- `audio_engine/` - Audio root

### 2. Game Manager (Autoload) ✅
**File:** `core_engine/core/game.gd`

Features:
- Process mode always (runs when paused)
- Pause system with `game_paused` variable
- References to core nodes (app, scene, ui)
- Quit game functionality
- Menu input handling (Escape key)

### 3. App Scene (Main Scene) ✅
**File:** `core_engine/core/app.tscn`

Structure:
- Root node (Node type)
- Children: SceneRoot, UIRoot, AudioRoot

### 4. Root Scenes ✅

**SceneRoot** (`core_engine/scene_manager/scene_root.tscn`)
- Empty Node container
- Purpose: Hold active gameplay scenes

**UIRoot** (`core_engine/ui/ui_root.tscn`)
- Node > CanvasLayer > Control structure
- Loads start menu on ready
- Methods: `load_start_menu()`, `clear_ui()`

**AudioRoot** (`core_engine/audio_engine/audio_root.tscn`)
- Empty Node container
- Purpose: Global audio management

### 5. Project Configuration ✅
Updated `project.godot`:
- Main scene: `res://core_engine/core/app.tscn`
- Autoload: `Game` → `res://core_engine/core/game.gd`
- Input action: `menu` → Escape key

### 6. Start Menu ✅
**File:** `view/ui/start_menu.tscn`

Features:
- Centered VBoxContainer layout
- Title label
- Three buttons: Play, Options, Quit
- Uses game theme
- Background color from palette

**Script:** `view/ui/start_menu.gd`
- Button connections
- Quit button calls `Game.quit_game()`
- Placeholders for Play and Options

## Architecture Compliance

✅ **View Layer:** Start menu in `view/ui/`
✅ **Simulation Layer:** Game logic in `game/` (future)
✅ **Glue Layer:** UIRoot connects view to core
✅ **Theme Usage:** Start menu uses `data/game_theme.tres`
✅ **No Hardcoding:** Colors from palette, theme centralized

## Testing

Run the project:
1. App scene loads as main scene
2. Game autoload initializes
3. UIRoot loads start menu automatically
4. Start menu displays with title and buttons
5. Quit button exits application
6. Escape key handling (pause system ready for game scenes)

## Next Steps

- [ ] Create game scene to load when Play is pressed
- [ ] Create options menu for settings
- [ ] Add scene transition system
- [ ] Add loading screen for scene transitions
- [ ] Create pause menu
