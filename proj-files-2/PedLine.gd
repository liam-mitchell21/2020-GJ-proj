extends Position2D

export (PackedScene) var Peds

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_PedTimer_timeout():
	var spawnloc = $Spawn
	# Create a Mob instance and add it to the scene.
	var mob = Peds.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $".".rotation
	# Set the mob's position to a random location.
	mob.position = spawnloc.position
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
