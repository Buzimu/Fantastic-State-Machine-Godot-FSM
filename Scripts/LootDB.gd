extends Node

var _loot_tables: Dictionary = {}

func _ready() -> void:
	load_loot_tables()

func load_loot_tables() -> void:
	# In the future, this could load from JSON/CSV files
	_loot_tables = {
		"chicken": {
			"guaranteed": [
				{
					"itemId": 1,
					"quantity": Vector2i(1, 1)
				}
			],
			"random": [
				{
					"itemId": 2,
					"dropChance": 80,
					"quantity": Vector2i(0, 3)
				}
			],
			"bonus": [
				{
					"itemId": 2,
					"dropChance": 25,
					"quantity": Vector2i(1, 1)
				}
			]
		}
	}

func get_loot_table(npc_type: String) -> Dictionary:
	if _loot_tables.has(npc_type):
		return _loot_tables[npc_type]
	push_error("Loot table for %s not found" % npc_type)
	return {}
