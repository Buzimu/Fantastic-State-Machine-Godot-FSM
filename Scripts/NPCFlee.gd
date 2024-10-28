extends State
class_name NPCFlee

@export var sprite : AnimatedSprite2D
@export var npc : CharacterBody2D
@export var flee_speed : float = 150.0
@export var flee_duration : float = 3.0

var flee_direction : Vector2
var flee_timer : float = 0.0

func _ready():
	if owner and owner.has_signal("npc_hit"):
		owner.npc_hit.connect(_on_npc_hit)

func Enter():
	print("Fleeing!")
	sprite.play("Walk")
	sprite.speed_scale = 2.0
	flee_timer = flee_duration

	
func Exit():
	sprite.speed_scale = 1.0

func Update(delta: float) -> void:
	if flee_timer > 0:
		# Update sprite facing direction
		if flee_direction.x < 0:
			sprite.flip_h = true
		elif flee_direction.x > 0:
			sprite.flip_h = false
		
		# Apply movement
		owner.velocity = flee_direction * flee_speed
		owner.move_and_slide()
		
		flee_timer -= delta
	else:
		owner.velocity = Vector2.ZERO
		state_transition.emit(self, "Idle")

func _on_npc_hit(damage_source):
	if damage_source:
		# Get the actual positions
		var source_pos = damage_source.global_position
		var current_pos = owner.global_position
		
		# Calculate direction away from damage source
		flee_direction = (current_pos - source_pos).normalized()
	else:
		# Random direction if no damage source
		flee_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
	flee_timer = flee_duration
