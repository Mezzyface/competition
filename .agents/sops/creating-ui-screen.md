# SOP: Creating a New UI Screen

## Prerequisites
- Understand the Reactive pattern (`system/reactive-pattern.md`)
- Theme is set up (`data/game_theme.tres`)

## Step-by-Step Process

### 1. Define State (in `game/state/`)

Create or identify the reactive state your UI will interact with.

```gdscript
# game/state/menu_state.gd
class_name MenuState
extends Node

var selected_option: ReactiveInt = ReactiveInt.new(0)
var player_name: ReactiveString = ReactiveString.new("Player")
```

### 2. Create Scene (in `view/ui/`)

- Create new scene in `view/ui/`
- Use Control node as root
- Apply theme: Theme property = `res://data/game_theme.tres`
- Build UI layout with standard controls (Button, Label, etc.)

### 3. Create Script (attach to root Control)

```gdscript
# view/ui/main_menu.gd
extends Control

func _ready() -> void:
    _connect_to_state()
    _initialize_ui()

func _connect_to_state() -> void:
    var menu_state = get_node("/root/MenuState")

    # State → UI: When state changes, update UI
    menu_state.player_name.reactive_changed.connect(func():
        $NameLabel.text = menu_state.player_name.value
    )

    # UI → State: When UI changes, update state
    $NameEdit.text_changed.connect(func(new_name: String):
        menu_state.player_name.value = new_name
    )

func _initialize_ui() -> void:
    # Set initial values from state
    var menu_state = get_node("/root/MenuState")
    $NameLabel.text = menu_state.player_name.value
```

### 4. Key Principles

✅ **DO:**
- Connect UI to state via signals
- Read from state to initialize UI
- Keep UI script focused on presentation only
- Use lambda functions for concise signal connections

❌ **DON'T:**
- Reference other UI components directly
- Put gameplay logic in UI scripts
- Make UI components aware of each other
- Hardcode values (use state or data/)

### 5. Testing

- Test UI independently by modifying state directly
- Verify all UI elements update when state changes
- Verify state updates when UI controls change
- Check that UI respects the theme

## Related Documentation
- `system/reactive-pattern.md` - Understanding reactive data binding
- `system/simulation-view-separation.md` - Architecture principles
- `data/theme_usage.md` - Applying the theme
