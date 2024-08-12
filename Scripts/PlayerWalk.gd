extends State
class_name PlayerWalking

@export var movespeed := 75
var player : CharacterBody2D
@export var sprite : AnimatedSprite2D
var is_Sprinting := bool(false)

func Enter():
	print("Entered the Walking State")
	player = get_parent().get_parent()
	if player == null:
		push_error("Error: No node found in the 'Player' group.")
	sprite.play("Walk")

func Update(_delta : float):
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	# Adjust the character's flip_h property based on direction
	if input_dir.x != 0:
		sprite.flip_h = input_dir.x < 0
	Move(input_dir)

	if Input.is_action_pressed("Sprint"):
		Transition("Sprint")
	elif input_dir.length() <= 0:
		Transition("Idle")
	elif Input.is_action_just_pressed("Attack"):
		Transition("Attack")

func Move(input_dir):
	player.velocity = input_dir * movespeed
	player.move_and_slide()

func Transition(newstate):
	state_transition.emit(self, newstate)
