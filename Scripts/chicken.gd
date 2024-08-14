extends CharacterBody2D
class_name Chicken

@onready var fsm = $FSM as FiniteStateMachine
@onready var hitbox: Area2D = $Hitbox
#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is almost empty 

func _ready():
	$Hitbox.health = 50
	$Hitbox.resistances = ["stun"]

func _die():
	#super() #calls _die() on base-class CharacterBase
	fsm.force_change_state("Die")

