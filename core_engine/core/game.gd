## Global game manager - Entry point and core game state
## This is an autoload singleton accessible throughout the project
extends Node

#region Settings
var is_game_pausible: bool = true
var game_paused: bool = false:
	set(value):
		game_paused = value
		set_paused(value)
#endregion

#region Core Scene Variables
var app: Node = null
var scene: Node = null
var ui: Node = null
var music: Node = null
var sfx: Node = null
var current_scene: Node = null
var transition: Node = null
#endregion

func _ready() -> void:
	# Ensure game manager always processes, even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Get references to core nodes
	app = get_tree().root.get_node("App")
	scene = app.get_child(0)  # scene_root
	ui = app.get_child(1)      # ui_root
	# audio = app.get_child(2) # audio_root if needed

func _process(_delta: float) -> void:
	# Handle pause input
	if Input.is_action_just_pressed("menu") and is_game_pausible:
		game_paused = !game_paused

## Set pause state for the game
func set_paused(status: bool) -> void:
	get_tree().paused = status
	if current_scene:
		current_scene.set_process(!status)

## Quit the application
func quit_game() -> void:
	get_tree().quit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		# Handle quit request (save data, etc.)
		quit_game()
