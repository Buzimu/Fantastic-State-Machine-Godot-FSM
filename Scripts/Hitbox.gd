extends Area2D

func _ready():
	add_to_group("hitboxes")
	SignalManager.hit_occurred.connect(_on_hit_occurred)
	

func _on_hit_occurred(hitbox, hurtbox):
	if hitbox == self:
		print("Hitbox received a hit!")
		owner._on_hit(hurtbox)
		
