extends KinematicBody2D

signal hit

var Ospeed = 10
var speed = 10  # How fast the player will move (pixels/sec).
var accel = 1
var motion = Vector2.ZERO

var screen_size  # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func start(pos):
	position = pos
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO: 
		apply_friction(accel * delta)
	else: 
		apply_movement(axis * accel * delta)
		
		
		
	if $Slowtimer.time_left > 0:
		speed = speed*0.1
	else:
		speed = Ospeed
		
	
	motion = move_and_slide(motion)
		
	if axis.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = axis.x < 0
	elif axis.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = axis.y > 0

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
		
func apply_movement(acceleration):
	motion += acceleration
	motion += motion.clamped(speed)



func _on_Player_body_entered(body):
	#print(body.get_name())
	if "Peds" in body.get_name():
		emit_signal("hit")
		$Slowtimer.start()
