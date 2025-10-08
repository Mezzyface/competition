## Reactive wrapper for arrays
## Wraps common array operations to emit signals on modification
class_name ReactiveArray
extends Reactive

var _data: Array = []

func _init(initial_owner: Reactive = null) -> void:
	owner = initial_owner

## Get the internal array (read-only access recommended)
func get_data() -> Array:
	return _data

## Get array size
func size() -> int:
	return _data.size()

## Check if array is empty
func is_empty() -> bool:
	return _data.is_empty()

## Append an item to the array
func append(item) -> void:
	_data.append(item)
	reactive_changed.emit()

## Insert an item at a specific index
func insert(index: int, item) -> void:
	_data.insert(index, item)
	reactive_changed.emit()

## Remove an item at a specific index
func remove_at(index: int) -> void:
	_data.remove_at(index)
	reactive_changed.emit()

## Erase an item by value
func erase(item) -> void:
	_data.erase(item)
	reactive_changed.emit()

## Clear the entire array
func clear() -> void:
	_data.clear()
	reactive_changed.emit()

## Get an item at a specific index
func get_at(index: int):
	return _data[index]

## Set an item at a specific index
func set_at(index: int, item) -> void:
	_data[index] = item
	reactive_changed.emit()

## Find the index of an item
func find(item) -> int:
	return _data.find(item)

## Check if array contains an item
func has(item) -> bool:
	return _data.has(item)

## Manually emit the changed signal (useful for rebuilding UI)
func emit_changed() -> void:
	reactive_changed.emit()
