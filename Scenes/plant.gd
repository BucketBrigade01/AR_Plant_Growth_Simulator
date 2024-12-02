extends CharacterBody2D

const light_needed = 600
const humid_needed = 50
const temp_needed_min = 18
const temp_needed_max = 26

var mouse_over : bool
var mouse_pos : Vector2 = Vector2.ZERO
var difference : Vector2
var current_light : String
var current_temp : String
var current_humid : String
var current_minute : int = 0
var next_minute : int = 0
var frame_count : int = 0
var unhealthy : bool = false

func _ready():
	if GlobalClock.plant_picked == 1:
		visible = false

func increment_frame():
	if !unhealthy:
		frame_count += 1
	else:
		frame_count -= 1
		
	if int(current_light) > 150 and int(current_humid) > 50 and int(current_temp) > 15:
		$AnimatedSprite2D.set_animation("healthy_growth")
		$AnimatedSprite2D.set_frame(frame_count)
		unhealthy = false
	elif unhealthy:
		$AnimatedSprite2D.set_animation("dead")
		$AnimatedSprite2D.set_frame(frame_count)
	else:
		$AnimatedSprite2D.set_animation("unhealthy_growth")
		$AnimatedSprite2D.set_frame(frame_count)
		unhealthy = true
	
		
func get_minutes_from_timestamp(timestamp: String) -> int:
	# Split the string at the space to separate date and time
	var time_part = timestamp.split(" ")[1]
	# Split the time part at the colon
	var time_components = time_part.split(":")
	
	# Get the minutes component (index 1) and convert it to an integer
	return int(time_components[1])

func _physics_process(delta):
	difference = mouse_pos - get_global_mouse_position()
	current_light = GameManager.light
	current_temp = GameManager.temp
	current_humid = GameManager.humid
	
	current_minute = next_minute
	next_minute = get_minutes_from_timestamp(GlobalClock.time)
	
	if current_minute != next_minute and current_light != "" and current_humid != "" and current_temp != "":
		increment_frame()
	
	if Input.is_action_pressed("Click") and mouse_over and difference != Vector2.ZERO:
		global_position -= difference
	
	mouse_pos = get_global_mouse_position()


func _on_grab_zone_mouse_entered():
	mouse_over = true


func _on_grab_zone_mouse_exited():
	mouse_over = false
