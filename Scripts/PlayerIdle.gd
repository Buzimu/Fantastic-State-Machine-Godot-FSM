extends State
class_name PlayerIdle

@export var sprite : AnimatedSprite2D

func Enter():
	print("Entered the Idle State")
	sprite.play("Idle")
	pass

func Update(_delta):
	if(Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown").normalized()):
		Transition("Walk")
		
	if Input.is_action_just_pressed("Attack"):
		Transition("Attack")

func Transition(newstate):
	state_transition.emit(self, newstate)
