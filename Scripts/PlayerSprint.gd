extends State
class_name PlayerSprint

@export var movespeed := 125  # 1.5 times the walking speed
@export var sprite : AnimatedSprite2D

var player : CharacterBody2D

func Enter():
	print("Entered the Sprinting State")
	player = get_parent().get_parent()
	if player == null:
		push_error("Error: No node found in the 'Player' group.")
	sprite.play("Sprint")

func Update(_delta : float):
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	# Adjust the character's flip_h property based on direction
	if input_dir.x != 0:
		sprite.flip_h = input_dir.x < 0
	Move(input_dir)
	
	# Update facing direction
	if input_dir != Vector2.ZERO:
		player.DirectionChanged.emit(input_dir)
	
	if not Input.is_action_pressed("Sprint"):
		Transition("Walk")
	elif input_dir.length() <= 0:
		Transition("Idle")
	elif Input.is_action_just_pressed("Attack"):
		Transition("Attack")

func Move(input_dir):
	player.velocity = input_dir * movespeed
	player.move_and_slide()

func Transition(newstate):
	state_transition.emit(self, newstate)
