extends Node

var _items: Dictionary = {}

func _ready() -> void:
	load_items()

func load_items() -> void:
	# In the future, this could load from JSON/CSV files
	# For now, hardcoded for development
	_items = {
		1: {
			"name": "Raw Poultry",
			"spritesheet": "sp0",
			"spriteCoords": Vector2(0, 0)
		},
		2: {
			"name": "Feather",
			"spritesheet": "sp0",
			"spriteCoords": Vector2(1, 0)
		}
	}

func get_item_data(id: int) -> Dictionary:
	if _items.has(id):
		return _items[id]
	push_error("Item ID %d not found in database" % id)
	return {}
