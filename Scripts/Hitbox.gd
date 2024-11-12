extends Area2D

@export var damage := 1  # Default unarmed damage

func _ready():
	add_to_group("hitboxes")
	SignalManager.hit_occurred.connect(_on_hit_occurred)

func _on_hit_occurred(hitbox, hurtbox, damage):
	if hitbox == self:
		print("Hitbox received a hit!")
		owner._on_hit(hurtbox, damage)
