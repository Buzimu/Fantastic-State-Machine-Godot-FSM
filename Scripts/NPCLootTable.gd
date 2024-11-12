extends Node

const ItemScene = preload("res://Scenes/Item.tscn")
const DROP_FORCE = 75.0
const DROP_SPREAD = PI * 2  # Full circle spread
const MIN_FORCE = 50.0
const MAX_FORCE = 100.0
const BONUS_FORCE_MULTIPLIER = 0.75  # New constant for bonus drops

func spawn_drops(drops: Array) -> void:
	# Start from a random initial angle
	var start_angle = randf() * DROP_SPREAD
	var angle_step = DROP_SPREAD / max(drops.size(), 1)  # Prevent division by zero
	
	for i in drops.size():
		var item = ItemScene.instantiate()
		item.item_id = drops[i]
		
		# Calculate angle for even distribution, starting from random position
		var base_angle = start_angle + (i * angle_step)
		# Add some randomness to the angle
		var angle = base_angle + randf_range(-0.2, 0.2)
		
		var direction = Vector2(cos(angle), sin(angle))
		# Randomize force for each item
		var force = randf_range(MIN_FORCE, MAX_FORCE)
		# If this is a bonus drop (from roll_bonus_drop), reduce the force
		if get_stack()[1].source.contains("NPCLootTable"):
			force *= BONUS_FORCE_MULTIPLIER
		
		# Add to scene at start position
		owner.get_parent().add_child(item)
		item.global_position = owner.global_position
		
		# Calculate target position
		var target_pos = item.global_position + direction * force
		
		# Create tween for arc motion
		var tween = create_tween()
		tween.set_parallel(true)
		
		# Starting position slightly above for better arc
		item.global_position.y -= 20
		
		# X movement (linear)
		tween.tween_property(item, "global_position:x", target_pos.x, 0.5)
		
		# Y movement (quadratic for arc effect)
		tween.tween_property(item, "global_position:y", target_pos.y, 0.5)\
			.set_trans(Tween.TRANS_QUAD)\
			.set_ease(Tween.EASE_IN)



func roll_loot(npc_type: String) -> Array:
	var drops = []
	var loot_table = LootDB.get_loot_table(npc_type)
	if loot_table.is_empty():
		return drops
		
	# Handle guaranteed drops
	if loot_table.has("guaranteed"):
		for entry in loot_table.guaranteed:
			var qty = randi_range(entry.quantity.x, entry.quantity.y)
			for i in qty:
				drops.append(entry.itemId)
	
	# Handle random drops
	if loot_table.has("random"):
		for entry in loot_table.random:
			if randf() * 100 <= entry.dropChance:
				var qty = randi_range(entry.quantity.x, entry.quantity.y)
				for i in qty:
					drops.append(entry.itemId)
	
	return drops

func roll_bonus_drop(npc_type: String) -> void:
	var loot_table = LootDB.get_loot_table(npc_type)
	if not loot_table.has("bonus"):
		return
		
	for entry in loot_table.bonus:
		if randf() * 100 <= entry.dropChance:
			var qty = randi_range(entry.quantity.x, entry.quantity.y)
			var drops = []
			for i in qty:
				drops.append(entry.itemId)
			spawn_drops(drops)
