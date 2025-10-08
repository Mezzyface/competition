## Reactive wrapper for boolean values
class_name ReactiveBool
extends Reactive

var value: bool:
	set(new_value):
		if value != new_value:
			value = new_value
			reactive_changed.emit()

func _init(initial_value: bool = false, initial_owner: Reactive = null) -> void:
	value = initial_value
	owner = initial_owner
