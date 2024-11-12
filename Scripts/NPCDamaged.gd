extends State
class_name NPCDamaged

@export var sprite : AnimatedSprite2D
@export var invincibility_duration := 5.0

var invincibility_timer : Timer

func _ready():
	invincibility_timer = Timer.new()
	invincibility_timer.one_shot = true
	invincibility_timer.timeout.connect(_on_invincibility_timeout)
	add_child(invincibility_timer)

func Enter():
	print("Entering damaged state, enabling invincibility")
	# Get reference to stats and turn on invincibility
	var stats = owner.get_node("Stats") as NPCStats
	stats.invicibility = true
	
	# Play damage animation once
	sprite.play("Damage")
	sprite.animation_finished.connect(_on_animation_finished)
	
	# Start invincibility timer
	invincibility_timer.start(invincibility_duration)

	# Stop any current movement
	owner.velocity = Vector2.ZERO

func Exit():
	if sprite.animation_finished.is_connected(_on_animation_finished):
		sprite.animation_finished.disconnect(_on_animation_finished)
	# We don't want to stop the invincibility timer on exit
	# Removed: invincibility_timer.stop()

func _on_animation_finished():
	print("Damage animation finished!")
	Transition("Flee")

func _on_invincibility_timeout():
	print("Invincibility wore off!")
	var stats = owner.get_node("Stats") as NPCStats
	stats.invicibility = false

func Transition(newstate):
	print("Transitioning to: ", newstate)
	state_transition.emit(self, newstate)
