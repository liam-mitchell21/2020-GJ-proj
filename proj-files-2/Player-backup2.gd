extends RigidBody2D

signal hit

var speed = 300  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func start(pos):
	position = pos
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var velocity = Vector2.ZERO
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	if $Slowtimer.time_left > 0:
		speed = 50
	else:
		speed = 300
		
	position += velocity * delta

	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered(body):
	#print(body.get_name())
	if "Peds" in body.get_name():
		emit_signal("hit")
		$Slowtimer.start()
