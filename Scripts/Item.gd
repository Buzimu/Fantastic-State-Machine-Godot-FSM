extends Node2D

@export var item_id: int = 1
@export var magnetizable_delay := 2.0
@export var base_magnetic_speed := 100.0
@export var max_magnetic_speed := 400.0
@export var magnetic_acceleration := 2.0

var can_be_magnetically_pulled := false
var being_pulled := false
var pull_target = null
var current_speed := 0.0

func _ready() -> void:
	add_to_group("items")
	
	# Disable ALL collisions initially
	$ItemArea/CollisionShape2D.disabled = true
	
	# Start magnetizable timer
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = magnetizable_delay
	timer.timeout.connect(_on_magnetizable_timer_timeout)
	add_child(timer)
	timer.start()
	
	# Load item data
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
			item_data.spriteCoords.x * 32,
			item_data.spriteCoords.y * 32,
			32, 32
		)

func _physics_process(delta: float) -> void:
	if being_pulled and pull_target and can_be_magnetically_pulled:
		var direction = global_position.direction_to(pull_target.global_position)
		var distance = global_position.distance_to(pull_target.global_position)
		
		# Accelerate based on distance
		current_speed = min(current_speed + magnetic_acceleration, max_magnetic_speed)
		
		# Move towards player
		global_position += direction * current_speed * delta

func start_pull(target: Node2D) -> void:
	if can_be_magnetically_pulled and !being_pulled:
		pull_target = target
		being_pulled = true
		current_speed = base_magnetic_speed

func stop_pull() -> void:
	being_pulled = false
	pull_target = null
	current_speed = 0.0

func collect() -> void:
	# Only allow collection if magnetizable
	if !can_be_magnetically_pulled:
		return
		
	# Play sound
	var audio = AudioStreamPlayer2D.new()
	audio.stream = preload("res://Media/itempop.wav")
	get_tree().root.add_child(audio)
	audio.global_position = global_position
	audio.play()
	
	# Connect to finished signal to clean up the audio node
	audio.finished.connect(audio.queue_free)
	
	print("Item collected: ", ItemDB.get_item_data(item_id).name)
	queue_free()

func _on_magnetizable_timer_timeout() -> void:
	can_be_magnetically_pulled = true
	$ItemArea/CollisionShape2D.disabled = false
	
	# If we're already in range of a magnet, start pulling
	for area in $ItemArea.get_overlapping_areas():
		if area.name == "ItemMagnet":
			start_pull(area.get_parent().get_parent())

func _on_item_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox"):
		collect()
