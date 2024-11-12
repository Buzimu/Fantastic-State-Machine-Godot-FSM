extends Node
class_name NPCVitality

@onready var stats = get_parent() as NPCStats
@onready var fsm = get_parent().get_parent().get_node("FSM") as FiniteStateMachine

func _ready():
	# Remove this connection as we're handling damage through _on_hit
	# if owner.has_signal("npc_hit"):
	#     owner.npc_hit.connect(_process_damage)
	pass

func _process_damage(attacker: Node, damage: int) -> void:
	# Get fresh reference to stats since we're checking a variable
	var current_stats = get_parent() as NPCStats
	
	# Check if we can take damage
	if current_stats.invicibility:
		print("Damage blocked by invincibility!")
		return
		
	# Process the damage
	current_stats.health -= damage
	print("Health remaining: ", current_stats.health)
	
	# Check for death
	if current_stats.health <= 0:
		fsm.force_change_state("Death")
