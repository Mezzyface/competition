# Godot Project Setup Complete! 🎮

This project has been set up with a scalable architecture designed for maintainability and AI-assisted development.

## 📁 What Was Created

### 1. `.agents/` - AI Assistant Documentation System
A structured documentation system to help Claude Code and other AI assistants understand your codebase:
- **`task/`** - Store implementation plans here after completing features
- **`system/`** - Architecture documentation (already populated with guides)
- **`sops/`** - Standard operating procedures for common tasks
- **`README.md`** - Index of all documentation

### 2. `addons/reactive/` - Reactive UI System
A complete reactive data binding system for decoupled UI:
- **Reactive base classes** that emit signals on change
- **Type-specific wrappers**: ReactiveInt, ReactiveFloat, ReactiveString, ReactiveBool, ReactiveArray, ReactiveObject
- **Owner propagation** for nested reactive objects

### 3. Clean Architecture Folders

**`game/`** - Simulation layer (pure logic, no visuals)
- `/systems/` - Reusable game systems
- `/state/` - Game state using Reactive classes

**`view/`** - Presentation layer (observes simulation)
- `/ui/` - UI screens and components
- `/vfx/` - Visual effects and animations

**`glue/`** - Connection layer (wires game to view)
- Small managers that connect systems

**`data/`** - Centralized game data
- All tunable parameters and configuration
- Theme resources

### 4. Theme System
- **`palette.gd`** - Color palette constants (8 warm/earthy colors)
- **`create_theme.gd`** - Script to generate theme resource
- **`theme_usage.md`** - Guide for using the theme

## 🚀 Getting Started

### Step 1: Enable the Reactive Plugin
1. Open project in Godot
2. Project → Project Settings → Plugins
3. Enable "Reactive" plugin

### Step 2: Generate the Theme
1. Open `data/create_theme.gd` in editor
2. File → Run (or Ctrl+Shift+X)
3. Theme will be created at `res://data/game_theme.tres`

### Step 3: Apply Theme to Project
1. Project → Project Settings → GUI → Theme
2. Set Custom = `res://data/game_theme.tres`

### Step 4: Read the Documentation
Start with these docs in `.agents/system/`:
- `project-structure.md` - Understand the folder organization
- `reactive-pattern.md` - Learn the UI binding system
- `simulation-view-separation.md` - Understand game/view split

## 📖 Next Steps

### When Creating New Features:
1. **Read** `.agents/README.md` for similar implementations
2. **Create** game systems in `game/systems/` (use SOP)
3. **Create** UI in `view/ui/` using reactive pattern (use SOP)
4. **Store** configuration data in `data/` (use SOP)
5. **Document** your implementation in `.agents/task/`

### When Asking Claude Code for Help:
- Reference the `.agents/` docs: "Follow the SOP for creating UI screens"
- Ask to update docs: "Add an SOP for this process"
- Request adherence to architecture: "Keep simulation and view separate"

## 🎨 Color Palette Reference

```
#f4ddd1 - Light Peach (highlights, text)
#9cd762 - Light Green (success, health)
#e8b37b - Tan (secondary UI)
#d2632c - Orange (call-to-action)
#a32c0f - Red-Orange (warnings)
#5e0000 - Dark Red (danger)
#78243e - Dark Purple-Red (backgrounds)
#24061d - Very Dark Purple (deep backgrounds)
```

## 🏗️ Architecture Principles

1. **70% reusable, 30% glue** - Most code should be reusable systems
2. **Separate data from code** - No hardcoded values
3. **Separate simulation from view** - Game logic doesn't know about visuals
4. **Use reactive pattern** - UI components never talk to each other directly
5. **Document as you go** - Update `.agents/` after implementing features

## 📚 Key Files to Understand

- `.agents/system/project-structure.md` - Full architecture overview
- `.agents/sops/creating-ui-screen.md` - How to build UI
- `.agents/sops/creating-game-system.md` - How to build game systems
- `addons/reactive/Reactive.gd` - Reactive base class
- `data/palette.gd` - Color constants

## 🎯 Benefits of This Setup

✅ **Scalable** - Clean architecture prevents spaghetti code
✅ **Maintainable** - Clear separation of concerns
✅ **AI-Friendly** - Documentation helps Claude Code understand context
✅ **Designer-Friendly** - All data centralized in `data/`
✅ **Testable** - Systems can be tested independently
✅ **Reusable** - Systems work across projects

## 🤝 Working with Claude Code

When asking Claude Code to implement features:
- "Read `.agents/README.md` first"
- "Follow the reactive pattern from `.agents/system/reactive-pattern.md`"
- "Create this as a reusable system in `game/systems/`"
- "After we're done, create an implementation plan in `.agents/task/`"

Happy coding! 🚀
