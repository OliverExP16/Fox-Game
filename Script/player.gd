extends CharacterBody2D

@onready var animated_sprite = $AnimatedPlayer;  

const GRAVITY: float = 1000.0 

const SPEED = 170.0 
const JUMP_VELOCITY = -380.0
const FLOW_VELOCITY = 50
var took_damage = false  

const ACCELERATION = 900.0
const FRICTION = 1400.0

const COYOTE_TIME: float = 0.10 
var coyote_timer: float = 0.0

const JUMP_BUFFER_TIMER: float = 0.15 
var jump_buffer_timer: float = 0.0

var Current_timer = 0 
var Limit_timer = 30 
var Limit_end = 120
@export var spawn_position: Vector2

var dead = false : 
	set(value):
		dead = value 
		if value == true: 
			respawn()

func respawn():
	global_position = spawn_position
	velocity = Vector2.ZERO
	took_damage = false
	
func _physics_process(delta: float) -> void: 
	var active = (
		Input.is_action_just_pressed("Left_Key_joy")
		or 
		Input.is_action_just_pressed("Right_Key_joy")
		or 
		Input.is_action_just_pressed("Jump_Key_joy")
	)
	
	if active: 
		Current_timer = 0 
	else: 
		Current_timer += delta 
		
	# Gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Jump
	if is_on_floor(): 
		coyote_timer = COYOTE_TIME
	else: 
		coyote_timer -= delta 
	
	if Input.is_action_just_pressed("Jump_Key_joy"): 
		jump_buffer_timer = JUMP_BUFFER_TIMER
	else: 
		jump_buffer_timer -= delta 
		
	if jump_buffer_timer > 0 and coyote_timer > 0: 
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer = 0 
		coyote_timer = 0 
		
	if Input.is_action_just_released("Jump_Key_joy") and velocity.y < 0: 
		velocity.y *= 0.5 
		
	# Move Left and Right 
	var direction := Input.get_axis("Left_Key_joy", "Right_Key_joy")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)	
		animated_sprite.flip_h = direction < 0; 
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	# Animationen
	if not is_on_floor():
		if velocity.y < -10:
			animated_sprite.play("Jump")
		elif velocity.y > 10:
			animated_sprite.play("Fall")
		else:
			animated_sprite.play("Jump") 
	else:
		if direction:
			animated_sprite.play("Run")
			animated_sprite.flip_h = direction < 0
		else:
			if Current_timer >= Limit_end: 
				animated_sprite.play("Idle_80")
			elif Current_timer >= Limit_timer: 
				animated_sprite.play("Idle_30")
			else: 
				animated_sprite.play("Idle")
		
	move_and_slide()
