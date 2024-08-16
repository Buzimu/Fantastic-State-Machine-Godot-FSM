extends CharacterBody2D
class_name Player

@onready var fsm = $FSM as FiniteStateMachine

const DEATH_SCREEN = preload("res://Scenes/DeathScreen.tscn")

signal DirectionChanged(new_direction: Vector2)
#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is almost empty 


func _ready():
	pass

func _die():
	#super() #calls _die() on base-class CharacterBase	
	fsm.force_change_state("Die")
	var death_scene = DEATH_SCREEN.instantiate()
	add_child(death_scene)
