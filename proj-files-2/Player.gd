extends KinematicBody2D

signal hit
var screen_size  # Size of the game window.
signal crash
signal win

export (int) var speed = 300

var velocity = Vector2()

func get_input():
	
	if $Slowtimer.time_left > 0:
		speed = 60
	else:
		speed = 300
	
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func start(pos):
	position = pos
	show()

func _on_Phitbox_body_entered(body):
	#print(body.get_name())
	if "Peds" in body.get_name():
		emit_signal("hit")
		$Slowtimer.start()
	if "Car" in body.get_name():
		emit_signal("crash")
		$Slowtimer.start()

func _on_Phitbox_area_entered(area):
	if "Work" in area.get_name():
		emit_signal("win")
