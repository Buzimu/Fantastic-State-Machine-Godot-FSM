extends Node
class_name Chicken

@onready var fsm = $FSM as FiniteStateMachine

#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is almost empty 

func _die():
	#super() #calls _die() on base-class CharacterBase
	fsm.force_change_state("Die")


"""
@export var speed = 10
@onready var _animated_sprite = $AnimatedSprite2D
var chicken_walking = false
@onready var timer = $Timer  # Assuming the Timer node is a direct child of this node
var rand = RandomNumberGenerator.new()
var walk_direction = Vector2.ZERO

func _ready():
	_animated_sprite.play("chicken-idle")
	#timer.connect("timeout", self, "_on_Timer_timeout")

func does_chicken_walk():
	if not chicken_walking:
		if rand.randf() < 0.5:  # 50% chance to start walking
			chicken_walking = true
			_animated_sprite.play("chicken-walk")
			# Choose a random direction
			var angle = rand.randf_range(0, 2 * PI)
			walk_direction = Vector2(cos(angle), sin(angle)).normalized()
			# Set timer for a random duration less than 4 seconds and start it
			timer.start(rand.randf_range(1.0, 2.0))

func _physics_process(delta):
	does_chicken_walk()
	if chicken_walking:
		# Move the chicken in the chosen direction
		position += walk_direction * speed * delta



func _on_timer_timeout():
	chicken_walking = false
	_animated_sprite.play("chicken-idle")
"""
