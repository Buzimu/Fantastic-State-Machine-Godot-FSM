extends Area2D
class_name NPCHitbox

@export var health := 3
@export var damage := 1

func _init() -> void:
	collision_layer = 2
	collision_mask = 0

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(Hurtbox: PlayerHurtbox) -> void:
	print(Hurtbox)
	if Hurtbox is PlayerHurtbox:
		print('Owie: CHciekn hurt :( ')
		Hurtbox.owner.take_damage(damage)

func take_damage() -> void:
	health -= 1
	if health <= 0:
		_die()
	else:
		_hurt_effect()

func _hurt_effect() -> void:
	# Add visual or sound effect for getting hurt
	pass

func _die() -> void:
	# Add death animation or effect
	get_parent().queue_free()  # Remove the chicken from the scene
