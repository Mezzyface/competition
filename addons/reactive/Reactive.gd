## Base class for reactive data types
## Emits signals when data changes, enabling decoupled UI updates
class_name Reactive
extends Resource

## Emitted when the reactive value changes
signal reactive_changed

## Optional owner that will propagate change signals
var owner: Reactive = null:
	set(value):
		# Disconnect from old owner if exists
		if owner != null and reactive_changed.is_connected(owner.propagate):
			reactive_changed.disconnect(owner.propagate)

		owner = value

		# Connect to new owner if it's a valid Reactive
		if owner != null:
			reactive_changed.connect(owner.propagate)

## Propagates the signal to notify parent reactive objects
func propagate() -> void:
	reactive_changed.emit()
