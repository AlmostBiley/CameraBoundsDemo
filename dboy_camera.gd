class_name PlayerCamera
extends Camera2D

var curent_zoom : float = 1.0

@export var zoom_speed : float = 10.0

@export_range(0.05,1) var camera_zoom_smothing : float = 0.15 #the lower the number the more smothing there is

@export var max_zoom : float = 4
@export var min_zoom : float = 1
@export var target_camera: Node2D
var stop_zooming_left: bool = false
var stop_zooming_right: bool = false
var stop_zooming_top: bool = false
var stop_zooming_bottom: bool = false

func _process(delta: float) -> void:
	handle_zoom()
	
	if curent_zoom < min_zoom:
		curent_zoom = min_zoom #0.5

	if curent_zoom > max_zoom:
		curent_zoom = max_zoom

func handle_zoom():
	if Input.is_action_just_released("zoom_out"):
		stop_zooming_left = false
		stop_zooming_right = false
		stop_zooming_top = false
		stop_zooming_bottom = false
		curent_zoom += 0.001 * zoom_speed
		
	#if stop_zooming_bottom == true and stop_zooming_top == true and stop_zooming_right == true:
	#	return
	var z : float = self.zoom.x

	z = lerp(z,curent_zoom,camera_zoom_smothing)
	self.zoom = Vector2(z, z)

	if Input.is_action_just_released("zoom_in"):
		#if stop_zooming_bottom == true and stop_zooming_top == true and stop_zooming_right == true:
		#	return
		curent_zoom -= 0.001 * zoom_speed

func UpdateLimits(bounds: Array[ Vector2]) -> void:
	if bounds == []:
		return
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)

func _on_bruh_left_screen_entered() -> void:
	stop_zooming_left = true
	print("BRUH I CAN SEE TO MUCH LEFT")

func _on_bruh_bottom_screen_entered() -> void:
	stop_zooming_bottom = true
	print("BRUH I CAN SEE TO MUCH BOTTOM")

func _on_bruh_top_screen_entered() -> void:
	stop_zooming_top = true
	print("BRUH I CAN SEE TO MUCH TOP")

func _on_bruh_right_screen_entered() -> void:
	stop_zooming_right = true
	print("BRUH I CAN SEE TO MUCH RIGHT")
