## UI Root - Manages all UI overlays (menus, HUD, etc.)
extends Node

@onready var control_container: Control = $CanvasLayer/Control

func _ready() -> void:
	# Load start menu on startup
	load_start_menu()

func _process(_delta: float) -> void:
	pass

## Load the start menu
func load_start_menu() -> void:
	var start_menu = preload("res://view/ui/start_menu.tscn").instantiate()
	control_container.add_child(start_menu)

## Clear all UI
func clear_ui() -> void:
	for child in control_container.get_children():
		child.queue_free()
