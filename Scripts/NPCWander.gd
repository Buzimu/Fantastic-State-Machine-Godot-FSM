extends State
class_name NPCWander

@export var move_speed := 20.0
@export var wander_radius := 100.0
@export var min_wander_time := 1.0
@export var max_wander_time := 3.0
@export var sprite : AnimatedSprite2D

var wander_timer : Timer
var target_position : Vector2
var npc : CharacterBody2D

func _ready():
	wander_timer = Timer.new()
	wander_timer.one_shot = true
	wander_timer.connect("timeout", _on_wander_timer_timeout)
	add_child(wander_timer)

func Enter():
	npc = get_parent().get_parent()
	sprite.play("Walk")
	_start_wander()

func Exit():
	wander_timer.stop()
	npc.velocity = Vector2.ZERO

func Update(_delta : float):
	if npc.global_position.distance_to(target_position) < 5:
		_start_wander()
	else:
		npc.velocity = npc.global_position.direction_to(target_position) * move_speed
		npc.move_and_slide()
		_update_animation()

func _start_wander():
	var random_angle = randf() * 2 * PI
	var random_radius = randf() * wander_radius
	target_position = npc.global_position + Vector2(cos(random_angle), sin(random_angle)) * random_radius
	wander_timer.start(randf_range(min_wander_time, max_wander_time))

func _update_animation():
	sprite.flip_h = npc.velocity.x < 0

func _on_wander_timer_timeout():
	Transition("Idle")

func Transition(new_state):
	state_transition.emit(self, new_state)
