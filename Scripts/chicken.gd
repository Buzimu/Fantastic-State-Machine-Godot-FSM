extends CharacterBody2D
class_name Chicken

@onready var fsm = $FSM as FiniteStateMachine

signal npc_hit(attacker: Node, damage: int)

func _ready():
	pass

func _die():
	queue_free()

func _on_hit(attackerhurtbox: Area2D, damage: int):
	print("Owie! ", damage, " Damage!")
	npc_hit.emit(attackerhurtbox.owner, damage)
	
	# Check invincibility before proceeding
	if $Stats.invicibility:
		print("Hit ignored due to invincibility!")
		return
		
	# Let Vitality handle the damage
	$Stats/Vitality._process_damage(attackerhurtbox, damage)
	
	# If we're still alive, go to damaged state
	if $Stats.health > 0:
		fsm.force_change_state("Damaged")
