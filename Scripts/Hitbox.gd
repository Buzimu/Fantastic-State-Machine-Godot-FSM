extends Area2D

@export var health: int = 100
@export var resistances: Array[String] = []

func _ready() -> void:
	add_to_group("hitboxes")
	SignalManager.hit_occurred.connect(_on_hit_occurred)

func _on_hit_occurred(hitbox: Area2D, hurtbox: Area2D) -> void:
	if hitbox == self:
		take_damage(hurtbox.damage)
		handle_effects(hurtbox.effects)

func take_damage(amount: int) -> void:
	health -= amount
	print("Hitbox took ", amount, " damage. Remaining health: ", health)

func handle_effects(incoming_effects: Array[String]) -> void:
	var applied_effects = incoming_effects.filter(func(effect): return effect not in resistances)
	if applied_effects:
		print("Hitbox affected by: ", applied_effects)
