extends Control

	
	
func _physics_process(delta: float) -> void: 
	if Input.is_action_just_pressed("Start"): 
		get_tree().change_scene_to_file("res://Scene/Tutorial.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Tutorial.tscn")
