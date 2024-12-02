extends CharacterBody2D

const light_needed = 600
const humid_needed = 50
const temp_needed_min = 18
const temp_needed_max = 26

var mouse_over : bool
var mouse_pos : Vector2 = Vector2.ZERO
var difference : Vector2

func _on_grab_zone_mouse_entered():
	mouse_over = true


func _on_grab_zone_mouse_exited():
	mouse_over = false
	
func _physics_process(delta):	
	difference = mouse_pos - get_global_mouse_position()
	
	if Input.is_action_pressed("Click") and mouse_over and difference != Vector2.ZERO:
		global_position -= difference
	
	mouse_pos = get_global_mouse_position()
