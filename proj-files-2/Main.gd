extends Node

export (PackedScene) var Peds

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func new_game():
	$Player.start($StartPosition.position)
	$PedSpawner/PedTimer.start()

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
	

