extends Camera2D

const SPEED = 0.2
const ZOOM_BOUND_MIN = 0.2
const ZOOM_BOUND_MAX = 5.0

@export var bounds : CameraBounds

var zoom_target : float = 1.0
var zoom_tween : Tween

func _ready() -> void:
	set_bounds(bounds)

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
	if zoom.x < bounds.min_zoom:
		if zoom_tween:
			zoom_tween.kill()
		zoom = Vector2(bounds.min_zoom, bounds.min_zoom)

func set_zoom_target(value : float) -> void:
	value = clampf(value, max(ZOOM_BOUND_MIN, bounds.min_zoom), ZOOM_BOUND_MAX)
	if zoom_target == value:
		return
	zoom_target = value
	if zoom_tween:
		zoom_tween.kill()
	zoom_tween = get_tree().create_tween()
	zoom_tween.tween_property(self, "zoom", zoom_target * Vector2.ONE, 0.3).set_ease(Tween.EASE_IN)
