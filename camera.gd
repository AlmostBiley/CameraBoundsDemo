extends Camera2D

const SPEED = 0.2
const SMOOTH_SPEED = 0.001
const ZOOM_BOUND_MIN = 0.2
const ZOOM_BOUND_MAX = 5.0

@export var bounds : CameraBounds

var zoom_target : float = 1.0
var zoom_tween : Tween
var max_zoom : float = INF

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_bounds(bounds)
	get_viewport().size_changed.connect(update_bounds)

func _process(delta: float) -> void:
	var dir : float = 0.0
	if Input.is_action_just_pressed("zoom_in"):
		dir = -1.0
	elif Input.is_action_just_pressed("zoom_out"):
		dir = 1.0
	if dir != 0.0:
		set_zoom_target(zoom_target + dir * SPEED)
		

func set_bounds(new_bounds : CameraBounds) -> void:
	bounds = new_bounds
	bounds.updated.connect(update_bounds)
	update_bounds()

func update_bounds() -> void:
	if bounds:
		limit_left = bounds.left_bound
		limit_right = bounds.right_bound
		limit_top = bounds.top_bound
		limit_bottom = bounds.bottom_bound
	var max_camera_size := Vector2(limit_right - limit_left, limit_bottom - limit_top)
	var max_zoom_vect := get_viewport_rect().size / max_camera_size 
	max_zoom = max(max_zoom_vect.x, max_zoom_vect.y)

func set_zoom_target(value : float) -> void:
	value = clampf(value, max(ZOOM_BOUND_MIN, max_zoom), ZOOM_BOUND_MAX)
	if zoom_target == value:
		return
	zoom_target = value
	if zoom_tween:
		zoom_tween.kill()
	zoom_tween = get_tree().create_tween()
	zoom_tween.tween_property(self, "zoom", zoom_target * Vector2.ONE, 0.3).set_ease(Tween.EASE_IN)
