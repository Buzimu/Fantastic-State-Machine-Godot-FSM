extends State
class_name PlayerAttack

@export var sprite : AnimatedSprite2D
@export var hurtbox : Area2D

var player : CharacterBody2D

func _ready():
	if not hurtbox:
		push_error("Hurtbox not assigned in PlayerAttack state")

func Enter():
	print("Player Attacked!")
	player = get_parent().get_parent()
	if sprite:
		sprite.play("Attack")
		sprite.animation_finished.connect(_on_animation_finished)
	else:
		push_error("Sprite not assigned in PlayerAttack state")
	
	_activate_hurtbox()

func Exit():
	_deactivate_hurtbox()
	if sprite and sprite.animation_finished.is_connected(_on_animation_finished):
		sprite.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished():
	Transition("Idle")

func Transition(newstate):
	state_transition.emit(self, newstate)

func _activate_hurtbox():
	if hurtbox:
		hurtbox.monitoring = true
		hurtbox.monitorable = true
	else:
		push_error("Attempted to activate null hurtbox in PlayerAttack state")

func _deactivate_hurtbox():
	if hurtbox:
		hurtbox.monitoring = false
		hurtbox.monitorable = false
	else:
		push_error("Attempted to deactivate null hurtbox in PlayerAttack state")
