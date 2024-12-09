extends Area2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	var item = area.get_parent()
	if item.is_in_group("items"):
		item.start_pull(get_parent().get_parent())  # Pull towards player

func _on_area_exited(area: Area2D) -> void:
	var item = area.get_parent()
	if item.is_in_group("items"):
		item.stop_pull()
