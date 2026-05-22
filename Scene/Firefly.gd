extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instant_spawn()

func _instant_spawn(): 
	lifetime = 0.1 
	
	await get_tree().create_timer(0.1).timeout
	
	lifetime = 60
