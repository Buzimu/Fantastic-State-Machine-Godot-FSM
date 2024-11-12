extends State
class_name NPCDeath

@export var sprite : AnimatedSprite2D
@export var death_duration := 5.0

var death_timer : Timer

func _ready():
	death_timer = Timer.new()
	death_timer.one_shot = true
	death_timer.timeout.connect(_on_death_timer_timeout)
	add_child(death_timer)

func Enter():
	print("Uh Oh! ", owner , " died!")
	# Get reference to stats and turn on invincibility
	var stats = owner.get_node("Stats") as NPCStats
	stats.invicibility = true
	
	# Turn off hitbox
	var hitbox = owner.get_node("Interactions/NPCHitbox")
	if hitbox:
		hitbox.set_deferred("monitoring", false)
		hitbox.set_deferred("monitorable", false)
	
	# Play death animation
	if sprite:
		sprite.play("Death")
	
	# Start death timer
	death_timer.start(death_duration)

func Exit():
	death_timer.stop()

func _on_death_timer_timeout():
	owner._die()
