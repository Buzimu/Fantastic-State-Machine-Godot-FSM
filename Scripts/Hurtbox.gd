extends Area2D

func _ready():
	area_entered.connect(_on_area_entered)
	self.monitoring = false
	self.monitorable = false
	get_node("CollisionShape2D").visible = false

func _on_area_entered(area):
	if area.is_in_group("hitboxes"):
		print("Hurtbox sent a hit!")
		SignalManager.hit_occurred.emit(area, self)
		
