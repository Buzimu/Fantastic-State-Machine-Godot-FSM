extends State
class_name NPCIdle

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("Idle")
	pass

func Update(_delta):
	pass
		

func Transition(newstate):
	state_transition.emit(self, newstate)
