# Theme Usage Guide

## Color Palette

The project uses a warm, earthy color palette with 8 colors:

| Color | Hex | Usage |
|-------|-----|-------|
| Light Peach | `#f4ddd1` | Highlights, text on dark backgrounds |
| Light Green | `#9cd762` | Success states, positive feedback, health |
| Tan/Beige | `#e8b37b` | Secondary UI elements, backgrounds |
| Orange | `#d2632c` | Call-to-action buttons, important UI |
| Red-Orange | `#a32c0f` | Warnings, important actions |
| Dark Red | `#5e0000` | Danger, critical states |
| Dark Purple-Red | `#78243e` | Backgrounds, depth |
| Very Dark Purple | `#24061d` | Deep backgrounds, borders |

## Using the Palette in Code

```gdscript
# Import the palette
const Palette = preload("res://data/palette.gd")

# Use colors
my_sprite.modulate = Palette.LIGHT_GREEN
my_label.add_theme_color_override("font_color", Palette.LIGHT_PEACH)
```

## Applying the Theme

### To Generate the Theme

1. Open Godot Editor
2. Go to File > Run
3. Select `data/create_theme.gd`
4. Run the script
5. The theme will be created at `res://data/game_theme.tres`

### To Apply to Your Project

**Project-wide:**
- Project Settings > GUI > Theme > Custom = `res://data/game_theme.tres`

**Per-scene:**
- Select root Control node
- In Inspector > Theme > Theme = load `res://data/game_theme.tres`

**Per-control:**
```gdscript
my_button.theme = preload("res://data/game_theme.tres")
```

## Customizing the Theme

To modify the theme:
1. Edit `data/create_theme.gd`
2. Re-run the script to regenerate `game_theme.tres`
3. Changes will apply automatically to all UI using the theme
