extends Node

export (PackedScene) var Peds

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func new_game():
	$Player.start($StartPosition.position)
	$PedSpawner/PedTimer.start()
	
	$HUD/PHONE/latestMessage.text = "or your boss might not be happy"
	$HUD/PHONE/secondMessage.text = "try your best to be on-time"
	$HUD/PHONE/thirdMessage.text = "Hello, and welcome"
	$HUD/PHONE/msg.text = "TIME UNTIL WORK:"
	$HUD/PHONE/Label.text = "NEW NOTIFICATION!"

func _on_PedTimer_timeout():
	# Create a Mob instance and add it to the scene.
	var ped = Peds.instance()
	add_child(ped)
	ped.position = $PedSpawner.position 
	# Set the mob's direction perpendicular to the path direction.
	var direction = $PedSpawner/PedPath.rotation
	# Set the velocity (speed & direction).
	ped.linear_velocity = Vector2(rand_range(ped.min_speed, ped.max_speed), 0)
	ped.linear_velocity = ped.linear_velocity.rotated(direction)
	

func _on_HUD_ded():
	$HUD/StartButton.visible = true

func _on_DirectionTrigger1_area_entered(area):
	print(area.get_name())
