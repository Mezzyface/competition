@tool
extends EditorScript

## Run this script in the Godot editor (File > Run) to generate the theme resource
func _run() -> void:
	var theme := Theme.new()

	# Define colors from palette
	var light_peach := Color("#f4ddd1")
	var light_green := Color("#9cd762")
	var tan := Color("#e8b37b")
	var orange := Color("#d2632c")
	var red_orange := Color("#a32c0f")
	var dark_red := Color("#5e0000")
	var dark_purple_red := Color("#78243e")
	var very_dark_purple := Color("#24061d")

	# Button colors
	theme.set_color("font_color", "Button", light_peach)
	theme.set_color("font_hover_color", "Button", light_green)
	theme.set_color("font_pressed_color", "Button", tan)
	theme.set_color("font_disabled_color", "Button", dark_purple_red)

	# Button styles
	var button_normal := StyleBoxFlat.new()
	button_normal.bg_color = orange
	button_normal.border_color = tan
	button_normal.border_width_left = 2
	button_normal.border_width_right = 2
	button_normal.border_width_top = 2
	button_normal.border_width_bottom = 2
	button_normal.corner_radius_top_left = 4
	button_normal.corner_radius_top_right = 4
	button_normal.corner_radius_bottom_left = 4
	button_normal.corner_radius_bottom_right = 4
	theme.set_stylebox("normal", "Button", button_normal)

	var button_hover := StyleBoxFlat.new()
	button_hover.bg_color = red_orange
	button_hover.border_color = light_green
	button_hover.border_width_left = 2
	button_hover.border_width_right = 2
	button_hover.border_width_top = 2
	button_hover.border_width_bottom = 2
	button_hover.corner_radius_top_left = 4
	button_hover.corner_radius_top_right = 4
	button_hover.corner_radius_bottom_left = 4
	button_hover.corner_radius_bottom_right = 4
	theme.set_stylebox("hover", "Button", button_hover)

	var button_pressed := StyleBoxFlat.new()
	button_pressed.bg_color = dark_red
	button_pressed.border_color = tan
	button_pressed.border_width_left = 2
	button_pressed.border_width_right = 2
	button_pressed.border_width_top = 2
	button_pressed.border_width_bottom = 2
	button_pressed.corner_radius_top_left = 4
	button_pressed.corner_radius_top_right = 4
	button_pressed.corner_radius_bottom_left = 4
	button_pressed.corner_radius_bottom_right = 4
	theme.set_stylebox("pressed", "Button", button_pressed)

	# Panel colors
	var panel_bg := StyleBoxFlat.new()
	panel_bg.bg_color = dark_purple_red
	panel_bg.border_color = tan
	panel_bg.border_width_left = 1
	panel_bg.border_width_right = 1
	panel_bg.border_width_top = 1
	panel_bg.border_width_bottom = 1
	theme.set_stylebox("panel", "Panel", panel_bg)

	# Label colors
	theme.set_color("font_color", "Label", light_peach)
	theme.set_color("font_shadow_color", "Label", very_dark_purple)

	# LineEdit colors
	theme.set_color("font_color", "LineEdit", light_peach)
	theme.set_color("font_placeholder_color", "LineEdit", tan)
	theme.set_color("caret_color", "LineEdit", light_green)
	theme.set_color("selection_color", "LineEdit", orange)

	var lineedit_normal := StyleBoxFlat.new()
	lineedit_normal.bg_color = very_dark_purple
	lineedit_normal.border_color = tan
	lineedit_normal.border_width_left = 2
	lineedit_normal.border_width_right = 2
	lineedit_normal.border_width_top = 2
	lineedit_normal.border_width_bottom = 2
	theme.set_stylebox("normal", "LineEdit", lineedit_normal)

	var lineedit_focus := StyleBoxFlat.new()
	lineedit_focus.bg_color = very_dark_purple
	lineedit_focus.border_color = light_green
	lineedit_focus.border_width_left = 2
	lineedit_focus.border_width_right = 2
	lineedit_focus.border_width_top = 2
	lineedit_focus.border_width_bottom = 2
	theme.set_stylebox("focus", "LineEdit", lineedit_focus)

	# Save the theme
	var result := ResourceSaver.save(theme, "res://data/game_theme.tres")
	if result == OK:
		print("Theme created successfully at res://data/game_theme.tres")
	else:
		print("Failed to create theme. Error code: ", result)
