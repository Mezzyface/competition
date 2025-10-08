## Start Menu - Main menu UI
extends Control

func _ready() -> void:
	# Apply theme
	theme = preload("res://data/game_theme.tres")

	# Connect buttons
	%PlayButton.pressed.connect(_on_play_pressed)
	%OptionsButton.pressed.connect(_on_options_pressed)
	%QuitButton.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	# TODO: Load first level/game scene
	print("Play button pressed - Load game scene")

func _on_options_pressed() -> void:
	# TODO: Show options menu
	print("Options button pressed")

func _on_quit_pressed() -> void:
	Game.quit_game()
