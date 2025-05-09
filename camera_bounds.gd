class_name CameraBounds

extends Node2D

@onready var reference_rect: ReferenceRect = %ReferenceRect

var left_bound : float = -INF
var right_bound : float = INF
var top_bound : float = -INF
var bottom_bound : float = INF

var min_zoom : float = -INF

signal updated

func _ready() -> void:
	reference_rect.resized.connect(update)
	update()

func update() -> void:
	if reference_rect.size.x >= 0:
		left_bound = reference_rect.global_position.x
		right_bound = left_bound + reference_rect.size.x
	else:
		right_bound = reference_rect.global_position.x
		left_bound = right_bound - reference_rect.size.x
		
	if reference_rect.size.y >= 0:
		top_bound = reference_rect.global_position.y
		bottom_bound = top_bound + reference_rect.size.y
	else:
		bottom_bound = reference_rect.global_position.y
		top_bound = bottom_bound - reference_rect.size.y
	
	var max_camera_size := Vector2(right_bound - left_bound, bottom_bound - top_bound)
	var min_zoom_vect := get_viewport_rect().size / max_camera_size 
	min_zoom = max(min_zoom_vect.x, min_zoom_vect.y)
	
	updated.emit()
