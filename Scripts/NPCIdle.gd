extends State
class_name NPCIdle

@export var sprite : AnimatedSprite2D
@export var min_idle_time := 2.0
@export var max_idle_time := 5.0

var idle_timer : Timer

func _ready():
	idle_timer = Timer.new()
	idle_timer.one_shot = true
	idle_timer.connect("timeout", _on_idle_timer_timeout)
	add_child(idle_timer)

func Enter():
	sprite.play("Idle")
	_start_idle_timer()

func Exit():
	idle_timer.stop()

func Transition(newstate):
	state_transition.emit(self, newstate)

func _on_idle_timer_timeout():
	Transition("Wander")

func _start_idle_timer():
	var idle_duration = randf_range(min_idle_time, max_idle_time)
	idle_timer.start(idle_duration)
