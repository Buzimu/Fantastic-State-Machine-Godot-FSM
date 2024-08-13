extends Area2D
class_name PlayerHurtbox

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(hitbox: NPCHitbox) -> void:
	if hitbox == null:
		return
	print("hurtbox area entered")
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
