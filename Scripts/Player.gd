extends CharacterBody2D
class_name Player

@onready var fsm = $FSM as FiniteStateMachine
@onready var hurtbox: Area2D = $Hurtbox

const DEATH_SCREEN = preload("res://Scenes/DeathScreen.tscn")

#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is almost empty 
func _ready():
	$Hurtbox.damage = 20
	$Hurtbox.effects = ["stun", "knockback"]

func _die():
	#super() #calls _die() on base-class CharacterBase
	
	fsm.force_change_state("Die")
	var death_scene = DEATH_SCREEN.instantiate()
	add_child(death_scene)
