extends Control

var plant_selected = false

func _process(delta):
	if plant_selected:
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_plant_button_pressed():
	plant_selected = true
	GlobalClock.plant_picked = 0



func _on_p_lant_2_button_pressed():
	plant_selected = true
	GlobalClock.plant_picked = 1
	
