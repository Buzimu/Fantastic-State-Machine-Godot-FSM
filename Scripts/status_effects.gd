# status_effects.gd - A singleton/autoload containing effect definitions
extends Node

const EFFECTS = {
	"poison": {
		"duration": 5.0,
		"tick_interval": 1.0,
		"damage_per_tick": 1,
		"movement_modifier": 0.8,
		"visual_tint": Color(1.0, 0.8, 1.0)
	},
	"stun": {
		"duration": 2.0,
		"movement_modifier": 0.05,
		"visual_tint": Color(1.0, 1.0, 0.8)
	}
}

# Applied effects contain instance-specific data
class ActiveEffect:
	var type: String
	var remaining_duration: float
	var last_tick: float = 0.0
	var source: Node  # Who applied the effect
	
	func _init(effect_type: String, source_node: Node):
		type = effect_type
		source = source_node
		remaining_duration = EFFECTS[type]["duration"]
