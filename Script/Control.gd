extends Control
@onready var animator = $Label/AnimatedSprite2D
	
func _physics_process(delta: float) -> void: 
	animator.play("default")
	
	if Input.is_action_just_pressed("Start"): 
		get_tree().change_scene_to_file("res://Scene/Forest.tscn")
	
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/Forest.tscn")
