class_name PlayerInteractionsHost 
extends Node2D

@onready var player : Player
@onready var sprite : AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent() as Player
	player.DirectionChanged.connect(UpdateDirection)



func UpdateDirection(new_direction: Vector2) -> void:
	match new_direction:
		Vector2.RIGHT:
			rotation_degrees = 0		
		Vector2.LEFT:
			rotation_degrees = 180
		
		#Vector2.UP:
			#rotation_degrees = -90
		#Vector2.DOWN:
			#rotation_degrees = 90		
		#_:
			#rotation_degrees = 0
