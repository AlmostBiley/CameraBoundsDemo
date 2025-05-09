class_name CameraBounds

extends ReferenceRect

@onready var reference_rect: ReferenceRect = %ReferenceRect

var left_bound : float = -INF
var right_bound : float = INF
var top_bound : float = -INF
var bottom_bound : float = INF

var min_zoom : float = -INF

signal updated

func _ready() -> void:
	resized.connect(update)
	get_viewport().size_changed.connect(update)
	update()

func update() -> void:
	if size.x >= 0:
		left_bound = global_position.x
		right_bound = left_bound + size.x
	else:
		right_bound = global_position.x
		left_bound = right_bound - size.x
		
	if size.y >= 0:
		top_bound = global_position.y
		bottom_bound = top_bound + size.y
	else:
		bottom_bound = global_position.y
		top_bound = bottom_bound - size.y
	
	var max_camera_size := Vector2(right_bound - left_bound, bottom_bound - top_bound)
	var min_zoom_vect := get_viewport_rect().size / max_camera_size 
	min_zoom = max(min_zoom_vect.x, min_zoom_vect.y)
	
	updated.emit()
