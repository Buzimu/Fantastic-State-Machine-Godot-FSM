extends Area2D

@export var damage: int = 10
@export var effects: Array[String] = []

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Area2D) -> void:
	if hitbox.is_in_group("hitboxes"):
		SignalManager.hit_occurred.emit(hitbox, self)
		print("Hurtbox dealt ", damage, " damage")
		if effects:
			print("Hurtbox applied effects: ", effects)
