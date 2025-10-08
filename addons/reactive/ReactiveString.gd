## Reactive wrapper for string values
class_name ReactiveString
extends Reactive

var value: String:
	set(new_value):
		if value != new_value:
			value = new_value
			reactive_changed.emit()

func _init(initial_value: String = "", initial_owner: Reactive = null) -> void:
	value = initial_value
	owner = initial_owner
