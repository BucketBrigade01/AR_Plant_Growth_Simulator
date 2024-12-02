extends Node

var time : String
var unix_time_val : float
var plant_picked : int

# Called when the node enters the scene tree for the first time.
func _ready():
	time = Time.get_datetime_string_from_system(false, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = Time.get_datetime_string_from_system(false, true)
