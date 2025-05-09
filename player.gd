extends CharacterBody2D

const SPEED = 300.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = dir * SPEED
	move_and_slide()
