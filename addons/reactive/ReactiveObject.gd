## Reactive wrapper for generic objects
## Handles nested reactive objects and propagates their signals
class_name ReactiveObject
extends Reactive

var value: Variant:
	set(new_value):
		# Disconnect from old reactive value if it exists
		if value is Reactive and value.reactive_changed.is_connected(propagate):
			value.reactive_changed.disconnect(propagate)

		value = new_value

		# Connect to new reactive value if it is Reactive
		if value is Reactive:
			value.reactive_changed.connect(propagate)

		reactive_changed.emit()

func _init(initial_value: Variant = null, initial_owner: Reactive = null) -> void:
	owner = initial_owner
	# Use the setter logic
	value = initial_value
