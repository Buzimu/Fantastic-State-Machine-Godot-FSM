extends Node2D

@export var item_id: int = 1

func _ready() -> void:
	var item_data = ItemDB.get_item_data(item_id)
	if item_data.is_empty():
		queue_free()
		return
		
	# Set sprite based on data
	var sprite = $Sprite2D
	var texture = load("res://Assets/" + item_data.spritesheet + ".png")
	if texture:
		sprite.texture = texture
		sprite.region_enabled = true
		sprite.region_rect = Rect2(
			item_data.spriteCoords.x * 32, # Assuming 32x32 sprites
			item_data.spriteCoords.y * 32,
			32, 32
		)
