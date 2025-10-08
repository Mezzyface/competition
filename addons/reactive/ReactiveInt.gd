## Reactive wrapper for integer values
class_name ReactiveInt
extends Reactive

var value: int:
	set(new_value):
		if value != new_value:
			value = new_value
			reactive_changed.emit()

func _init(initial_value: int = 0, initial_owner: Reactive = null) -> void:
	value = initial_value
	owner = initial_owner
