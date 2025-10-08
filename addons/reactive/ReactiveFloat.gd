## Reactive wrapper for float values
class_name ReactiveFloat
extends Reactive

var value: float:
	set(new_value):
		if value != new_value:
			value = new_value
			reactive_changed.emit()

func _init(initial_value: float = 0.0, initial_owner: Reactive = null) -> void:
	value = initial_value
	owner = initial_owner
