extends State
class_name PlayerAttack

@export var sprite : AnimatedSprite2D
@export var hurtbox : Area2D
var debug_shape : CollisionShape2D
var player : CharacterBody2D
var facing_direction: Vector2 = Vector2.ZERO

func _ready():
	if not hurtbox:
		push_error("Hurtbox not assigned in PlayerAttack state")
	if not sprite:
		push_error("Sprite not assigned in PlayerAttack state")
	if player:
		player.DirectionChanged.connect(_on_player_direction_changed)

func Enter():
	print("Player Attacked!")
	player = get_parent().get_parent()
	if sprite:
		sprite.play("Attack")
		sprite.animation_finished.connect(_on_animation_finished)
	else:
		push_error("Sprite not assigned in PlayerAttack state")
	
	activate_hurtbox()

	update_hurtbox_orientation()

func Exit():
	deactivate_hurtbox()
	if sprite and sprite.animation_finished.is_connected(_on_animation_finished):
		sprite.animation_finished.disconnect(_on_animation_finished)

func Transition(newstate):
	state_transition.emit(self, newstate)

func _on_animation_finished():
	Transition("Idle")

func _on_player_direction_changed(new_direction: Vector2):
	facing_direction = new_direction
	print("Player is now facing: ", facing_direction)

func activate_hurtbox():
	if hurtbox:
		hurtbox.monitoring = true
		hurtbox.monitorable = true
		hurtbox.get_node("CollisionShape2D").visible = true
	else:
		push_error("Attempted to activate null hurtbox in PlayerAttack state")

func deactivate_hurtbox():
	if hurtbox:
		hurtbox.monitoring = false
		hurtbox.monitorable = false
		hurtbox.get_node("CollisionShape2D").visible = false
	else:
		push_error("Attempted to deactivate null hurtbox in PlayerAttack state")

func update_hurtbox_orientation():
	if not hurtbox or not sprite:
		push_error("Cannot update hurtbox orientation: hurtbox or sprite is null")
		return

	
	match sprite.sprite_type:
		2:
			update_2_direction_hurtbox(facing_direction)
		4:
			update_4_direction_hurtbox(facing_direction)
		8:
			update_8_direction_hurtbox(facing_direction)
		_:
			push_error("Unknown sprite type in PlayerAttack state")


func update_2_direction_hurtbox(facing: Vector2):
	hurtbox.rotation = 0
	hurtbox.scale.x = 1 if facing.x >= 0 else -1

func update_4_direction_hurtbox(facing: Vector2):
	if abs(facing.x) > abs(facing.y):
		hurtbox.rotation = 0 if facing.x > 0 else PI
	else:
		hurtbox.rotation = PI/2 if facing.y > 0 else -PI/2
	hurtbox.scale.x = 1

func update_8_direction_hurtbox(facing: Vector2):
	hurtbox.rotation = facing.angle()
	hurtbox.scale.x = 1
