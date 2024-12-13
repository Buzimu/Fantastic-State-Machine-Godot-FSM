extends State
class_name NPCDeath

@export var sprite : AnimatedSprite2D
@export var death_duration := 5.0
@export var drop_delay := 0.1  # Small delay before dying
@export var can_drop_bonus := true

var death_timer : Timer
var drop_timer : Timer
@onready var loot_table = owner.get_node("Interactions/Loot Table")

func _ready():
	death_timer = Timer.new()
	death_timer.one_shot = true
	death_timer.timeout.connect(_on_death_timer_timeout)
	add_child(death_timer)
	
	drop_timer = Timer.new()
	drop_timer.one_shot = true
	drop_timer.timeout.connect(_on_drop_timer_timeout)
	add_child(drop_timer)

func Enter():
	# Get reference to stats and turn on invincibility
	var stats = owner.get_node("Stats") as NPCStats
	stats.invicibility = true
	
	# Now connect to hit signal only during death state
	if owner.has_signal("npc_hit"):
		owner.npc_hit.connect(_on_corpse_hit)
	
	# Play death animation
	if sprite:
		sprite.play("Death")
	
	# Start death timer
	death_timer.start(death_duration)

func Exit():
	death_timer.stop()
	drop_timer.stop()
	can_drop_bonus = false
	
	# Disconnect the hit signal when exiting death state
	if owner.has_signal("npc_hit") and owner.npc_hit.is_connected(_on_corpse_hit):
		owner.npc_hit.disconnect(_on_corpse_hit)

func _on_death_timer_timeout():
	# Roll and spawn main loot
	var drops = loot_table.roll_loot("chicken")
	loot_table.spawn_drops(drops)
	
	# Start brief delay before death
	drop_timer.start(drop_delay)

func _on_drop_timer_timeout():
	# Now we can safely die
	owner._die()

func _on_corpse_hit(_attacker: Node, _damage: int):
	if can_drop_bonus:
		loot_table.roll_bonus_drop("chicken")
